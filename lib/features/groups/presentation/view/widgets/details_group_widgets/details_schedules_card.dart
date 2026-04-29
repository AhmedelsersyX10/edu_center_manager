import 'package:easy_localization/easy_localization.dart';
import 'package:edu_center_manager/core/utils/app_style.dart';
import 'package:edu_center_manager/core/utils/app_themes.dart';
import 'package:edu_center_manager/core/widgets/section_card.dart';
import 'package:edu_center_manager/features/groups/presentation/view/widgets/details_group_widgets/group_students_detail_view.dart';
import 'package:flutter/material.dart';

class DetailsSchedulesCard extends StatelessWidget {
  const DetailsSchedulesCard({super.key, required this.groupDetailsView});

  final GroupStudentsDetailView groupDetailsView;

  @override
  Widget build(BuildContext context) {
    return SectionCard(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
      backgroundColor: context.colors.cardBackground,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(6),
                decoration: BoxDecoration(borderRadius: BorderRadius.circular(8)),
                child: const Icon(Icons.calendar_today_rounded, size: 18),
              ),
              const SizedBox(width: 12),
              Text(
                'groups_view.card.schedules_title'.tr(),
                style: AppStyles.styleRegular18(context),
              ),
            ],
          ),
          const SizedBox(height: 8),
          const Divider(height: 2),
          const SizedBox(height: 8),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: groupDetailsView.schedules.map((s) {
              return Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    style: BorderStyle.solid,
                    color: context.colors.hintText,
                    width: 0.5,
                  ),
                  color: context.colors.cardBackground,
                ),
                child: Text(
                  '${s.dayLocalized}: ${s.fromDisplay} – ${s.toDisplay}'.tr(),
                  style: AppStyles.styleRegular16(context),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}
