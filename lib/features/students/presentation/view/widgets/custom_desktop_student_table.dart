import 'package:easy_localization/easy_localization.dart';
import 'package:edu_center_manager/core/widgets/custom_empty_state.dart';
import 'package:edu_center_manager/core/widgets/shimmer_table.dart';
import 'package:edu_center_manager/features/students/data/models/student_model.dart';
import 'package:edu_center_manager/features/students/presentation/view/widgets/custom_table_student.dart';
import 'package:flutter/material.dart';

class CustomDesktopStudentTable extends StatelessWidget {
  final List<StudentModel> students;
  final Function(StudentModel) onEdit;
  final Function(StudentModel) onDelete;
  final bool isLoading;

  const CustomDesktopStudentTable({
    super.key,
    required this.students,
    required this.onEdit,
    required this.onDelete,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return ShimmerTable();
    }

    if (students.isEmpty) {
      return CustomEmptyState(text:  'studentsViewEmptyNone'.tr(), icon: Icons.groups_3_rounded);
    }

    return CustomTableStudent(
      students: students,
      onEdit: onEdit,
      onDelete: onDelete,
      isLoading: isLoading,
    );
  }
}
