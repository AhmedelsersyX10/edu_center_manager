import 'package:edu_center_manager/features/attendance/data/models/attendance_model.dart';
import 'package:edu_center_manager/features/attendance/data/repo/attendance_repo.dart';
import 'package:edu_center_manager/features/groups/data/models/group_model.dart';
import 'package:edu_center_manager/features/groups/data/repo/groups_repo.dart';
import 'package:edu_center_manager/features/students/data/models/student_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'attendance_state.dart';

class AttendanceCubit extends Cubit<AttendanceState> {
  final AttendanceRepo _attendanceRepository;
  final GroupsRepo _groupsRepository;

  AttendanceCubit(this._attendanceRepository, this._groupsRepository)
      : super(AttendanceInitial());

  List<GroupModel> _groups = [];
  List<StudentModel> _students = [];
  Map<String, AttendanceStatus> _attendanceByStudentId = {};
  String _selectedGroupId = '';
  DateTime _selectedDate = DateTime.now();
  String _searchQuery = '';
  AttendanceStatus? _selectedStatusFilter;
  Map<String, bool> _rowLoadingByStudentId = {};

  _AttendanceActionSnapshot? _lastAction;

  Future<void> initialize() async {
    emit(AttendanceLoading());
    try {
      _groups = await _groupsRepository.getGroups();
      _selectedGroupId = _groups.isNotEmpty ? _groups.first.id : '';

      if (_selectedGroupId.isNotEmpty) {
        await fetchStudents(emitLoading: false);
        await fetchAttendance(emitLoading: false);
      } else {
        _students = [];
        _attendanceByStudentId = {};
      }

      _emitLoadedState();
    } catch (e) {
      emit(AttendanceError(_extractMessage(e)));
    }
  }

  Future<void> fetchStudents({bool emitLoading = true}) async {
    if (_selectedGroupId.isEmpty) return;
    if (emitLoading) emit(AttendanceLoading());

    try {
      _students = await _attendanceRepository.getStudentsByGroup(_selectedGroupId);
      _emitLoadedState();
    } catch (e) {
      emit(AttendanceError(_extractMessage(e)));
    }
  }

  Future<void> fetchAttendance({bool emitLoading = true}) async {
    if (_selectedGroupId.isEmpty) return;
    if (emitLoading) emit(AttendanceLoading());

    try {
      final attendanceRecords = await _attendanceRepository.getAttendanceByDate(
        _selectedDate,
        _selectedGroupId,
      );
      _attendanceByStudentId = {
        for (final a in attendanceRecords) a.studentId: a.status,
      };
      _ensureDefaultStatuses();
      _emitLoadedState();
    } catch (e) {
      emit(AttendanceError(_extractMessage(e)));
    }
  }

  Future<void> changeGroup(String groupId) async {
    if (_selectedGroupId == groupId) return;
    _selectedGroupId = groupId;
    _searchQuery = '';
    _selectedStatusFilter = null;
    _lastAction = null;
    emit(AttendanceLoading());
    try {
      _students = await _attendanceRepository.getStudentsByGroup(_selectedGroupId);
      final attendanceRecords = await _attendanceRepository.getAttendanceByDate(
        _selectedDate,
        _selectedGroupId,
      );
      _attendanceByStudentId = {
        for (final a in attendanceRecords) a.studentId: a.status,
      };
      _ensureDefaultStatuses();
      _emitLoadedState();
    } catch (e) {
      emit(AttendanceError(_extractMessage(e)));
    }
  }

  Future<void> changeDate(DateTime date) async {
    _selectedDate = DateTime(date.year, date.month, date.day);
    _lastAction = null;
    await fetchAttendance();
  }

