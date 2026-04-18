import 'package:edu_center_manager/features/teachers/data/models/teacher_model.dart';

abstract class TeacherRepo {
  Future<List<TeacherModel>> getTeachers();
  Future<TeacherModel> addTeacher(TeacherModel teacher);
  Future<TeacherModel> updateTeacher(TeacherModel teacher);
  Future<TeacherModel> deleteTeacher(String id);
}
