import 'package:edu_center_manager/features/groups/data/models/group_model.dart';
import 'package:edu_center_manager/features/groups/data/models/group_schedule_model.dart';

abstract class GroupsRepo {
  Future<List<GroupModel>> getGroups();
  Future<GroupModel> addGroup(GroupModel model);
  Future<GroupModel> updateGroup(GroupModel model);
  Future<void> deleteGroup(GroupModel model);
  Future<List<GroupScheduleModel>> getAllSchedules();
  Future<Map<String, int>> getStudentCountsByGroupId();
  Future<void> replaceSchedulesForGroup(String groupId, List<GroupScheduleModel> schedules);
}
