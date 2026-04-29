import 'package:easy_localization/easy_localization.dart';
import 'package:edu_center_manager/core/utils/app_style.dart';
import 'package:edu_center_manager/core/widgets/custom_filter_dropdown.dart';
import 'package:edu_center_manager/features/students/presentation/view_model/grade_helper.dart';
import 'package:flutter/material.dart';

class GradeFilter extends StatelessWidget {
  static const _allGradesKey = '__all__';

  final String? selectedKey;
  final ValueChanged<String?> onChanged;

  const GradeFilter({super.key, required this.selectedKey, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return CustomFilterDropdown(
      selected: selectedKey ?? _allGradesKey,
      onChanged: (value) => onChanged(value == _allGradesKey ? null : value),
      list: [
        DropdownMenuItem<String>(
          value: _allGradesKey,
          child: Text(
            'all_grades'.tr(),
            style: AppStyles.styleRegular14(context),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        ...GradeHelper.selectGradeKeys.map(
          (key) => DropdownMenuItem<String>(
            value: key,
            child: Text(
              key.tr(),
              style: AppStyles.styleRegular14(context),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ),
      ],
    );
  }
}
