import 'package:easy_localization/easy_localization.dart';
import 'package:edu_center_manager/core/utils/app_style.dart';
import 'package:edu_center_manager/core/utils/app_themes.dart';
import 'package:edu_center_manager/features/groups/data/models/group_schedule_model.dart';
import 'package:flutter/material.dart';

class SchedulesBlock extends StatelessWidget {
  const SchedulesBlock({super.key, required this.schedules});

  final List<GroupScheduleModel> schedules;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            const Icon(Icons.access_time_rounded, size: 16),
            const SizedBox(width: 6),
            Text('groups_view.card.schedules_title'.tr(), style: AppStyles.styleBold12(context)),
          ],
        ),
        const SizedBox(height: 8),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: schedules.map((s) {
            return Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
              decoration: BoxDecoration(
                color: context.colors.pageBackground,
                border: Border.fromBorderSide(BorderSide(width: 1, color: context.colors.border)),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                '${s.dayLocalized} ${s.fromDisplay}–${s.toDisplay}',
                style: AppStyles.styleBold12(context),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }
}
