import 'package:easy_localization/easy_localization.dart';
import 'package:edu_center_manager/core/utils/app_style.dart';
import 'package:edu_center_manager/core/utils/app_themes.dart';
import 'package:edu_center_manager/features/groups/presentation/view_model/groups_cubit.dart';
import 'package:edu_center_manager/features/teachers/data/models/teacher_model.dart';
import 'package:flutter/material.dart';

class CustomGroupFilterDropdown extends StatelessWidget {
  const CustomGroupFilterDropdown({
    super.key,
    required this.selectedTeacherId,
    required this.onTeacherChanged,
    required this.teachers,
  });

  final String selectedTeacherId;
  final ValueChanged<String?> onTeacherChanged;
  final List<TeacherModel> teachers;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: context.colors.cardBackground,
        border: Border.all(color: context.colors.border),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: selectedTeacherId,
          isExpanded: true,
          icon: const Icon(Icons.person_search_outlined),
          style: AppStyles.styleRegular14(context).copyWith(color: context.colors.hintText),
          onChanged: onTeacherChanged,
          items: [
            DropdownMenuItem<String>(
              value: GroupsCubit.filterAll,
              child: Text('groups_view.toolbar.filter_teacher_all'.tr()),
            ),
            ...teachers.map(
              (t) => DropdownMenuItem<String>(
                value: t.id,
                child: Text(t.name, overflow: TextOverflow.ellipsis),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
