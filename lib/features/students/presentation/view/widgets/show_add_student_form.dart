import 'package:edu_center_manager/features/students/data/models/student_model.dart';
import 'package:edu_center_manager/features/students/presentation/view/widgets/add_student_form.dart';
import 'package:flutter/material.dart';

Future<void> showStudentForm(
  BuildContext context, {
  required Future<void> Function(StudentModel) onSubmit,
  StudentModel? student,
}) {
  return showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (context) => StudentForm(onSubmit: onSubmit, student: student),
  );
}
