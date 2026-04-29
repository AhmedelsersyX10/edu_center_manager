import 'package:edu_center_manager/core/widgets/custom_empty_state.dart';
import 'package:flutter/material.dart';

class StudentsEmptyState extends StatelessWidget {
  const StudentsEmptyState({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.all(24),
      child: CustomEmptyState(
        text: 'groups_view.students_detail.empty',
        icon: Icons.group_outlined,
      ),
    );
  }
}
