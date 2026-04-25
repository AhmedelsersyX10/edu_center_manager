import 'package:easy_localization/easy_localization.dart';
import 'package:edu_center_manager/core/widgets/custom_empty_state.dart';
import 'package:edu_center_manager/features/groups/data/models/group_model.dart';
import 'package:edu_center_manager/features/groups/data/models/group_schedule_model.dart';
import 'package:edu_center_manager/features/groups/presentation/helper/group_actions.dart';
import 'package:edu_center_manager/features/groups/presentation/view/widgets/group_card.dart';
import 'package:edu_center_manager/features/groups/presentation/view/widgets/shimmer_info_group_card.dart';
import 'package:edu_center_manager/features/teachers/data/models/teacher_model.dart';
import 'package:flutter/material.dart';

class CustomMobileGroupCardList extends StatelessWidget {
  const CustomMobileGroupCardList({
    super.key,
    required this.groups,
    required this.teachers,
    required this.schedulesByGroupId,
    required this.studentCountByGroupId,
    required this.isLoading,
    required this.allCount,
    required this.filteredEmpty,
  });

  final List<GroupModel> groups;
  final List<TeacherModel> teachers;
  final Map<String, List<GroupScheduleModel>> schedulesByGroupId;
  final Map<String, int> studentCountByGroupId;
  final bool isLoading;
  final int allCount;
  final bool filteredEmpty;

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const ShimmerGroupCard();
    }

    if (groups.isEmpty) {
      return CustomEmptyState(
        text: filteredEmpty ? 'groupsViewEmptySearch'.tr() : 'groupsViewEmptyNone'.tr(),
        icon: Icons.group,
      );
    }

    return ListView.builder(
      itemCount: groups.length,
      itemBuilder: (context, index) {
        final group = groups[index];
        return GroupCard(
          group: group,
          teachers: teachers,
          schedules: schedulesByGroupId[group.id] ?? const [],
          studentsInGroup: studentCountByGroupId[group.id] ?? 0,
          onStudents: () {},
          onEdit: () => onEditGroup(context, group, true, teachers),
          onDelete: () => onDeleteGroup(context, group),
        );
      },
    );
  }
}
