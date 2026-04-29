import 'package:easy_localization/easy_localization.dart';
import 'package:edu_center_manager/core/utils/app_style.dart';
import 'package:flutter/material.dart';

class StudentsCardHeader extends StatelessWidget {
  const StudentsCardHeader({super.key, required this.studentCount});

  final int studentCount;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          const Icon(Icons.people_alt_rounded, size: 20),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              'groups_view.students_detail.list_title'.tr(args: ['$studentCount']),
              style: AppStyles.styleRegular18(context),
            ),
          ),
        ],
      ),
    );
  }
}
