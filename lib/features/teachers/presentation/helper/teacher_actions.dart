import 'package:easy_localization/easy_localization.dart';
import 'package:edu_center_manager/core/utils/app_style.dart';
import 'package:edu_center_manager/core/widgets/delete_confirm_dialog.dart';
import 'package:edu_center_manager/features/teachers/data/models/teacher_model.dart';
import 'package:edu_center_manager/features/teachers/presentation/view/widgets/show_add_teacher_form.dart';
import 'package:edu_center_manager/features/teachers/presentation/view_model/teacher_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void onSearchTeacher(BuildContext context, String query) {
  context.read<TeacherCubit>().searchTeacher(query);
}

void onAddTeacher(BuildContext context, bool isMobile) {
  showTeacherForm(
    context,
    isMobile: isMobile,
    onSubmit: (newTeacher) async {
      await context.read<TeacherCubit>().addTeacher(newTeacher);
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('teacherAddedSuccessfully'.tr(), style: AppStyles.styleBold16(context)),
          ),
        );
      }
    },
  );
}

void onEditTeacher(BuildContext context, TeacherModel teacher, bool isMobile) {
  showTeacherForm(
    context,
    isMobile: isMobile,
    teacher: teacher,
    onSubmit: (updateTeacher) async {
      await context.read<TeacherCubit>().updateTeacher(updateTeacher);
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('teacherUpdatedSuccessfully'.tr(), style: AppStyles.styleBold18(context)),
          ),
        );
      }
    },
  );
}

void onDeleteTeacher(BuildContext context, TeacherModel teacher) {
  showDialog(
    context: context,
    builder: (_) => DeleteConfirmDialog(
      title: 'confirmDelete'.tr(),
      content: 'deleteTeacherConfirmMsg'.tr(),
      onConfirm: () async {
        await context.read<TeacherCubit>().deleteTeacher(teacher.id);
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                'teacherDeletedSuccessfully'.tr(args: [teacher.name]),
                style: AppStyles.styleBold18(context),
              ),
            ),
          );
        }
      },
    ),
  );
}
