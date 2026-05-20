import 'package:edu_center_manager/features/attendance/data/models/attendance_model.dart';
import 'package:edu_center_manager/features/attendance/data/repo/attendance_repo.dart';
import 'package:edu_center_manager/features/attendance/data/service/attendance_service.dart';
import 'package:edu_center_manager/features/students/data/models/student_model.dart';

class AttendanceRepositoryImpl implements AttendanceRepo {
  final AttendanceService _dataSource;

  AttendanceRepositoryImpl({AttendanceService? dataSource})
    : _dataSource = dataSource ?? AttendanceService();

  @override
  Future<List<StudentModel>> getStudentsByGroup(String groupId) async {
    try {
      return await _dataSource.getStudentsByGroup(groupId);
    } catch (e) {
      throw Exception('فشل في تحميل طلاب المجموعة');
    }
  }

  @override
  Future<List<AttendanceModel>> getAttendanceByDate(DateTime date, String groupId) async {
    try {
      return await _dataSource.getAttendanceByDate(date, groupId);
    } catch (e) {
      throw Exception('فشل في تحميل الحضور لهذا اليوم');
    }
  }

  @override
  Future<AttendanceModel> updateAttendance({
    required String studentId,
    required String groupId,
    required AttendanceStatus status,
    required DateTime date,
  }) async {
    try {
      return await _dataSource.updateAttendance(
        studentId: studentId,
        groupId: groupId,
        status: status,
        date: date,
      );
    } catch (e) {
      throw Exception('فشل في تحديث حالة الحضور');
    }
  }
}
