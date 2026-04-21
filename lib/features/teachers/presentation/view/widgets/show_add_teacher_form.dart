import 'package:edu_center_manager/features/teachers/data/models/teacher_model.dart';
import 'package:edu_center_manager/features/teachers/presentation/view/widgets/add_teacher_form.dart';
import 'package:flutter/material.dart';

Future<void> showTeacherForm(
  BuildContext context, {
  required bool isMobile,
  required Future<void> Function(TeacherModel) onSubmit,
  TeacherModel? teacher,
}) {
  if (isMobile) {
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) => TeacherForm(isMobile: true, onSubmit: onSubmit, teacher: teacher),
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
          child: TeacherForm(isMobile: false, onSubmit: onSubmit, teacher: teacher),
        ),
      ),
    );
  }
}
