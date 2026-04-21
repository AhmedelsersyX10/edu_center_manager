import 'package:edu_center_manager/features/students/data/models/student_model.dart';
import 'package:edu_center_manager/features/students/presentation/view/widgets/add_student_form.dart';
import 'package:flutter/material.dart';

Future<void> showStudentForm(
  BuildContext context, {
  required bool isMobile,
  required Future<void> Function(StudentModel) onSubmit,
  StudentModel? student,
}) {
  if (isMobile) {
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) => StudentForm(isMobile: true, onSubmit: onSubmit, student: student),
    );
  } else {
    return showDialog(
      context: context,
      barrierDismissible: true,
      builder: (context) => Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        elevation: 0,
        child: Container(
          constraints: const BoxConstraints(maxWidth: 500),
          child: StudentForm(isMobile: false, onSubmit: onSubmit, student: student),
        ),
      ),
    );
  }
}
