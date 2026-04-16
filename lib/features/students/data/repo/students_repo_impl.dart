import 'package:edu_center_manager/features/students/data/models/student_model.dart';
import 'package:edu_center_manager/features/students/data/services/students_service.dart';
import 'students_repo.dart';

class StudentsRepoImpl implements StudentsRepo {
  final StudentsService studentsService;

  StudentsRepoImpl({StudentsService? studentsService})
    : studentsService = studentsService ?? StudentsService();

  @override
  Future<List<StudentModel>> getStudents() async {
    try {
      return await studentsService.getStudents();
    } catch (e) {
      throw Exception('فشل في تحميل بيانات الطلاب');
    }
  }

  @override
  Future<StudentModel> addStudent(StudentModel student) async {
    try {
      return await studentsService.addStudent(student);
    } catch (e) {
      throw Exception('فشل في إضافة الطالب');
    }
  }

  @override
  Future<StudentModel> updateStudent(StudentModel student) async {
    try {
      return await studentsService.updateStudent(student);
    } catch (e) {
      throw Exception('فشل في تحديث بيانات الطالب');
    }
  }

  @override
  Future<StudentModel> deleteStudent(String id) async {
    try {
      return await studentsService.deleteStudent(id);
    } catch (e) {
      throw Exception('فشل في حذف الطالب');
    }
  }
}
