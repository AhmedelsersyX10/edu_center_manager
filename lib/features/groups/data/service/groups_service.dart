import 'package:edu_center_manager/features/groups/data/models/group_model.dart';
import 'package:edu_center_manager/features/groups/data/models/group_schedule_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class GroupsService {
  GroupsService({SupabaseClient? client}) : client = client ?? Supabase.instance.client;
  final SupabaseClient client;
  static const String table = 'groups';
  static const String schedulesTable = 'group_schedules';
  static const String groupStudentsTable = 'group_students';
  static const String groupId = 'group_id';

  Future<List<GroupModel>> getGroups() async {
    final response = await client.from(table).select();
    final responseMap = response
        .map((json) => GroupModel.fromJson(Map<String, dynamic>.from(json as Map)))
        .toList();
    return responseMap;
  }

  Future<GroupModel> addGroup(GroupModel group) async {
    final response = await client.from(table).insert(group.toGroupTableJson()).select().single();
    return GroupModel.fromJson(Map<String, dynamic>.from(response as Map));
  }

  Future<GroupModel> updateGroup(GroupModel group) async {
    final response = await client
        .from(table)
        .update(group.toGroupTableJson())
        .eq('id', group.id)
        .select()
        .single();
    return GroupModel.fromJson(Map<String, dynamic>.from(response as Map));
  }

  Future<GroupModel> deleteGroup(GroupModel group) async {
    await client.from(groupStudentsTable).delete().eq('group_id', group.id);
    await client.from(schedulesTable).delete().eq('group_id', group.id);
    final response = await client.from(table).delete().eq('id', group.id).select().single();
    return GroupModel.fromJson(Map<String, dynamic>.from(response as Map));
  }

  Future<List<GroupScheduleModel>> getAllSchedules() async {
    final response = await client.from(schedulesTable).select();
    return response
        .map((json) => GroupScheduleModel.fromJson(Map<String, dynamic>.from(json as Map)))
        .toList();
  }

  Future<Map<String, int>> getStudentCountsByGroupId() async {
    final response = await client.from(groupStudentsTable).select(groupId);
    final map = <String, int>{};
    for (final row in response) {
      final groupId = (row as Map)['group_id']?.toString();
      if (groupId == null || groupId.isEmpty) continue;
      map[groupId] = (map[groupId] ?? 0) + 1;
    }
    return map;
  }

  Future<void> replaceSchedulesForGroup(String id, List<GroupScheduleModel> schedules) async {
    await client.from(schedulesTable).delete().eq(groupId, id);
    if (schedules.isEmpty) return;
    final rows = schedules.map((s) => s.copyWith(groupId: id).toGroupScheduleTableJson()).toList();
    await client.from(schedulesTable).insert(rows);
  }
}
