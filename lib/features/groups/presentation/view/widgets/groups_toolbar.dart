import 'package:easy_localization/easy_localization.dart';
import 'package:edu_center_manager/core/widgets/custom_search_field.dart';
import 'package:edu_center_manager/features/groups/presentation/view/widgets/custom_group_filter_dropdown.dart';
import 'package:edu_center_manager/features/teachers/data/models/teacher_model.dart';
import 'package:flutter/material.dart';

class GroupsToolbar extends StatelessWidget {
  final ValueChanged<String> onSearch;
  final String selectedTeacherId;
  final ValueChanged<String?> onTeacherChanged;
  final List<TeacherModel> teachers;
  final bool isMobile;

  const GroupsToolbar({
    super.key,
    required this.onSearch,
    required this.selectedTeacherId,
    required this.onTeacherChanged,
    required this.teachers,
    this.isMobile = false,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 2,
          child: CustomSearchField(
            hintTextField: 'groups_view.toolbar.search_hint'.tr(),
            onSearch: onSearch,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          flex: 1,
          child: CustomGroupFilterDropdown(
            selectedTeacherId: selectedTeacherId,
            onTeacherChanged: onTeacherChanged,
            teachers: teachers,
          ),
        ),
      ],
    );
  }
}
