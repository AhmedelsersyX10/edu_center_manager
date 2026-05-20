import 'package:edu_center_manager/features/attendance/data/models/attendance_model.dart';
import 'package:edu_center_manager/features/students/data/models/student_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AttendanceService {
  final SupabaseClient _client;

  AttendanceService({SupabaseClient? client})
      : _client = client ?? Supabase.instance.client;

  static const String _studentsTable = 'students';
  static const String _groupStudentsTable = 'group_students';
  static const String _attendanceTable = 'attendance';

  Future<List<StudentModel>> getStudentsByGroup(String groupId) async {
    final response = await _client
        .from(_groupStudentsTable)
        .select('students!inner(*)')
        .eq('group_id', groupId)
        .order('created_at', referencedTable: _studentsTable, ascending: false);

    return (response as List)
        .map((row) => (row as Map)['students'])
        .where((studentJson) => studentJson != null)
        .map(
          (studentJson) =>
              StudentModel.fromJson(Map<String, dynamic>.from(studentJson as Map)),
        )
        .toList();
  }

  Future<List<AttendanceModel>> getAttendanceByDate(DateTime date, String groupId) async {
    final response = await _client
        .from(_attendanceTable)
        .select()
        .eq('date', _formatDateOnly(date))
        .eq('group_id', groupId);

    return (response as List)
        .map((json) => AttendanceModel.fromJson(Map<String, dynamic>.from(json as Map)))
        .toList();
  }

  Future<AttendanceModel> updateAttendance({
    required String studentId,
    required String groupId,
    required AttendanceStatus status,
    required DateTime date,
  }) async {
    final normalizedDate = _formatDateOnly(date);
    final payload = AttendanceModel(
      id: '',
      studentId: studentId,
      groupId: groupId,
      date: date,
      status: status,
    ).toUpsertJson();
    final existing = await _client
        .from(_attendanceTable)
        .select()
        .eq('student_id', studentId)
        .eq('group_id', groupId)
        .eq('date', normalizedDate)
        .limit(1);

    if ((existing as List).isNotEmpty) {
      final existingId = (existing.first as Map)['id']?.toString();
      final updated = await _client
          .from(_attendanceTable)
          .update({'status': status.value})
          .eq('id', existingId!)
          .select()
          .single();
      return AttendanceModel.fromJson(Map<String, dynamic>.from(updated as Map));
    }

    final inserted = await _client
        .from(_attendanceTable)
        .insert(payload)
        .select()
        .single();
    return AttendanceModel.fromJson(Map<String, dynamic>.from(inserted as Map));
  }

  String _formatDateOnly(DateTime date) {
    final normalized = DateTime(date.year, date.month, date.day);
    return normalized.toIso8601String().split('T').first;
  }
}
