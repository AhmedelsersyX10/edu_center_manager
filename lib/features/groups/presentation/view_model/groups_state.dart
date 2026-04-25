part of 'groups_cubit.dart';

@immutable
sealed class GroupsState {}

final class GroupsInitial extends GroupsState {}

final class GroupsLoading extends GroupsState {}

final class GroupsLoaded extends GroupsState {
  final List<GroupModel> allGroups;
  final List<GroupModel> filteredGroups;
  final List<TeacherModel> teachers;
  final Map<String, int> studentCountByGroupId;
  final Map<String, List<GroupScheduleModel>> schedulesByGroupId;
  final String searchQuery;
  final String selectedTeacherId;

  GroupsLoaded({
    required this.allGroups,
    required this.filteredGroups,
    required this.teachers,
    this.studentCountByGroupId = const {},
    required this.schedulesByGroupId,
    this.searchQuery = '',
    this.selectedTeacherId = 'all',
  });
}

final class GroupsError extends GroupsState {
  final String message;
  GroupsError(this.message);
}
