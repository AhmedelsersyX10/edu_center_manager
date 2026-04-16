import 'package:easy_localization/easy_localization.dart';
import 'package:edu_center_manager/core/widgets/custom_add_button.dart';
import 'package:edu_center_manager/core/widgets/custom_header.dart';
import 'package:edu_center_manager/features/students/presentation/helper/students_actions.dart';
import 'package:flutter/material.dart';

class StudentsHeader extends StatelessWidget {
  const StudentsHeader({super.key, required this.isMobile});

  final bool isMobile;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: CustomHeader(
            icon: Icons.group,
            title: 'studentsManagement'.tr(),
            description: 'studentsHeaderDesc'.tr(),
          ),
        ),
        CustomAddButton(text: 'addStudent'.tr(), onAdd: () => onAddStudent(context, isMobile)),
      ],
    );
  }
}
