import 'package:easy_localization/easy_localization.dart';
import 'package:edu_center_manager/core/constants/list_grades.dart';
import 'package:edu_center_manager/core/widgets/custom_toolbar.dart';
import 'package:edu_center_manager/features/students/presentation/helper/students_actions.dart';
import 'package:edu_center_manager/features/students/presentation/view_model/students_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class StudentsToolbar extends StatelessWidget {
  const StudentsToolbar({super.key, required this.selectedGrade, required this.isMobile});

  final String selectedGrade;
  final bool isMobile;
  @override
  Widget build(BuildContext context) {
    return CustomToolbar(
      text: 'addStudent'.tr(),
      hintTextField: 'searchForStudent'.tr(),
      selected: selectedGrade,
      list: grades,
      onChanged: (value) {
        if (value != null) context.read<StudentsCubit>().filterByGrade(value);
      },
      onAdd: () => onAddStudent(context, isMobile),
      onSearch: (query) => onSearch(context, query),
    );
  }
}
