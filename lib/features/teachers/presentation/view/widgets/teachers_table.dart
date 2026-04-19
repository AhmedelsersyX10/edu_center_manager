import 'package:edu_center_manager/core/widgets/custom_animated_switcher.dart';
import 'package:edu_center_manager/features/teachers/data/models/teacher_model.dart';
import 'package:edu_center_manager/features/teachers/presentation/helper/teacher_actions.dart';
import 'package:edu_center_manager/features/teachers/presentation/view/widgets/custom_desktop_teacher_table.dart';
import 'package:flutter/material.dart';

class TeachersTable extends StatelessWidget {
  const TeachersTable({
    super.key,
    required this.isLoading,
    required this.teachers,
    required this.allTeachers,
    required this.searchQuary,
  });

  final bool isLoading;
  final List<TeacherModel> teachers;
  final int allTeachers;
  final String searchQuary;


  @override
  Widget build(BuildContext context) {
    return CustomAnimatedSwitcher(
      isLoading: isLoading,
      items: teachers,
      allCount: allTeachers,
      child: CustomDesktopTeacherTable(
        teachers: teachers,
        onEdit: (teacher) => onEditTeacher(context, teacher, false),
        onDelete: (teacher) => onDeleteTeacher(context, teacher),
        isLoading: isLoading,
        searchQuary: searchQuary,
      ),
    );
  }
}
