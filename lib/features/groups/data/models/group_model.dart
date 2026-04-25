class GroupModel {
  final String id;
  final String name;
  final String? teacherId;
  final int monthlyFee;
  final int maxStudents;
  final String? description;

  const GroupModel({
    required this.id,
    required this.name,
    this.teacherId,
    this.monthlyFee = 0,
    this.maxStudents = 30,
    this.description,
  });

  factory GroupModel.fromJson(Map<String, dynamic> json) => GroupModel(
    id: json['id'],
    name: json['name'],
    teacherId: json['teacher_id'],
    monthlyFee: (json['monthly_fee'] ?? 0),
    maxStudents: json['max_students'] ?? 30,
    description: json['description'],
  );

  Map<String, dynamic> toGroupTableJson() => {
    'name': name,
    'teacher_id': teacherId,
    'monthly_fee': monthlyFee,
    'max_students': maxStudents,
    'description': description,
  };

  GroupModel copyWith({
    String? id,
    String? name,
    String? courseId,
    String? teacherId,
    int? monthlyFee,
    int? maxStudents,
    String? description,
  }) {
    return GroupModel(
      id: id ?? this.id,
      name: name ?? this.name,
      teacherId: teacherId ?? this.teacherId,
      monthlyFee: monthlyFee ?? this.monthlyFee,
      maxStudents: maxStudents ?? this.maxStudents,
      description: description ?? this.description,
    );
  }
}
