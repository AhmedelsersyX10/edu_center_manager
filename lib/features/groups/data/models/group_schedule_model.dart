class GroupScheduleModel {
  final String id;
  final String groupId;
  final String day;
  final String fromTime;
  final String toTime;

  const GroupScheduleModel({
    required this.id,
    required this.groupId,
    required this.day,
    required this.fromTime,
    required this.toTime,
  });

  factory GroupScheduleModel.fromJson(Map<String, dynamic> json) => GroupScheduleModel(
    id: json['id'],
    groupId: json['group_id'],
    day: json['day'],
    fromTime: json['from_time'],
    toTime: json['to_time'],
  );

  Map<String, dynamic> toGroupScheduleTableJson() => {
    'group_id': groupId,
    'day': day,
    'from_time': fromTime,
    'to_time': toTime,
  };

  GroupScheduleModel copyWith({
    String? id,
    String? groupId,
    String? day,
    String? fromTime,
    String? toTime,
  }) {
    return GroupScheduleModel(
      id: id ?? this.id,
      groupId: groupId ?? this.groupId,
      day: day ?? this.day,
      fromTime: fromTime ?? this.fromTime,
      toTime: toTime ?? this.toTime,
    );
  }
}
