import 'package:edu_center_manager/core/widgets/selectable_entity_list_item.dart';
import 'package:edu_center_manager/features/students/data/models/student_model.dart';
import 'package:edu_center_manager/features/students/presentation/view_model/grade_helper.dart';
import 'package:flutter/material.dart';

class StudentListItem extends StatelessWidget {
  const StudentListItem({
    super.key,
    required this.student,
    required this.isSelected,
    required this.isDisabled,
    required this.onToggleSelect,
    required this.onRemove,
  });

  final StudentModel student;
  final bool isSelected;
  final bool isDisabled;
  final VoidCallback onToggleSelect;
  final VoidCallback onRemove;

  String get _initials {
    final name = student.name.trim();
    if (name.isEmpty) return '?';
    return name.split(' ').take(2).map((e) => e[0]).join().toUpperCase();
  }

  @override
  Widget build(BuildContext context) {
    final grade = student.grade;
    return SelectableEntityListItem(
      title: student.name,
      initials: _initials,
      isSelected: isSelected,
      isDisabled: isDisabled,
      onToggleSelect: onToggleSelect,
      onActionTap: onRemove,
      actionIcon: Icons.add_rounded,
      subtitle: grade == null || grade.trim().isEmpty ? null : GradeHelper.translateGrade(grade),
      containerPadding: const EdgeInsets.all(8),
    );
  }
}
