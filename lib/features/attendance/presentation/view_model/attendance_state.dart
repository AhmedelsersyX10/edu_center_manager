import 'package:edu_center_manager/features/attendance/data/models/attendance_model.dart';
import 'package:edu_center_manager/features/groups/data/models/group_model.dart';
import 'package:edu_center_manager/features/students/data/models/student_model.dart';

abstract class AttendanceState {}

class AttendanceInitial extends AttendanceState {}

class AttendanceLoading extends AttendanceState {}

class AttendanceLoaded extends AttendanceState {
  final List<GroupModel> groups;
  final List<StudentModel> students;
  final List<StudentModel> filteredStudents;
  final Map<String, AttendanceStatus> attendanceByStudentId;
  final String selectedGroupId;
  final DateTime selectedDate;
  final String searchQuery;
  final AttendanceStatus? selectedStatusFilter;
  final Map<String, bool> rowLoadingByStudentId;
  final bool hasUndoAction;

  AttendanceLoaded({
    required this.groups,
    required this.students,
    required this.filteredStudents,
    required this.attendanceByStudentId,
    required this.selectedGroupId,
    required this.selectedDate,
    this.searchQuery = '',
    this.selectedStatusFilter,
    this.rowLoadingByStudentId = const {},
    this.hasUndoAction = false,
  });
}

class AttendanceError extends AttendanceState {
  final String message;
  AttendanceError(this.message);
}
