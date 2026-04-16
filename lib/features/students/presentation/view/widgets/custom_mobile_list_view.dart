import 'package:easy_localization/easy_localization.dart';
import 'package:edu_center_manager/core/widgets/custom_empty_state.dart';
import 'package:edu_center_manager/core/widgets/shimmer_info_card.dart';
import 'package:edu_center_manager/features/students/data/models/student_model.dart';
import 'package:edu_center_manager/features/students/presentation/view/widgets/student_card.dart';
import 'package:flutter/material.dart';

class CustomMobileListView extends StatelessWidget {
  const CustomMobileListView({
    super.key,
    required this.students,
    required this.onEdit,
    required this.onDelete,
    required this.isLoading,
  });
  final List<StudentModel> students;
  final Function(StudentModel) onEdit;
  final Function(StudentModel) onDelete;
  final bool isLoading;
  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const ShimmerInfoCard();
    }
    if (students.isEmpty) {
      return CustomEmptyState(text: 'studentsViewEmptyNone'.tr(), icon: Icons.groups_3_rounded);
    }
    return ListView.builder(
      itemCount: students.length,
      itemBuilder: (context, index) {
        final student = students[index];
        return StudentCard(
          student: student,
          onEdit: () => onEdit(student),
          onDelete: () => onDelete(student),
        );
      },
    );
  }
}
