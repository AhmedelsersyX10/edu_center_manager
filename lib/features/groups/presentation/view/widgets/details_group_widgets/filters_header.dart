import 'package:easy_localization/easy_localization.dart';
import 'package:edu_center_manager/core/widgets/custom_search_field.dart';
import 'package:edu_center_manager/features/groups/presentation/view/widgets/details_group_widgets/grade_filter.dart';
import 'package:flutter/material.dart';


class FiltersHeader extends StatelessWidget {
  final String searchQuery;
  final String? gradeFilterKey;
  final ValueChanged<String> onSearchChanged;
  final ValueChanged<String?> onGradeChanged;

  const FiltersHeader({
    super.key,
    required this.searchQuery,
    required this.gradeFilterKey,
    required this.onSearchChanged,
    required this.onGradeChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 20, 16, 8),
      child: LayoutBuilder(
        builder: (context, c) {
          return Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                flex: 2,
                child: CustomSearchField(
                  onSearch: onSearchChanged,
                  hintTextField: 'groups_view.details_group.search_hint'.tr(),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                flex: 1,
                child: GradeFilter(selectedKey: gradeFilterKey, onChanged: onGradeChanged),
              ),
            ],
          );
        },
      ),
    );
  }
}
