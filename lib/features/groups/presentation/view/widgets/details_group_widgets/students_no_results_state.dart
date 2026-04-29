import 'package:edu_center_manager/core/widgets/custom_empty_state.dart';
import 'package:flutter/material.dart';

class StudentsNoResultsState extends StatelessWidget {
  const StudentsNoResultsState({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 24),
      child: CustomEmptyState(
        text: 'groups_view.students_detail.no_search_results',
        icon: Icons.search_off_rounded,
      ),
    );
  }
}
