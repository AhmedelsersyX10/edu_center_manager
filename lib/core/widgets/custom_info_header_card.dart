import 'package:edu_center_manager/core/utils/app_style.dart';
import 'package:edu_center_manager/features/students/data/models/student_model.dart';
import 'package:flutter/material.dart';

class CustomInfoHeaderCard extends StatelessWidget {
  const CustomInfoHeaderCard({
    super.key,
    required this.student,
    required this.onEdit,
    required this.onDelete,
  });

  final StudentModel student;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Text(
            student.name,
            style: AppStyles.styleBold24(
              context,
            ).copyWith(color: Theme.of(context).colorScheme.primary),
          ),
        ),
        Row(
          children: [
            IconButton(
              icon: Icon(
                Icons.edit_outlined,
                color: Theme.of(context).colorScheme.surface,
                size: 20,
              ),
              onPressed: onEdit,
              constraints: const BoxConstraints(),
              padding: const EdgeInsets.all(4),
            ),
            IconButton(
              icon: Icon(Icons.delete_outline, color: Colors.redAccent, size: 20),
              onPressed: onDelete,
              constraints: const BoxConstraints(),
              padding: const EdgeInsets.all(4),
            ),
          ],
        ),
      ],
    );
  }
}
