import 'package:easy_localization/easy_localization.dart';
import 'package:edu_center_manager/core/widgets/custom_add_button.dart';
import 'package:edu_center_manager/core/widgets/custom_header.dart';
import 'package:edu_center_manager/features/groups/presentation/helper/group_actions.dart';
import 'package:edu_center_manager/features/teachers/data/models/teacher_model.dart';
import 'package:flutter/material.dart';

class GroupsHeader extends StatelessWidget {
  const GroupsHeader({super.key, required this.teacherList, required this.isMobile});

  final List<TeacherModel> teacherList;
  final bool isMobile;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: CustomHeader(
            title: 'groupsManagement'.tr(),
            description: 'groupsHeaderDesc'.tr(),
            icon: Icons.group,
          ),
        ),
        CustomAddButton(
          text: 'addGroups'.tr(),
          onAdd: () => onAddGroup(context, isMobile, teacherList),
        ),
      ],
    );
  }
}
