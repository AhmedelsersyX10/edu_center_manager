import 'package:edu_center_manager/features/groups/data/models/group_model.dart';
import 'package:edu_center_manager/features/groups/data/models/group_schedule_model.dart';
import 'package:edu_center_manager/features/groups/data/repo/groups_repo.dart';
import 'package:edu_center_manager/features/groups/data/service/groups_service.dart';

class GroupsRepoImpl implements GroupsRepo {
  final GroupsService groupsService;

  GroupsRepoImpl({GroupsService? groupsService}) : groupsService = groupsService ?? GroupsService();

  @override
  Future<List<GroupModel>> getGroups() async {
    try {
      return await groupsService.getGroups();
    } catch (e) {
      throw Exception('فشل في تحميل بيانات المجموعات');
    }
  }

  @override
  Future<GroupModel> addGroup(GroupModel model) async {
    try {
      return await groupsService.addGroup(model);
    } catch (e) {
      throw Exception('فشل في إضافة المجموعة');
    }
  }

  @override
  Future<GroupModel> updateGroup(GroupModel model) async {
    try {
      return groupsService.updateGroup(model);
    } catch (e) {
      throw Exception('فشل في تحديث بيانات المجموعة');
    }
  }

  @override
  Future<GroupModel> deleteGroup(GroupModel model) async {
    try {
      return groupsService.deleteGroup(model);
    } catch (e) {
      throw Exception('فشل في حذف المجموعة');
    }
  }

  @override
  Future<List<GroupScheduleModel>> getAllSchedules() async {
    try {
      return groupsService.getAllSchedules();
    } catch (e) {
      throw Exception('فشل في تحميل مواعيد المجموعات');
    }
  }

  @override
  Future<Map<String, int>> getStudentCountsByGroupId() async {
    try {
      return groupsService.getStudentCountsByGroupId();
    } catch (e) {
      throw Exception('فشل في تحميل عدد طلاب المجموعات');
    }
  }

  @override
  Future<void> replaceSchedulesForGroup(String groupId, List<GroupScheduleModel> schedules) async {
    try {
      await groupsService.replaceSchedulesForGroup(groupId, schedules);
    } catch (e) {
      throw Exception('فشل في حفظ مواعيد المجموعة');
    }
  }
}
