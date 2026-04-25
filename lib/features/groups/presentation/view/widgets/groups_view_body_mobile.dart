import 'package:edu_center_manager/core/helper/show_error_message.dart';
import 'package:edu_center_manager/core/widgets/connectivity_wrapper.dart';
import 'package:edu_center_manager/features/groups/data/models/group_model.dart';
import 'package:edu_center_manager/features/groups/data/models/group_schedule_model.dart';
import 'package:edu_center_manager/features/groups/presentation/view/widgets/groups_header.dart';
import 'package:edu_center_manager/features/groups/presentation/view_model/groups_cubit.dart';
import 'package:edu_center_manager/features/teachers/data/models/teacher_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class GroupsViewBodyMobile extends StatelessWidget {
  const GroupsViewBodyMobile({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<GroupsCubit, GroupsState>(
      listener: _groupsListener,
      builder: (context, state) {
        final isLoading = state is GroupsLoading;
        final isLoaded = state is GroupsLoaded;
        final groups = isLoaded ? state.filteredGroups : <GroupModel>[];
        final allCount = isLoaded ? state.allGroups.length : 0;
        final teacherList = isLoaded ? state.teachers : <TeacherModel>[];
        final selectedTeacher = isLoaded ? state.selectedTeacherId : GroupsCubit.filterAll;
        final filteredEmpty = groups.isEmpty && allCount > 0;
        final schedulesByGroupId = isLoaded
            ? state.schedulesByGroupId
            : const <String, List<GroupScheduleModel>>{};
        final studentCountByGroupId = isLoaded
            ? state.studentCountByGroupId
            : const <String, int>{};
        final scheduleRowsCount = isLoaded
            ? state.schedulesByGroupId.values.fold<int>(0, (a, b) => a + b.length)
            : 0;
        return ConnectivityWrapper(
          onReconnected: () => context.read<GroupsCubit>().getGroups(),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [GroupsHeader(teacherList: teacherList, isMobile: true)],
            ),
          ),
        );
      },
    );
  }

  void _groupsListener(BuildContext context, GroupsState state) {
    if (state is GroupsError) {
      context.showErrorMessage(state.message);
    }
  }
}
