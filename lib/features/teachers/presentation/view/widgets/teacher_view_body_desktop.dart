import 'package:edu_center_manager/core/utils/app_style.dart';
import 'package:edu_center_manager/core/widgets/connectivity_wrapper.dart';
import 'package:edu_center_manager/features/teachers/data/models/teacher_model.dart';
import 'package:edu_center_manager/features/teachers/presentation/view/widgets/teacher_toolbar.dart';
import 'package:edu_center_manager/features/teachers/presentation/view/widgets/teachers_header.dart';
import 'package:edu_center_manager/features/teachers/presentation/view/widgets/teachers_table.dart';
import 'package:edu_center_manager/features/teachers/presentation/view_model/teacher_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TeachersViewBodyDesktop extends StatelessWidget {
  const TeachersViewBodyDesktop({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<TeacherCubit, TeacherState>(
      listener: _teachersListener,
      builder: (context, state) {
        final isLoaded = state is TeacherLoaded;
        final isLoading = state is TeacherLoading;
        final selecteSubject = isLoaded ? state.selectedSubject : 'all';
        final allTeachers = isLoaded ? state.allTeachers.length : 0;
        final teachers = isLoaded ? state.filteredTeachers : <TeacherModel>[];
        final searchQuary = isLoaded ? state.searchQuery : '';
        return ConnectivityWrapper(
          onReconnected: () => context.read<TeacherCubit>().getTeachers(),
          child: Padding(
            padding: EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TeachersHeader(isMobile: false),
                const SizedBox(height: 24),
                TeachersToolbar(selecteSubject: selecteSubject, isMobile: false),
                const SizedBox(height: 24),
                TeachersTable(
                  isLoading: isLoading,
                  teachers: teachers,
                  allTeachers: allTeachers,
                  searchQuary: searchQuary,
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _teachersListener(BuildContext context, TeacherState state) {
    if (state is TeacherError) {
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
