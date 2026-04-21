import 'package:easy_localization/easy_localization.dart';
import 'package:edu_center_manager/core/utils/app_style.dart';
import 'package:edu_center_manager/core/widgets/delete_confirm_dialog.dart';
import 'package:edu_center_manager/features/students/data/models/student_model.dart';
import 'package:edu_center_manager/features/students/presentation/view/widgets/show_add_student_form.dart';
import 'package:edu_center_manager/features/students/presentation/view_model/students_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void onSearchStudent(BuildContext context, String query) {
  context.read<StudentsCubit>().searchStudents(query);
}

void onAddStudent(BuildContext context, bool isMobile) {
  showStudentForm(
    context,
    isMobile: isMobile,
    onSubmit: (newStudent) async {
      await context.read<StudentsCubit>().addStudent(newStudent);
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('studentAddedSuccessfully'.tr(), style: AppStyles.styleBold16(context)),
          ),
        );
      }
    },
  );
}

void onEditStudent(BuildContext context, StudentModel student, bool isMobile) {
  showStudentForm(
    context,
    isMobile: isMobile,
    student: student,
    onSubmit: (updatedStudent) async {
      await context.read<StudentsCubit>().updateStudent(updatedStudent);
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('studentUpdatedSuccessfully'.tr(), style: AppStyles.styleBold18(context)),
          ),
        );
      }
    },
  );
}

void onDeleteStudent(BuildContext context, StudentModel student) {
  showDialog(
    context: context,
    builder: (_) => DeleteConfirmDialog(
      title: 'confirmDelete'.tr(),
      content: 'deleteStudentConfirmMsg'.tr(),
      onConfirm: () async {
        await context.read<StudentsCubit>().deleteStudent(student.id);
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                'studentDeletedSuccessfully'.tr(args: [student.name]),
                style: AppStyles.styleBold18(context),
              ),
            ),
          );
        }
      },
    ),
  );
}
