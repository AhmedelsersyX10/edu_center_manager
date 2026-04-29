import 'package:easy_localization/easy_localization.dart';
import 'package:edu_center_manager/core/utils/app_style.dart';
import 'package:edu_center_manager/core/widgets/custom_empty_state.dart';
import 'package:edu_center_manager/core/widgets/selectable_entity_list.dart';
import 'package:edu_center_manager/core/widgets/section_card.dart';
import 'package:edu_center_manager/features/groups/data/models/group_model.dart';
import 'package:edu_center_manager/features/groups/presentation/view/widgets/details_group_widgets/bulk_action_bar.dart';
import 'package:edu_center_manager/features/groups/presentation/view/widgets/details_group_widgets/filters_header.dart';
import 'package:edu_center_manager/features/groups/presentation/view/widgets/details_group_widgets/select_all_visible_row.dart';
import 'package:edu_center_manager/features/groups/presentation/view/widgets/details_group_widgets/student_list_item.dart';
import 'package:edu_center_manager/features/students/data/models/student_model.dart';
import 'package:edu_center_manager/features/students/data/repo/students_repo_impl.dart';
import 'package:edu_center_manager/features/students/presentation/view_model/grade_helper.dart';
import 'package:flutter/material.dart';

class AddStudentsToGroupView extends StatefulWidget {
  final GroupModel group;
  final bool isMobile;

  const AddStudentsToGroupView({super.key, required this.group, this.isMobile = true});

  @override
  State<AddStudentsToGroupView> createState() => _AddStudentsToGroupViewState();
}

class _AddStudentsToGroupViewState extends State<AddStudentsToGroupView> {
  final repo = StudentsRepoImpl();

  List<StudentModel> eligible = [];
  bool loading = true;
  String? error;
  String searchQuery = '';
  String? gradeFilterKey;
  final Set<String> _selectedIds = {};
  bool bulkLoading = false;
  int studentsInGroupCount = 0;

  List<StudentModel> get _visible {
    Iterable<StudentModel> list = eligible;
    if (gradeFilterKey != null) {
      list = list.where((s) => GradeHelper.gradeKeys(s.grade) == gradeFilterKey);
    }
    final q = searchQuery.trim().toLowerCase();
    if (q.isNotEmpty) {
      list = list.where((s) => s.name.toLowerCase().contains(q));
    }
    return list.toList();
  }

  int get _selectedEligibleCount => eligible.where((s) => _selectedIds.contains(s.id)).length;

  void _toggleSelectAllVisible() {
    final visibleIds = _visible.map((s) => s.id).toSet();
    if (visibleIds.isEmpty) return;
    final allSelected = visibleIds.every(_selectedIds.contains);
    setState(() {
      if (allSelected) {
        _selectedIds.removeAll(visibleIds);
      } else {
        _selectedIds.addAll(visibleIds);
      }
    });
  }

  void _toggleOne(String id) {
    setState(() {
      if (_selectedIds.contains(id)) {
        _selectedIds.remove(id);
      } else {
        _selectedIds.add(id);
      }
    });
  }

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    setState(() {
      loading = true;
      error = null;
    });
    try {
      final all = await repo.getStudents();
      final gid = widget.group.id;
      final inGroup = await repo.getStudentIdsInGroup(gid);
      studentsInGroupCount = inGroup.length;
      eligible = all.where((s) => !inGroup.contains(s.id)).toList()
        ..sort((a, b) => a.name.compareTo(b.name));
    } catch (e) {
      error = e.toString();
    } finally {
      if (mounted) setState(() => loading = false);
    }
  }

  Future<void> _assign(StudentModel student) async {
    if (bulkLoading) return;
    try {
      await repo.addStudentsToGroup(widget.group.id, [student.id]);
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'groups_view.details_group.added_snackbar'.tr(args: [student.name]),
            style: const TextStyle(fontFamily: 'cairo'),
          ),
        ),
      );
      setState(() {
        studentsInGroupCount++;
        eligible.removeWhere((s) => s.id == student.id);
        _selectedIds.remove(student.id);
      });
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(e.toString(), style: const TextStyle(fontFamily: 'cairo')),
          backgroundColor: Colors.redAccent,
        ),
      );
    }
  }

  Future<void> _assignSelected() async {
    final toAdd = eligible.where((s) => _selectedIds.contains(s.id)).toList();
    if (toAdd.isEmpty) return;
    setState(() => bulkLoading = true);
    try {
      await repo.addStudentsToGroup(widget.group.id, toAdd.map((s) => s.id).toList());
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'groups_view.details_group.added_bulk_snackbar'.tr(args: ['${toAdd.length}']),
            style: const TextStyle(fontFamily: 'cairo'),
          ),
        ),
      );
      setState(() {
        studentsInGroupCount += toAdd.length;
        final ids = toAdd.map((s) => s.id).toSet();
        eligible.removeWhere((s) => ids.contains(s.id));
        _selectedIds.removeAll(ids);
        bulkLoading = false;
      });
    } catch (e) {
      if (!mounted) return;
      setState(() => bulkLoading = false);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(e.toString(), style: const TextStyle(fontFamily: 'cairo')),
          backgroundColor: Colors.redAccent,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    if (loading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (eligible.isEmpty) {
      return Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            IconButton(
              icon: const Icon(Icons.close_rounded),
              onPressed: () => Navigator.of(context).maybePop(),
            ),
            const SizedBox(height: 12),
            const CustomEmptyState(
              text: 'groups_view.details_group.none_available',
              icon: Icons.group_rounded,
            ),
          ],
        ),
      );
    }

    return SectionCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.close_rounded),
                  onPressed: () => Navigator.of(context).maybePop(),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    'groups_view.details_group.title'.tr(),
                    style: AppStyles.styleBold20(context),
                  ),
                ),
                if (!loading && error == null)
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(20)),
                    child: Text(
                      'groups_view.table.labels.students_of_max'.tr(
                        args: ['$studentsInGroupCount', '${widget.group.maxStudents}'],
                      ),
                      style: AppStyles.styleBold12(context),
                    ),
                  ),
              ],
            ),
          ),
          const Divider(height: 1),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                FiltersHeader(
                  searchQuery: searchQuery,
                  gradeFilterKey: gradeFilterKey,
                  onSearchChanged: (v) => setState(() => searchQuery = v),
                  onGradeChanged: (v) => setState(() => gradeFilterKey = v),
                ),
                SelectAllVisibleRow(
                  visible: _visible,
                  selectedIds: _selectedIds,
                  bulkLoading: bulkLoading,
                  onToggle: _toggleSelectAllVisible,
                ),
                Expanded(
                  child: SelectableEntityList<StudentModel>(
                    items: _visible,
                    itemBuilder: (context, student) => StudentListItem(
                      student: student,
                      isSelected: _selectedIds.contains(student.id),
                      isDisabled: bulkLoading,
                      onToggleSelect: () => _toggleOne(student.id),
                      onRemove: () => _assign(student),
                    ),
                  ),
                ),
                BulkActionBar(
                  selectedCount: _selectedEligibleCount,
                  bulkLoading: bulkLoading,
                  onAssign: _assignSelected,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
