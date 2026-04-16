import 'package:edu_center_manager/core/utils/app_style.dart';
import 'package:edu_center_manager/core/widgets/connectivity_wrapper.dart';
import 'package:edu_center_manager/features/students/data/models/student_model.dart';
import 'package:edu_center_manager/features/students/presentation/view/widgets/student_list.dart';
import 'package:edu_center_manager/features/students/presentation/view/widgets/students_header.dart';
import 'package:edu_center_manager/features/students/presentation/view/widgets/students_toolbar.dart';
import 'package:edu_center_manager/features/students/presentation/view_model/students_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class StudentsViewBodyMobile extends StatelessWidget {
  const StudentsViewBodyMobile({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<StudentsCubit, StudentsState>(
      listener: _studentsListener,
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
                StudentsHeader(isMobile: true),
                const SizedBox(height: 16),
                StudentsToolbar(selectedGrade: selectedGrade, isMobile: true),
                const SizedBox(height: 16),
                StudentList(isLoading: isLoading, students: students, allCount: allCount),
              ],
            ),
          ),
        );
      },
    );
  }

  void _studentsListener(BuildContext context, StudentsState state) {
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
  }
}
