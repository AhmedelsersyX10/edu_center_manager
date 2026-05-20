enum AttendanceStatus { present, absent, late, excused }

extension AttendanceStatusX on AttendanceStatus {
  String get value => name;
}

class AttendanceModel {
  final String id;
  final String studentId;
  final String groupId;
  final DateTime date;
  final AttendanceStatus status;

  const AttendanceModel({
    required this.id,
    required this.studentId,
    required this.groupId,
    required this.date,
    required this.status,
  });

  factory AttendanceModel.fromJson(Map<String, dynamic> json) => AttendanceModel(
    id: json['id']?.toString() ?? '',
    studentId: json['student_id']?.toString() ?? '',
    groupId: json['group_id']?.toString() ?? '',
    date: DateTime.parse(json['date'].toString()),
    status: AttendanceStatus.values.byName(json['status'].toString()),
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'student_id': studentId,
    'group_id': groupId,
    'date': _formatDateOnly(date),
    'status': status.value,
  };

  Map<String, dynamic> toUpsertJson() => {
    'student_id': studentId,
    'group_id': groupId,
    'date': _formatDateOnly(date),
    'status': status.value,
  };

  AttendanceModel copyWith({
    String? id,
    String? studentId,
    String? groupId,
    DateTime? date,
    AttendanceStatus? status,
  }) {
    return AttendanceModel(
      id: id ?? this.id,
      studentId: studentId ?? this.studentId,
      groupId: groupId ?? this.groupId,
      date: date ?? this.date,
      status: status ?? this.status,
    );
  }

  static String _formatDateOnly(DateTime date) {
    final normalized = DateTime(date.year, date.month, date.day);
    return normalized.toIso8601String().split('T').first;
  }
}
