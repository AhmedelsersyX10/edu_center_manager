import 'package:easy_localization/easy_localization.dart';
import 'package:edu_center_manager/core/utils/app_style.dart';
import 'package:edu_center_manager/core/widgets/custom_add_button.dart';
import 'package:edu_center_manager/core/widgets/section_card.dart';
import 'package:edu_center_manager/features/groups/data/models/group_model.dart';
import 'package:edu_center_manager/features/groups/data/models/group_schedule_model.dart';
import 'package:edu_center_manager/features/groups/presentation/view/widgets/details_group_widgets/add_students_to_group_view.dart';
import 'package:edu_center_manager/features/groups/presentation/view/widgets/details_group_widgets/details_schedules_card.dart';
import 'package:edu_center_manager/features/groups/presentation/view/widgets/details_group_widgets/details_students_card.dart';
import 'package:edu_center_manager/features/groups/presentation/view/widgets/show_details_group.dart';
import 'package:edu_center_manager/features/groups/presentation/view_model/groups_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class GroupStudentsDetailView extends StatefulWidget {
  final GroupModel group;
  final List<GroupScheduleModel> schedules;
  final bool isMobile;

  const GroupStudentsDetailView({
    super.key,
    required this.group,
    this.schedules = const [],
    this.isMobile = true,
  });

  @override
  State<GroupStudentsDetailView> createState() => _GroupStudentsDetailViewState();
}

class _GroupStudentsDetailViewState extends State<GroupStudentsDetailView> {
  final GlobalKey<DetailsStudentsCardState> _studentsCardKey = GlobalKey();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final group = widget.group;

    return SectionCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: () => Navigator.of(context).pop(),
                ),
                const SizedBox(width: 12),
                Expanded(child: Text(group.name, style: AppStyles.styleBold20(context))),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                  child: CustomAddButton(
                    text: 'groups_view.students_detail.add_student'.tr(),
                    onAdd: _openAddStudents,
                  ),
                ),
              ],
            ),
          ),
          const Divider(height: 2),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const SizedBox(height: 16),
                    if (widget.schedules.isNotEmpty) ...[
                      DetailsSchedulesCard(groupDetailsView: widget),
                      const SizedBox(height: 16),
                    ],
                    DetailsStudentsCard(
                      key: _studentsCardKey,
                      group: group,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _openAddStudents() async {
    await showDetailsGroup(
      context,
      child: AddStudentsToGroupView(group: widget.group, isMobile: widget.isMobile),
    );
    if (!mounted) return;
    _studentsCardKey.currentState?.loadStudents();
    await _tryRefreshGroupCounts();
  }

  Future<void> _tryRefreshGroupCounts() async {
    if (!mounted) return;
    try {
      await context.read<GroupsCubit>().refreshStudentCounts();
    } catch (_) {}
  }
}
