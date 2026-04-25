import 'package:edu_center_manager/core/utils/app_themes.dart';
import 'package:edu_center_manager/features/groups/data/models/group_model.dart';
import 'package:edu_center_manager/features/groups/data/models/group_schedule_model.dart';
import 'package:edu_center_manager/features/groups/presentation/view/widgets/custom_button_details_group.dart';
import 'package:edu_center_manager/features/groups/presentation/view/widgets/custom_info_group_card.dart';
import 'package:edu_center_manager/features/groups/presentation/view/widgets/header_group_card.dart';
import 'package:edu_center_manager/features/teachers/data/models/teacher_model.dart';
import 'package:expansion_tile_card/expansion_tile_card.dart';
import 'package:flutter/material.dart';

class GroupCard extends StatelessWidget {
  final GroupModel group;
  final List<TeacherModel> teachers;
  final List<GroupScheduleModel> schedules;

  final int studentsInGroup;
  final VoidCallback onStudents;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  const GroupCard({
    super.key,
    required this.group,
    required this.teachers,
    this.schedules = const [],
    this.studentsInGroup = 0,
    required this.onStudents,
    required this.onEdit,
    required this.onDelete,
  });

  String _teacherLabel() {
    final id = group.teacherId;
    if (id == null || id.isEmpty) return '—';
    for (final t in teachers) {
      if (t.id == id) return t.name;
    }
    return id;
  }

  @override
  Widget build(BuildContext context) {
    final teacherLabel = _teacherLabel();
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: ExpansionTileCard(
        borderRadius: BorderRadius.circular(16),
        expandedTextColor: context.colors.primaryText,
        title: HeaderGroupCard(group: group, onEdit: onEdit, onDelete: onDelete),
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Divider(height: 1),
              CustomInfoGroupCard(
                teacherLabel: teacherLabel,
                group: group,
                studentsInGroup: studentsInGroup,
                schedules: schedules,
              ),
              const Divider(height: 1),
              CustomActionsButtonsGroup(onStudents: onStudents, onEdit: onEdit, onDelete: onDelete),
            ],
          ),
        ],
      ),
    );
  }
}