  Future<void> markAttendance({
    required String studentId,
    required AttendanceStatus status,
  }) async {
    if (_selectedGroupId.isEmpty) return;

    final oldStatus = _attendanceByStudentId[studentId] ?? AttendanceStatus.absent;
    if (oldStatus == status) return;

    _rowLoadingByStudentId = {..._rowLoadingByStudentId, studentId: true};
    _attendanceByStudentId = {..._attendanceByStudentId, studentId: status};
    _emitLoadedState();

    try {
      await _attendanceRepository.updateAttendance(
        studentId: studentId,
        groupId: _selectedGroupId,
        status: status,
        date: _selectedDate,
      );

      _lastAction = _AttendanceActionSnapshot(
        studentId: studentId,
        previousStatus: oldStatus,
        currentStatus: status,
      );
    } catch (e) {
      _attendanceByStudentId[studentId] = oldStatus;
      emit(AttendanceError(_extractMessage(e)));
    } finally {
      _rowLoadingByStudentId = {..._rowLoadingByStudentId, studentId: false};
      _emitLoadedState();
    }
  }

  Future<void> undoAttendance() async {
    if (_lastAction == null || _selectedGroupId.isEmpty) return;

    final snapshot = _lastAction!;
    _rowLoadingByStudentId = {..._rowLoadingByStudentId, snapshot.studentId: true};

    _attendanceByStudentId[snapshot.studentId] = snapshot.previousStatus;
    _emitLoadedState();

    try {
      await _attendanceRepository.updateAttendance(
        studentId: snapshot.studentId,
        groupId: _selectedGroupId,
        status: snapshot.previousStatus,
        date: _selectedDate,
      );
      _lastAction = null;
    } catch (e) {
      _attendanceByStudentId[snapshot.studentId] = snapshot.currentStatus;
      emit(AttendanceError(_extractMessage(e)));
    } finally {
      _rowLoadingByStudentId = {..._rowLoadingByStudentId, snapshot.studentId: false};
      _emitLoadedState();
    }
  }

  Future<void> markAllFiltered(
    AttendanceStatus status, {
    required bool confirmed,
  }) async {
    if (!confirmed || state is! AttendanceLoaded) return;
    final loaded = state as AttendanceLoaded;
    for (final student in loaded.filteredStudents) {
      await markAttendance(studentId: student.id, status: status);
    }
  }

  void searchStudents(String query) {
    _searchQuery = query;
    _emitLoadedState();
  }

  void filterByStatus(AttendanceStatus? status) {
    _selectedStatusFilter = status;
    _emitLoadedState();
  }

  void _emitLoadedState() {
    final normalizedQuery = _searchQuery.trim().toLowerCase();

    var filtered = List<StudentModel>.from(_students);
    if (normalizedQuery.isNotEmpty) {
      filtered = filtered.where((s) => s.name.toLowerCase().contains(normalizedQuery)).toList();
    }

    if (_selectedStatusFilter != null) {
      filtered = filtered.where((s) => _attendanceByStudentId[s.id] == _selectedStatusFilter).toList();
    }

    emit(AttendanceLoaded(
      groups: _groups,
      students: _students,
      filteredStudents: filtered,
      attendanceByStudentId: _attendanceByStudentId,
      selectedGroupId: _selectedGroupId,
      selectedDate: _selectedDate,
      searchQuery: _searchQuery,
      selectedStatusFilter: _selectedStatusFilter,
      rowLoadingByStudentId: _rowLoadingByStudentId,
      hasUndoAction: _lastAction != null,
    ));
  }

  void _ensureDefaultStatuses() {
    for (final student in _students) {
      _attendanceByStudentId.putIfAbsent(student.id, () => AttendanceStatus.absent);
    }
  }

  String _extractMessage(Object e) {
    final msg = e.toString();
    if (msg.startsWith('Exception: ')) {
      return msg.substring(11);
    }
    return msg;
  }
}

class _AttendanceActionSnapshot {
  final String studentId;
  final AttendanceStatus previousStatus;
  final AttendanceStatus currentStatus;

  _AttendanceActionSnapshot({
    required this.studentId,
    required this.previousStatus,
    required this.currentStatus,
  });
}
