import 'package:edu_center_manager/core/utils/app_style.dart';
import 'package:edu_center_manager/core/utils/app_themes.dart';
import 'package:edu_center_manager/features/groups/data/models/group_model.dart';
import 'package:flutter/material.dart';

class HeaderGroupCard extends StatelessWidget {
  const HeaderGroupCard({
    super.key,
    required this.group,
    required this.onEdit,
    required this.onDelete,
  });

  final GroupModel group;
  final VoidCallback onEdit;
  final VoidCallback onDelete;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Container(
              padding: const EdgeInsets.all(6),
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(8)),
              child: Icon(Icons.groups_2_rounded, color: context.colors.hintText, size: 18),
            ),
            const SizedBox(width: 12),
            Text(
              group.name,
              style: AppStyles.styleBold16(context).copyWith(color: context.colors.primaryText),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ],
    );
  }
}
