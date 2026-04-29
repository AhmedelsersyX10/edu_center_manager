import 'package:easy_localization/easy_localization.dart';
import 'package:edu_center_manager/core/widgets/custom_empty_state.dart';
import 'package:edu_center_manager/features/groups/data/models/group_model.dart';
import 'package:edu_center_manager/features/groups/data/models/group_schedule_model.dart';
import 'package:edu_center_manager/features/groups/presentation/helper/group_actions.dart';
import 'package:edu_center_manager/features/groups/presentation/view/widgets/group_card.dart';
import 'package:edu_center_manager/features/groups/presentation/view/widgets/shimmer_info_group_card.dart';
import 'package:edu_center_manager/features/teachers/data/models/teacher_model.dart';
import 'package:expansion_tile_card/expansion_tile_card.dart';
import 'package:flutter/material.dart';

class CustomMobileGroupCardList extends StatefulWidget {
  const CustomMobileGroupCardList({
    super.key,
    required this.groups,
    required this.teachers,
    required this.schedulesByGroupId,
    required this.studentCountByGroupId,
    required this.isLoading,
    required this.allCount,
    required this.filteredEmpty,
  });

  final List<GroupModel> groups;
  final List<TeacherModel> teachers;
  final Map<String, List<GroupScheduleModel>> schedulesByGroupId;
  final Map<String, int> studentCountByGroupId;
  final bool isLoading;
  final int allCount;
  final bool filteredEmpty;

  @override
  State<CustomMobileGroupCardList> createState() => _CustomMobileGroupCardListState();
}

class _CustomMobileGroupCardListState extends State<CustomMobileGroupCardList> {
  late List<GlobalKey<ExpansionTileCardState>> _keys;

  @override
  void initState() {
    super.initState();
    _buildKeys();
  }

  @override
  void didUpdateWidget(CustomMobileGroupCardList oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.groups.length != widget.groups.length) {
      _buildKeys();
    }
  }

  void _buildKeys() {
    _keys = List.generate(widget.groups.length, (_) => GlobalKey<ExpansionTileCardState>());
  }

  void _collapseOthers(int expandedIndex) {
    for (int i = 0; i < _keys.length; i++) {
      if (i != expandedIndex) {
        _keys[i].currentState?.collapse();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    if (widget.isLoading) {
      return const ShimmerGroupCard();
    }

    if (widget.groups.isEmpty) {
      return CustomEmptyState(
        text: widget.filteredEmpty ? 'groupsViewEmptySearch'.tr() : 'groupsViewEmptyNone'.tr(),
        icon: Icons.group,
      );
    }

    return ListView.builder(
      itemCount: widget.groups.length,
      itemBuilder: (context, index) {
        final group = widget.groups[index];
        return GroupCard(
          cardKey: _keys[index],
          onExpansionChanged: () => _collapseOthers(index),
          group: group,
          teachers: widget.teachers,
          schedules: widget.schedulesByGroupId[group.id] ?? const [],
          studentsInGroup: widget.studentCountByGroupId[group.id] ?? 0,
          onStudents: () =>
              openDetailsGroup(context, group, widget.schedulesByGroupId, widget.teachers),
          onEdit: () => onEditGroup(context, group, true, widget.teachers),
          onDelete: () => onDeleteGroup(context, group),
        );
      },
    );
  }
}
