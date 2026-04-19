import 'package:easy_localization/easy_localization.dart';
import 'package:edu_center_manager/core/constants/list_subjects.dart';
import 'package:edu_center_manager/core/widgets/custom_toolbar.dart';
import 'package:edu_center_manager/features/teachers/presentation/helper/teacher_actions.dart';
import 'package:edu_center_manager/features/teachers/presentation/view_model/teacher_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TeachersToolbar extends StatelessWidget {
  const TeachersToolbar({super.key, required this.selecteSubject, required this.isMobile});

  final String selecteSubject;
  final bool isMobile;
  @override
  Widget build(BuildContext context) {
    return CustomToolbar(
      text: 'addTeacher'.tr(),
      hintTextField: 'searchForTeacher'.tr(),
      selected: selecteSubject,
      list: subjects,
      onChanged: (value) {
        if (value != null) context.read<TeacherCubit>().filterBySubject(value);
      },
      onAdd: () => onAddTeacher(context, isMobile),
      onSearch: (query) => onSearchTeacher(context, query),
    );
  }
}
