import 'package:edu_center_manager/features/groups/presentation/view/widgets/details_group_widgets/students_empty_state.dart';
import 'package:edu_center_manager/features/groups/presentation/view/widgets/details_group_widgets/students_list_content.dart';
import 'package:edu_center_manager/features/groups/presentation/view/widgets/details_group_widgets/students_loading_state.dart';
import 'package:edu_center_manager/features/students/data/models/student_model.dart';
import 'package:flutter/material.dart';

class StudentsCardBody extends StatelessWidget {
  const StudentsCardBody({
    super.key,
    required this.loading,
    required this.inGroup,
    required this.filteredInGroup,
    required this.selectedIds,
    required this.bulkLoading,
    required this.onSearch,
    required this.onToggleStudent,
    required this.onToggleAllVisible,
    required this.onRemoveSingle,
    required this.onConfirmBulkRemove,
  });

  final bool loading;
  final List<StudentModel> inGroup;
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
    if (loading) return const StudentsLoadingState();
    if (inGroup.isEmpty) return const StudentsEmptyState();

    return StudentsListContent(
      filteredInGroup: filteredInGroup,
      selectedIds: selectedIds,
      bulkLoading: bulkLoading,
      onSearch: onSearch,
      onToggleStudent: onToggleStudent,
      onToggleAllVisible: onToggleAllVisible,
      onRemoveSingle: onRemoveSingle,
      onConfirmBulkRemove: onConfirmBulkRemove,
    );
  }
}
