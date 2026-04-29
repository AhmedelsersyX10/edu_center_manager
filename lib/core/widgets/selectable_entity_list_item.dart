import 'package:edu_center_manager/core/utils/app_style.dart';
import 'package:edu_center_manager/core/utils/app_themes.dart';
import 'package:flutter/material.dart';

class SelectableEntityListItem extends StatelessWidget {
  const SelectableEntityListItem({
    super.key,
    required this.title,
    required this.initials,
    required this.isSelected,
    required this.isDisabled,
    required this.onToggleSelect,
    required this.onActionTap,
    required this.actionIcon,
    this.subtitle,
    this.containerPadding = EdgeInsets.zero,
    this.tilePadding = const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
    this.actionTooltip,
  });

  final String title;
  final String initials;
  final bool isSelected;
  final bool isDisabled;
  final VoidCallback onToggleSelect;
  final VoidCallback onActionTap;
  final IconData actionIcon;
  final String? subtitle;
  final EdgeInsetsGeometry containerPadding;
  final EdgeInsetsGeometry tilePadding;
  final String? actionTooltip;

  @override
  Widget build(BuildContext context) {
    final actionButton = InkWell(
      onTap: isDisabled ? null : onActionTap,
      borderRadius: BorderRadius.circular(8),
      child: Container(
        padding: const EdgeInsets.all(6),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: context.colors.border,
        ),
        child: Icon(actionIcon, size: 16),
      ),
    );

    return Container(
      padding: containerPadding,
      margin: const EdgeInsets.only(bottom: 8),
      decoration: BoxDecoration(
        color: context.colors.cardBackground,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: context.colors.border, width: 1.5),
      ),
      child: ListTile(
        contentPadding: tilePadding,
        leading: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              width: 24,
              height: 24,
              child: Checkbox(
                value: isSelected,
                onChanged: isDisabled ? null : (_) => onToggleSelect(),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
              ),
            ),
            const SizedBox(width: 8),
            CircleAvatar(radius: 20, child: Text(initials, style: AppStyles.styleBold14(context))),
          ],
        ),
        title: Text(
          title,
          style: AppStyles.styleBold16(context),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          textAlign: TextAlign.right,
        ),
        subtitle: subtitle == null
            ? null
            : Text(subtitle!, style: AppStyles.styleRegular14(context), textAlign: TextAlign.right),
        trailing: actionTooltip == null
            ? actionButton
            : Tooltip(message: actionTooltip!, child: actionButton),
      ),
    );
  }
}
