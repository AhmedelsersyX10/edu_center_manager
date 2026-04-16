import 'package:edu_center_manager/features/students/presentation/view/widgets/custom_info_header_card.dart';
import 'package:edu_center_manager/features/students/presentation/view/widgets/custom_info_row_card.dart';
import 'package:edu_center_manager/features/students/presentation/view_model/grade_helper.dart';
import 'package:flutter/material.dart';
import 'package:edu_center_manager/features/students/data/models/student_model.dart';

class StudentCard extends StatelessWidget {
  final StudentModel student;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  const StudentCard({
    super.key,
    required this.student,
    required this.onEdit,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 10,
            offset: const Offset(4, 4),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomInfoHeaderCard(student: student, onEdit: onEdit, onDelete: onDelete),
            const SizedBox(height: 12),
            CustomInfoRowCard(
              icon: Icons.class_outlined,
              text: GradeHelper.translateGrade(student.grade),
              context: context,
            ),
            const SizedBox(height: 8),
            CustomInfoRowCard(
              icon: Icons.location_on_outlined,
              text: student.address ?? '--',
              context: context,
            ),
            const SizedBox(height: 8),
            CustomInfoRowCard(
              icon: Icons.phone_outlined,
              text: student.parentPhone ?? '--',
              context: context,
            ),
          ],
        ),
      ),
    );
  }
}
