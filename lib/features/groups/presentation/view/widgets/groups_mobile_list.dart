import 'package:edu_center_manager/core/widgets/custom_animated_switcher.dart';
import 'package:edu_center_manager/features/groups/data/models/group_model.dart';
import 'package:edu_center_manager/features/groups/data/models/group_schedule_model.dart';
import 'package:edu_center_manager/features/groups/presentation/view/widgets/custom_mobile_group_card_list.dart';
import 'package:edu_center_manager/features/teachers/data/models/teacher_model.dart';
import 'package:flutter/material.dart';

class GroupsMobileList extends StatelessWidget {
  const GroupsMobileList({
    super.key,
    required this.isLoading,
    required this.groups,
    required this.allCount,
    required this.scheduleRowsCount,
    required this.teacherList,
    required this.schedulesByGroupId,
    required this.studentCountByGroupId,
    required this.filteredEmpty,
  });

  final bool isLoading;
  final List<GroupModel> groups;
  final int allCount;
  final int scheduleRowsCount;
  final List<TeacherModel> teacherList;
  final Map<String, List<GroupScheduleModel>> schedulesByGroupId;
  final Map<String, int> studentCountByGroupId;
  final bool filteredEmpty;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: CustomAnimatedSwitcher(
        isLoading: isLoading,
        items: groups,
        allCount: allCount,
        scheduleRowsCount: scheduleRowsCount,
        child: CustomMobileGroupCardList(
          groups: groups,
          teachers: teacherList,
          schedulesByGroupId: schedulesByGroupId,
          studentCountByGroupId: studentCountByGroupId,
          isLoading: isLoading,
          allCount: allCount,
          filteredEmpty: filteredEmpty,
        ),
      ),
    );
  }
}
