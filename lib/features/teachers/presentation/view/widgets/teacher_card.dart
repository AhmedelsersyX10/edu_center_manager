import 'package:edu_center_manager/core/utils/app_themes.dart';
import 'package:edu_center_manager/core/widgets/custom_info_header_card.dart';
import 'package:edu_center_manager/core/widgets/custom_info_row_card.dart';
import 'package:edu_center_manager/features/teachers/presentation/view_model/subject_helper.dart';
import 'package:flutter/material.dart';
import 'package:edu_center_manager/features/teachers/data/models/teacher_model.dart';

class TeacherCard extends StatelessWidget {
  final TeacherModel teacher;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  const TeacherCard({
    super.key,
    required this.teacher,
    required this.onEdit,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: context.colors.cardBackground,
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomInfoHeaderCard(item: teacher.name, onEdit: onEdit, onDelete: onDelete),
            const SizedBox(height: 12),
            CustomInfoRowCard(
              icon: Icons.class_outlined,
              text: SubjectHelper.translateSubject(teacher.subject),
              context: context,
            ),
            const SizedBox(height: 8),
            CustomInfoRowCard(icon: Icons.phone_outlined, text: teacher.phone!, context: context),
          ],
        ),
      ),
    );
  }
}
