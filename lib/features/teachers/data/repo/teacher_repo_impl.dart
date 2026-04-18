import 'package:edu_center_manager/features/teachers/data/models/teacher_model.dart';
import 'package:edu_center_manager/features/teachers/data/repo/teacher_repo.dart';
import 'package:edu_center_manager/features/teachers/data/service/teacher_service.dart';

class TeacherRepoImpl implements TeacherRepo {
  final TeacherService teacherService;

  TeacherRepoImpl({TeacherService? teacherService})
    : teacherService = teacherService ?? TeacherService();

  @override
  Future<List<TeacherModel>> getTeachers() async {
    try {
      return await teacherService.getTeachers();
    } catch (e) {
      throw Exception('فشل في تحميل بيانات المدرسين');
    }
  }

  @override
  Future<TeacherModel> addTeacher(TeacherModel teacher) async {
    try {
      return await teacherService.addTeacher(teacher);
    } catch (e) {
      throw Exception('فشل في إضافة المدرس');
    }
  }

  @override
  Future<TeacherModel> updateTeacher(TeacherModel teacher) async {
    try {
      return await teacherService.updateTeacher(teacher);
    } catch (e) {
      throw Exception('فشل في تحديث بيانات المدرس');
    }
  }

  @override
  Future<TeacherModel> deleteTeacher(String id) async {
    try {
      return await teacherService.deleteTeacher(id);
    } catch (e) {
      throw Exception('فشل في حذف المدرس');
    }
  }
}
