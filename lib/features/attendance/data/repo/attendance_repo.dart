import 'package:edu_center_manager/features/attendance/data/models/attendance_model.dart';
import 'package:edu_center_manager/features/students/data/models/student_model.dart';

abstract class AttendanceRepo {
  Future<List<StudentModel>> getStudentsByGroup(String groupId);
  Future<List<AttendanceModel>> getAttendanceByDate(DateTime date, String groupId);
  Future<AttendanceModel> updateAttendance({
    required String studentId,
    required String groupId,
    required AttendanceStatus status,
    required DateTime date,
  });
}
