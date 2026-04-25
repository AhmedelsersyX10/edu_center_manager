import 'package:edu_center_manager/features/groups/data/models/group_model.dart';
import 'package:edu_center_manager/features/groups/data/models/group_schedule_model.dart';
import 'package:edu_center_manager/features/groups/presentation/view/widgets/add_group_form.dart';
import 'package:edu_center_manager/features/teachers/data/models/teacher_model.dart';
import 'package:flutter/material.dart';

Future<void> showGroupForm(
  BuildContext context, {
  required bool isMobile,
  required Future<void> Function(GroupModel, List<GroupScheduleModel>) onSubmit,
  GroupModel? group,
  List<TeacherModel>? teachers,
  List<GroupScheduleModel>? initialSchedules,
}) {
  if (isMobile) {
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) => AddGroupForm(
        isMobile: true,
        onSubmit: onSubmit,
        group: group,
        teachers: teachers ?? [],
        initialSchedules: initialSchedules ?? [],
      ),
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
          child: AddGroupForm(
            isMobile: false,
            onSubmit: onSubmit,
            teachers: teachers ?? [],
            initialSchedules: initialSchedules ?? [],
          ),
        ),
      ),
    );
  }
}
