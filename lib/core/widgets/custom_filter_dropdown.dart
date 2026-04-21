import 'package:edu_center_manager/core/utils/app_themes.dart';
import 'package:edu_center_manager/core/utils/app_style.dart';
import 'package:flutter/material.dart';

class CustomFilterDropdown extends StatelessWidget {
  const CustomFilterDropdown({
    super.key,
    required this.selected,
    required this.onChanged,
    required this.list,
  });

  final String selected;
  final ValueChanged<String?> onChanged;
  final List<DropdownMenuItem<String>> list;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: context.colors.cardBackground,
        border: Border.all(color: context.colors.border),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: selected,
          isExpanded: true,
          icon: const Icon(Icons.filter_list),
          style: AppStyles.styleRegular14(context).copyWith(color: context.colors.hintText),
          onChanged: onChanged,
          items: list,
        ),
      ),
    );
  }
}
