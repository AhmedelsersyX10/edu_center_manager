import 'package:easy_localization/easy_localization.dart';
import 'package:edu_center_manager/core/widgets/custom_empty_state.dart';
import 'package:edu_center_manager/core/widgets/shimmer_table.dart';
import 'package:edu_center_manager/features/teachers/data/models/teacher_model.dart';
import 'package:edu_center_manager/features/teachers/presentation/view/widgets/custom_table_teacher.dart';
import 'package:flutter/material.dart';

class CustomDesktopTeacherTable extends StatelessWidget {
  final List<TeacherModel> teachers;
  final void Function(TeacherModel) onEdit;
  final void Function(TeacherModel) onDelete;
  final bool isLoading;
  final String searchQuary;
  const CustomDesktopTeacherTable({
    super.key,
    required this.teachers,
    required this.onEdit,
    required this.onDelete,
    this.isLoading = false,
    required this.searchQuary,
  });

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return ShimmerTable();
    }

    if (teachers.isEmpty) {
      return CustomEmptyState(
        text: searchQuary.isEmpty ? 'teachersViewEmptyNone'.tr() : 'teachersViewEmptySearch'.tr(),
        icon: Icons.groups_3_rounded,
      );
    }

    return CustomTableTeacher(
      teachers: teachers,
      onEdit: onEdit,
      onDelete: onDelete,
      isLoading: isLoading,
    );
  }
}
