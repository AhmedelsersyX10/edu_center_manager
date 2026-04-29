import 'package:easy_localization/easy_localization.dart';
import 'package:edu_center_manager/core/widgets/delete_confirm_dialog.dart';
import 'package:edu_center_manager/core/widgets/section_card.dart';
import 'package:edu_center_manager/features/groups/data/models/group_model.dart';
import 'package:edu_center_manager/features/groups/presentation/view/widgets/details_group_widgets/students_card_body.dart';
import 'package:edu_center_manager/features/groups/presentation/view/widgets/details_group_widgets/students_card_header.dart';
import 'package:edu_center_manager/features/groups/presentation/view_model/groups_cubit.dart';
import 'package:edu_center_manager/features/students/data/models/student_model.dart';
import 'package:edu_center_manager/features/students/data/repo/students_repo_impl.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DetailsStudentsCard extends StatefulWidget {
  const DetailsStudentsCard({
    super.key,
    required this.group,
  });

  final GroupModel group;

  @override
  State<DetailsStudentsCard> createState() => DetailsStudentsCardState();
}

class DetailsStudentsCardState extends State<DetailsStudentsCard> {
  final _repo = StudentsRepoImpl();

  bool _loading = true;
  bool _bulkLoading = false;
  List<StudentModel> _inGroup = [];
  String _searchQuery = '';
  Set<String> _selectedIds = {};

  List<StudentModel> get _filteredInGroup {
    final q = _searchQuery.trim().toLowerCase();
    if (q.isEmpty) return _inGroup;
    return _inGroup.where((s) => s.name.toLowerCase().contains(q)).toList();
  }

  @override
  void initState() {
    super.initState();
    loadStudents();
  }

  @override
  Widget build(BuildContext context) {
    return SectionCard(
      backgroundColor: Theme.of(context).cardColor,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          StudentsCardHeader(studentCount: _inGroup.length),
          const Divider(height: 1),
          StudentsCardBody(
            loading: _loading,
            inGroup: _inGroup,
            filteredInGroup: _filteredInGroup,
            selectedIds: _selectedIds,
            bulkLoading: _bulkLoading,
            onSearch: (v) => setState(() => _searchQuery = v),
            onToggleStudent: _toggleStudent,
            onToggleAllVisible: _toggleAllVisible,
            onRemoveSingle: _removeSingleStudent,
            onConfirmBulkRemove: _confirmRemoveSelected,
          ),
        ],
      ),
    );
  }

  void _toggleStudent(String studentId) {
    setState(() {
      _selectedIds.contains(studentId)
          ? _selectedIds.remove(studentId)
          : _selectedIds.add(studentId);
    });
  }

  void _toggleAllVisible() {
    final visibleIds = _filteredInGroup.map((s) => s.id).toSet();
    final allSelected = visibleIds.isNotEmpty && visibleIds.every(_selectedIds.contains);
    setState(() {
      allSelected ? _selectedIds.removeAll(visibleIds) : _selectedIds.addAll(visibleIds);
    });
  }

  void _confirmRemoveSelected() {
    showDialog<void>(
      context: context,
      builder: (_) => DeleteConfirmDialog(
        title: 'confirmDelete'.tr(),
        content: 'groups_view.students_detail.remove_selected_confirm'.tr(
          args: ['${_selectedIds.length}', widget.group.name],
        ),
        onConfirm: _removeBulkStudents,
      ),
    );
  }

  Future<void> loadStudents() async {
    setState(() => _loading = true);
    try {
      final all = await _repo.getStudents();
      final ids = await _repo.getStudentIdsInGroup(widget.group.id);
      _inGroup = all.where((s) => ids.contains(s.id)).toList()
        ..sort((a, b) => a.name.compareTo(b.name));
      _selectedIds = _selectedIds.where(ids.contains).toSet();
    } finally {
      if (mounted) setState(() => _loading = false);
    }
  }

  Future<void> _removeSingleStudent(StudentModel student) async {
    try {
      await _repo.removeStudentFromGroup(widget.group.id, student.id);
      _selectedIds.remove(student.id);
      if (mounted) await loadStudents();
      await _tryRefreshGroupCounts();
    } catch (e) {
      _showError(e.toString());
    }
  }

  Future<void> _removeBulkStudents() async {
    final ids = _selectedIds.toList(growable: false);
    if (ids.isEmpty) return;

    setState(() => _bulkLoading = true);
    try {
      await Future.wait(ids.map((id) => _repo.removeStudentFromGroup(widget.group.id, id)));
      _selectedIds.clear();
      if (mounted) await loadStudents();
      await _tryRefreshGroupCounts();
    } catch (e) {
      _showError(e.toString());
    } finally {
      if (mounted) setState(() => _bulkLoading = false);
    }
  }

  Future<void> _tryRefreshGroupCounts() async {
    if (!mounted) return;
    try {
      await context.read<GroupsCubit>().refreshStudentCounts();
    } catch (_) {}
  }

  void _showError(String message) {
    if (!mounted) return;
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(message), backgroundColor: Colors.redAccent));
  }
}
