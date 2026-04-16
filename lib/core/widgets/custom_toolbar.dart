import 'package:easy_localization/easy_localization.dart';
import 'package:edu_center_manager/core/widgets/custom_filter_dropdown.dart';
import 'package:edu_center_manager/core/widgets/custom_search_field.dart';
import 'package:flutter/material.dart';

class CustomToolbar extends StatelessWidget {
  final String text, hintTextField;
  final VoidCallback onAdd;
  final ValueChanged<String> onSearch;
  final String selected;
  final ValueChanged<String?> onChanged;
  final List<String> list;

  const CustomToolbar({
    super.key,
    required this.text,
    required this.hintTextField,
    required this.onAdd,
    required this.onSearch,
    required this.selected,
    required this.onChanged,
    required this.list,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          children: [
            Expanded(
              flex: 2,
              child: CustomSearchField(hintTextField: hintTextField, onSearch: onSearch),
            ),
            const SizedBox(width: 8),
            Expanded(
              flex: 1,
              child: CustomFilterDropdown(
                selected: selected,
                onChanged: onChanged,
                list: list.map((item) {
                  return DropdownMenuItem<String>(value: item, child: Text(item.tr()));
                }).toList(),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
