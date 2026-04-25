import 'package:easy_localization/easy_localization.dart';

class GroupScheduleModel {
  final String id;
  final String groupId;
  final WeekDay day;
  final String fromTime;
  final String toTime;

  const GroupScheduleModel({
    required this.id,
    required this.groupId,
    required this.day,
    required this.fromTime,
    required this.toTime,
  });

  factory GroupScheduleModel.fromJson(Map<String, dynamic> json) {
    return GroupScheduleModel(
      id: json['id']?.toString() ?? '',
      groupId: json['group_id']?.toString() ?? '',
      day: WeekDay.values.byName(json['day']?.toString() ?? 'sat'),
      fromTime: json['from_time']?.toString() ?? '',
      toTime: json['to_time']?.toString() ?? '',
    );
  }

  Map<String, dynamic> toGroupScheduleTableJson() => {
    'group_id': groupId,
    'day': day.name,
    'from_time': fromTime,
    'to_time': toTime,
  };

  GroupScheduleModel copyWith({
    String? id,
    String? groupId,
    WeekDay? day,
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

  String get fromDisplay => _hhMm(fromTime);

  String get toDisplay => _hhMm(toTime);

  static String _hhMm(String raw) {
    final t = raw.trim();
    if (t.length >= 5) return t.substring(0, 5);
    return t;
  }

  String get dayLocalized {
    switch (day) {
      case WeekDay.sat: return 'saturday'.tr();
      case WeekDay.sun: return 'sunday'.tr();
      case WeekDay.mon: return 'monday'.tr();
      case WeekDay.tue: return 'tuesday'.tr();
      case WeekDay.wed: return 'wednesday'.tr();
      case WeekDay.thu: return 'thursday'.tr();
      case WeekDay.fri: return 'friday'.tr();
    }
  }
}

enum WeekDay { sat, sun, mon, tue, wed, thu, fri }
