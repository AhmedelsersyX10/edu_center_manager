import 'package:bloc/bloc.dart';
import 'package:edu_center_manager/features/groups/data/models/group_model.dart';
import 'package:edu_center_manager/features/groups/data/models/group_schedule_model.dart';
import 'package:edu_center_manager/features/groups/data/repo/groups_repo.dart';
import 'package:edu_center_manager/features/teachers/data/models/teacher_model.dart';
import 'package:edu_center_manager/features/teachers/data/repo/teacher_repo.dart';
import 'package:meta/meta.dart';

part 'groups_state.dart';

class GroupsCubit extends Cubit<GroupsState> {
  final GroupsRepo groupsRepo;
  final TeacherRepo teachersRepo;

  GroupsCubit(this.groupsRepo, this.teachersRepo) : super(GroupsInitial());

  List<GroupModel> allGroups = [];
  List<TeacherModel> allTeachers = [];
  List<GroupScheduleModel> allSchedules = [];
  Map<String, int> studentCountByGroupId = {};
  String searchQuery = '';
  String selectedTeacherId = 'all';
  static const String filterAll = 'all';

  Future<void> getGroups() async {
    emit(GroupsLoading());
    try {
      await _reloadAll();
    } catch (e) {
      _emitErrorState(e);
    }
  }

  Future<void> addGroup(GroupModel model, List<GroupScheduleModel> schedules) async {
    emit(GroupsLoading());
    try {
      final newGroup = await groupsRepo.addGroup(model);
      await groupsRepo.replaceSchedulesForGroup(newGroup.id, schedules);
      allGroups.insert(0, newGroup);
      _emitLoadedState();
    } catch (e) {
      _emitErrorState(e);
    }
  }

  Future<void> updateGroup(GroupModel model, List<GroupScheduleModel> schedules) async {
    emit(GroupsLoading());
    try {
      await groupsRepo.updateGroup(model);
      await groupsRepo.replaceSchedulesForGroup(model.id, schedules);
      await _reloadAll();
    } catch (e) {
      _emitErrorState(e);
    }
  }

  Future<void> deleteGroup(GroupModel model) async {
    emit(GroupsLoading());
    try {
      await groupsRepo.deleteGroup(model);
      await _reloadAll();
    } catch (e) {
      _emitErrorState(e);
    }
  }

  Future<void> refreshStudentCounts() async {
    emit(GroupsLoading());
    try {
      studentCountByGroupId = await groupsRepo.getStudentCountsByGroupId();
      _emitLoadedState();
    } catch (e) {
      _emitErrorState(e);
    }
  }

  void searchGroups(String query) {
    searchQuery = query;
    _emitLoadedState();
  }

  void filterGroups({String? teacherId}) {
    if (teacherId != null) {
      selectedTeacherId = teacherId;
    }
    if (state is GroupsLoaded || state is GroupsInitial) {
      _emitLoadedState();
    }
  }

  Future<void> _reloadAll() async {
    allGroups = await groupsRepo.getGroups();
    allTeachers = await teachersRepo.getTeachers();
    allSchedules = await groupsRepo.getAllSchedules();
    studentCountByGroupId = await groupsRepo.getStudentCountsByGroupId();
    _emitLoadedState();
  }

  void _emitLoadedState() {
    var filterd = allGroups;
    if (selectedTeacherId != filterAll) {
      filterd = filterd.where((groups) => groups.teacherId == selectedTeacherId).toList();
    }
    if (searchQuery.trim().isNotEmpty) {
      final query = searchQuery.trim().toLowerCase();
      filterd = filterd.where((group) => group.name.toLowerCase().contains(query)).toList();
    }

    emit(
      GroupsLoaded(
        allGroups: allGroups,
        filteredGroups: filterd,
        teachers: allTeachers,
        schedulesByGroupId: _schedulesByGroupId(),
        studentCountByGroupId: Map<String, int>.from(studentCountByGroupId),
        searchQuery: searchQuery,
        selectedTeacherId: selectedTeacherId,
      ),
    );
  }

  Map<String, List<GroupScheduleModel>> _schedulesByGroupId() {
    final map = <String, List<GroupScheduleModel>>{};
    for (final schedule in allSchedules) {
      if (schedule.groupId.isEmpty) continue;
      map.putIfAbsent(schedule.groupId, () => []).add(schedule);
    }
    for (final list in map.values) {
      list.sort((a, b) {
        final byDay = a.day.index.compareTo(b.day.index);
        if (byDay != 0) return byDay;
        return a.fromTime.compareTo(b.fromTime);
      });
    }
    return map;
  }

  void _emitErrorState(Object e) => emit(GroupsError(_errorMessage(e)));

  String _errorMessage(Object error) {
    final message = error.toString();
    if (message.startsWith('Exception: ')) {
      return message.substring(11);
    }
    return message;
  }
}
