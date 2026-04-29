import 'package:easy_localization/easy_localization.dart';
import 'package:edu_center_manager/core/utils/size_config.dart';
import 'package:edu_center_manager/core/widgets/delete_confirm_dialog.dart';
import 'package:edu_center_manager/features/groups/data/models/group_model.dart';
import 'package:edu_center_manager/features/groups/data/models/group_schedule_model.dart';
import 'package:edu_center_manager/features/groups/presentation/view/widgets/details_group_widgets/group_students_detail_view.dart';
import 'package:edu_center_manager/features/groups/presentation/view/widgets/show_details_group.dart';
import 'package:edu_center_manager/features/groups/presentation/view/widgets/show_add_group_form.dart';
import 'package:edu_center_manager/features/groups/presentation/view_model/groups_cubit.dart';
import 'package:edu_center_manager/features/teachers/data/models/teacher_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

Future<void> onAddGroup(BuildContext context, bool isMobile, List<TeacherModel> teachers) async {
  if (teachers.isEmpty) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          'groups_view.messages.add_teacher_first'.tr(),
          style: const TextStyle(fontFamily: 'cairo'),
        ),
      ),
    );
    return;
  }
  await showGroupForm(
    context,
    isMobile: isMobile,
    teachers: teachers,
    onSubmit: (model, schedules) async {
      await context.read<GroupsCubit>().addGroup(model, schedules);
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'groupAddedSuccessfully'.tr(),
              style: const TextStyle(fontFamily: 'cairo'),
            ),
          ),
        );
      }
    },
  );
}

Future<void> onEditGroup(
  BuildContext context,
  GroupModel group,
  bool isMobile,
  List<TeacherModel> teachers,
) async {
  final blocState = context.read<GroupsCubit>().state;
  final initialSchedules = blocState is GroupsLoaded
      ? List<GroupScheduleModel>.from(blocState.schedulesByGroupId[group.id] ?? const [])
      : const <GroupScheduleModel>[];
  await showGroupForm(
    context,
    isMobile: isMobile,
    teachers: teachers,
    group: group,
    initialSchedules: initialSchedules,
    onSubmit: (model, schedules) async {
      await context.read<GroupsCubit>().updateGroup(model, schedules);
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'groupUpdatedSuccessfully'.tr(),
              style: const TextStyle(fontFamily: 'cairo'),
            ),
          ),
        );
      }
    },
  );
}

void onDeleteGroup(BuildContext context, GroupModel group) {
  showDialog<void>(
    context: context,
    builder: (_) => DeleteConfirmDialog(
      title: 'confirmDelete'.tr(),
      content: 'deleteGroupConfirmMsg'.tr(),
      onConfirm: () {
        context.read<GroupsCubit>().deleteGroup(group);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'groupDeletedSuccessfully'.tr(args: [group.name]),
              style: const TextStyle(fontFamily: 'cairo'),
            ),
          ),
        );
      },
    ),
  );
}

void openDetailsGroup(
  BuildContext context,
  GroupModel group,
  Map<String, List<GroupScheduleModel>> schedulesByGroupId,
  List<TeacherModel> teachers,
) {
  final isMobile = MediaQuery.sizeOf(context).width < SizeConfig.desktop;
  showDetailsGroup(
    context,
    child: GroupStudentsDetailView(
      group: group,
      schedules: schedulesByGroupId[group.id] ?? const [],
      isMobile: isMobile,
    ),
  );
}
