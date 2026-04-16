import 'package:edu_center_manager/core/widgets/custom_animated_switcher.dart';
import 'package:edu_center_manager/features/students/data/models/student_model.dart';
import 'package:edu_center_manager/features/students/presentation/helper/students_actions.dart';
import 'package:edu_center_manager/features/students/presentation/view/widgets/custom_desktop_student_table.dart';
import 'package:flutter/material.dart';

class StudentsTable extends StatelessWidget {
  const StudentsTable({
    super.key,
    required this.isLoading,
    required this.students,
    required this.allCount,
  });

  final bool isLoading;
  final List<StudentModel> students;
  final int allCount;

  @override
  Widget build(BuildContext context) {
    return CustomAnimatedSwitcher(
      isLoading: isLoading,
      students: students,
      allCount: allCount,
      child: CustomDesktopStudentTable(
        students: students,
        onEdit: (student) => onEditStudent(context, student, false),
        onDelete: (student) => onDeleteStudent(context, student),
        isLoading: isLoading,
      ),
    );
  }
}
