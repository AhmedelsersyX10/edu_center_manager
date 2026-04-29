import 'package:easy_localization/easy_localization.dart';
import 'package:edu_center_manager/core/utils/app_style.dart';
import 'package:edu_center_manager/core/widgets/select_all_row.dart';
import 'package:edu_center_manager/features/students/data/models/student_model.dart';
import 'package:flutter/material.dart';

class SelectAllVisibleRow extends StatelessWidget {
  final List<StudentModel> visible;
  final Set<String> selectedIds;
  final bool bulkLoading;
  final VoidCallback onToggle;

  const SelectAllVisibleRow({
    super.key,
    required this.visible,
    required this.selectedIds,
    required this.bulkLoading,
    required this.onToggle,
  });

  @override
  Widget build(BuildContext context) {
    final visibleIds = visible.map((s) => s.id).toSet();
    final nSelectedInVisible = visibleIds.where(selectedIds.contains).length;
    return SelectAllRow(
      totalVisible: visible.length,
      selectedInVisible: nSelectedInVisible,
      isDisabled: bulkLoading,
      onToggle: onToggle,
      label: Text(
        'groups_view.details_group.select_all_visible'.tr(),
        style: AppStyles.styleBold16(context),
      ),
      countBuilder: (count) => Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(20)),
        child: Text('$count', style: AppStyles.styleBold14(context)),
      ),
    );
  }
}
