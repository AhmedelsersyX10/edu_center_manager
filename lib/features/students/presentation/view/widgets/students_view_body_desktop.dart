import 'package:edu_center_manager/core/utils/app_style.dart';
import 'package:edu_center_manager/core/widgets/connectivity_wrapper.dart';
import 'package:edu_center_manager/features/students/data/models/student_model.dart';
import 'package:edu_center_manager/features/students/presentation/view/widgets/students_header.dart';
import 'package:edu_center_manager/features/students/presentation/view/widgets/students_table.dart';
import 'package:edu_center_manager/features/students/presentation/view/widgets/students_toolbar.dart';
import 'package:edu_center_manager/features/students/presentation/view_model/students_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class StudentsViewBodyDesktop extends StatelessWidget {
  const StudentsViewBodyDesktop({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<StudentsCubit, StudentsState>(
      listener: _studentsListener,
      builder: (context, state) {
        final isLoaded = state is StudentsLoaded;
        final isLoading = state is StudentsLoading;
        final selectedGrade = isLoaded ? state.selectedGrade : 'all';
        final allCount = isLoaded ? state.allStudents.length : 0;
        final students = isLoaded ? state.filteredStudents : <StudentModel>[];
        return ConnectivityWrapper(
          onReconnected: () => context.read<StudentsCubit>().getStudents(),
          child: Padding(
            padding: EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                StudentsHeader(isMobile: false),
                const SizedBox(height: 24),
                StudentsToolbar(selectedGrade: selectedGrade, isMobile: false),
                const SizedBox(height: 24),
                StudentsTable(isLoading: isLoading, students: students, allCount: allCount),
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
