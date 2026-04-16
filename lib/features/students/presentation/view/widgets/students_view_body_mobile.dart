import 'package:easy_localization/easy_localization.dart';
import 'package:edu_center_manager/core/constants/list_grades.dart';
import 'package:edu_center_manager/core/utils/app_style.dart';
import 'package:edu_center_manager/core/widgets/connectivity_wrapper.dart';
import 'package:edu_center_manager/core/widgets/custom_add_button.dart';
import 'package:edu_center_manager/core/widgets/custom_header.dart';
import 'package:edu_center_manager/core/widgets/custom_animated_switcher.dart';
import 'package:edu_center_manager/core/widgets/custom_toolbar.dart';
import 'package:edu_center_manager/features/students/data/models/student_model.dart';
import 'package:edu_center_manager/core/widgets/delete_confirm_dialog.dart';
import 'package:edu_center_manager/features/students/presentation/view/widgets/custom_mobile_list_view.dart';
import 'package:edu_center_manager/features/students/presentation/view/widgets/show_add_student_form.dart';
import 'package:edu_center_manager/features/students/presentation/view_model/students_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class StudentsViewBodyMobile extends StatelessWidget {
  const StudentsViewBodyMobile({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<StudentsCubit, StudentsState>(
      listener: (context, state) {
        if (state is StudentsError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                state.message,
                style: AppStyles.styleBold18(
                  context,
                ).copyWith(color: Theme.of(context).colorScheme.onPrimary),
              ),
              backgroundColor: Colors.red,
            ),
          );
        }
      },
      builder: (context, state) {
        final selectedGrade = state is StudentsLoaded ? state.selectedGrade : 'all';
        final isLoading = state is StudentsLoading;
        final allCount = state is StudentsLoaded ? state.allStudents.length : 0;
        final students = state is StudentsLoaded ? state.filteredStudents : <StudentModel>[];
        return ConnectivityWrapper(
          onReconnected: () => context.read<StudentsCubit>().getStudents(),
          child: Padding(
            padding: EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: CustomHeader(
                        icon: Icons.group,
                        title: 'studentsManagement'.tr(),
                        description: 'studentsHeaderDesc'.tr(),
                      ),
                    ),
                    CustomAddButton(text: 'addStudent'.tr(), onAdd: () => _onAddStudent(context)),
                  ],
                ),
                const SizedBox(height: 16),
                CustomToolbar(
                  text: 'addStudent'.tr(),
                  hintTextField: 'searchForStudent'.tr(),
                  selected: selectedGrade,
                  list: grades,
                  onChanged: (value) {
                    if (value != null) context.read<StudentsCubit>().filterByGrade(value);
                  },
                  onAdd: () => _onAddStudent(context),
                  onSearch: (query) => _onSearch(context, query),
                ),
                const SizedBox(height: 16),
                Expanded(
                  child: CustomAnimatedSwitcher(
                    isLoading: isLoading,
                    students: students,
                    allCount: allCount,
                    child: CustomMobileListView(
                      students: students,
                      onEdit: (student) => _onEditStudent(context, student),
                      onDelete: (student) => _onDeleteStudent(context, student),
                      isLoading: isLoading,
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _onSearch(BuildContext context, String query) {
    context.read<StudentsCubit>().searchStudents(query);
  }

  void _onAddStudent(BuildContext context) {
    showStudentForm(
      context,
      onSubmit: (newStudent) async {
        await context.read<StudentsCubit>().addStudent(newStudent);
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                'studentAddedSuccessfully'.tr(),
                style: AppStyles.styleBold16(
                  context,
                ).copyWith(color: Theme.of(context).colorScheme.onPrimary),
              ),
            ),
          );
        }
      },
    );
  }

  void _onEditStudent(BuildContext context, StudentModel student) {
    showStudentForm(
      context,
      student: student,
      onSubmit: (updatedStudent) async {
        await context.read<StudentsCubit>().updateStudent(updatedStudent);
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                'studentUpdatedSuccessfully'.tr(),
                style: AppStyles.styleBold18(
                  context,
                ).copyWith(color: Theme.of(context).colorScheme.onPrimary),
              ),
            ),
          );
        }
      },
    );
  }

  void _onDeleteStudent(BuildContext context, StudentModel student) {
    showDialog(
      context: context,
      builder: (_) => DeleteConfirmDialog(
        onConfirm: () {
          context.read<StudentsCubit>().deleteStudent(student.id);
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                'studentDeletedSuccessfully'.tr(args: [student.name]),
                style: AppStyles.styleBold18(
                  context,
                ).copyWith(color: Theme.of(context).colorScheme.onPrimary),
              ),
            ),
          );
        },
      ),
    );
  }
}
