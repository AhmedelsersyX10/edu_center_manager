import 'package:easy_localization/easy_localization.dart';
import 'package:edu_center_manager/core/widgets/bulk_action_button_bar.dart';
import 'package:flutter/material.dart';

class BulkActionBar extends StatelessWidget {
  final int selectedCount;
  final bool bulkLoading;
  final VoidCallback onAssign;

  const BulkActionBar({
    super.key,
    required this.selectedCount,
    required this.bulkLoading,
    required this.onAssign,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: BulkActionButtonBar(
        visible: selectedCount > 0,
        isLoading: bulkLoading,
        onPressed: onAssign,
        icon: Icons.person_add_rounded,
        padding: const EdgeInsets.fromLTRB(20, 16, 20, 16),
        label: Text(
          'groups_view.details_group.add_selected'.tr(args: ['$selectedCount']),
          style: const TextStyle(fontFamily: 'cairo', fontWeight: FontWeight.w800, fontSize: 16),
        ),
      ),
    );
  }
}
