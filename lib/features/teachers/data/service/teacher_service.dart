import 'package:edu_center_manager/features/teachers/data/models/teacher_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class TeacherService {
  final SupabaseClient client;

  TeacherService({SupabaseClient? client}) : client = client ?? Supabase.instance.client;

  static const String table = 'teachers';

  Future<List<TeacherModel>> getTeachers() async {
    final response = await client.from(table).select().order('name', ascending: true);
    return (response as List)
        .map((json) => TeacherModel.fromJson(Map<String, dynamic>.from(json as Map)))
        .toList();
  }

  Future<TeacherModel> addTeacher(TeacherModel teacher) async {
    final response = await client
        .from(table)
        .insert(teacher.toTeacherTableJson())
        .select()
        .single();
    return TeacherModel.fromJson(Map<String, dynamic>.from(response as Map));
  }

  Future<TeacherModel> updateTeacher(TeacherModel teacher) async {
    final response = await client
        .from(table)
        .update(teacher.toTeacherTableJson())
        .eq('id', teacher.id)
        .select()
        .single();
    return TeacherModel.fromJson(Map<String, dynamic>.from(response as Map));
  }

  Future<TeacherModel> deleteTeacher(String id) async {
    final response = await client.from(table).delete().eq('id', id).select().single();
    return TeacherModel.fromJson(Map<String, dynamic>.from(response as Map));
  }
}
