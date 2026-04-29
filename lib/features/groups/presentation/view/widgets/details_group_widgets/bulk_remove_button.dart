import 'package:easy_localization/easy_localization.dart';
import 'package:edu_center_manager/core/widgets/bulk_action_button_bar.dart';
import 'package:edu_center_manager/core/utils/app_style.dart';
import 'package:flutter/material.dart';

class BulkRemoveButton extends StatelessWidget {
  const BulkRemoveButton({
    super.key,
    required this.selectedCount,
    required this.isLoading,
    required this.onPressed,
  });

  final int selectedCount;
  final bool isLoading;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return BulkActionButtonBar(
      isLoading: isLoading,
      onPressed: onPressed,
      icon: Icons.person_remove_alt_1_rounded,
      buttonPadding: const EdgeInsets.symmetric(vertical: 8),
      label: Text(
        'groups_view.students_detail.remove_selected'.tr(args: [selectedCount.toString()]),
        style: AppStyles.styleBold24(context),
      ),
    );
  }
}
