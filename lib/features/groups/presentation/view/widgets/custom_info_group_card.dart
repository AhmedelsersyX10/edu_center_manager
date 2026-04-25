import 'package:easy_localization/easy_localization.dart';
import 'package:edu_center_manager/features/groups/data/models/group_model.dart';
import 'package:edu_center_manager/features/groups/data/models/group_schedule_model.dart';
import 'package:edu_center_manager/features/groups/presentation/view/widgets/info_row_group.dart';
import 'package:edu_center_manager/features/groups/presentation/view/widgets/schedules_block.dart';
import 'package:flutter/material.dart';

class CustomInfoGroupCard extends StatelessWidget {
  const CustomInfoGroupCard({
    super.key,
    required this.teacherLabel,
    required this.group,
    required this.studentsInGroup,
    required this.schedules,
  });

  final String teacherLabel;
  final GroupModel group;
  final int studentsInGroup;
  final List<GroupScheduleModel> schedules;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          InfoRowGroup(
            icon: Icons.person_outline_rounded,
            label: 'groups_view.table.labels.teacher'.tr(),
            value: teacherLabel,
          ),
          const SizedBox(height: 12),
          if (group.description != null && group.description!.trim().isNotEmpty) ...[
            InfoRowGroup(
              icon: Icons.notes_rounded,
              label: 'groups_view.table.labels.description'.tr(),
              value: group.description!.trim(),
            ),
            const SizedBox(height: 12),
          ],
          Row(
            children: [
              Expanded(
                child: InfoRowGroup(
                  icon: Icons.people_alt_outlined,
                  label: 'groups_view.table.labels.max_students'.tr(),
                  value: 'groups_view.table.labels.students_of_max'.tr(
                    args: ['$studentsInGroup', '${group.maxStudents}'],
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: InfoRowGroup(
                  icon: Icons.payments_outlined,
                  label: 'groups_view.table.labels.monthly_fee'.tr(),
                  value: '${group.monthlyFee}',
                ),
              ),
            ],
          ),
          if (schedules.isNotEmpty) ...[
            const SizedBox(height: 16),
            const Divider(height: 1),
            const SizedBox(height: 12),
            SchedulesBlock(schedules: schedules),
          ],
        ],
      ),
    );
  }
}
