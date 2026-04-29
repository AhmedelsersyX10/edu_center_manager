import 'package:easy_localization/easy_localization.dart';
import 'package:edu_center_manager/core/widgets/custom_search_field.dart';
import 'package:edu_center_manager/core/widgets/selectable_entity_list.dart';
import 'package:edu_center_manager/features/groups/presentation/view/widgets/details_group_widgets/bulk_remove_button.dart';
import 'package:edu_center_manager/features/groups/presentation/view/widgets/details_group_widgets/details_student_list_item.dart';
import 'package:edu_center_manager/features/groups/presentation/view/widgets/details_group_widgets/select_all_visible_row.dart';
import 'package:edu_center_manager/features/groups/presentation/view/widgets/details_group_widgets/students_no_results_state.dart';
import 'package:edu_center_manager/features/students/data/models/student_model.dart';
import 'package:flutter/material.dart';

class StudentsListContent extends StatelessWidget {
  const StudentsListContent({
    super.key,
    required this.filteredInGroup,
    required this.selectedIds,
    required this.bulkLoading,
    required this.onSearch,
    required this.onToggleStudent,
    required this.onToggleAllVisible,
    required this.onRemoveSingle,
    required this.onConfirmBulkRemove,
  });

  final List<StudentModel> filteredInGroup;
  final Set<String> selectedIds;
  final bool bulkLoading;
  final ValueChanged<String> onSearch;
  final ValueChanged<String> onToggleStudent;
  final VoidCallback onToggleAllVisible;
  final ValueChanged<StudentModel> onRemoveSingle;
  final VoidCallback onConfirmBulkRemove;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 20, 16, 8),
          child: CustomSearchField(
            hintTextField: 'groups_view.details_group.search_hint'.tr(),
            onSearch: onSearch,
          ),
        ),
        SelectAllVisibleRow(
          visible: filteredInGroup,
          selectedIds: selectedIds,
          bulkLoading: bulkLoading,
          onToggle: onToggleAllVisible,
        ),
        filteredInGroup.isEmpty
            ? const StudentsNoResultsState()
            : SelectableEntityList<StudentModel>(
                items: filteredInGroup,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, student) => DetailsStudentListItem(
                  student: student,
                  isSelected: selectedIds.contains(student.id),
                  isDisabled: bulkLoading,
                  onToggleSelect: () => onToggleStudent(student.id),
                  onRemove: () => onRemoveSingle(student),
                ),
              ),
        if (selectedIds.isNotEmpty)
          BulkRemoveButton(
            selectedCount: selectedIds.length,
            isLoading: bulkLoading,
            onPressed: onConfirmBulkRemove,
          ),
      ],
    );
  }
}
