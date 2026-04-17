import 'package:edu_center_manager/features/students/data/models/student_model.dart';
import 'package:edu_center_manager/features/students/data/repo/students_repo.dart';
import 'package:edu_center_manager/features/students/presentation/view_model/grade_helper.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'students_state.dart';

class StudentsCubit extends Cubit<StudentsState> {
  final StudentsRepo studentsRepo;

  StudentsCubit(this.studentsRepo) : super(StudentsInitial());

  List<StudentModel> allStudents = [];
  String searchQuery = '';
  String selectedGrade = 'all';

  Future<void> getStudents() async {
    emit(StudentsLoading());
    try {
      allStudents = await studentsRepo.getStudents();
      _emitLoadedState();
    } catch (e) {
      emit(StudentsError(_errorMessage(e)));
    }
  }

  Future<void> addStudent(StudentModel student) async {
    emit(StudentsLoading());
    try {
      final newStudent = await studentsRepo.addStudent(student);
      allStudents.insert(0, newStudent);
      _emitLoadedState();
    } catch (e) {
      emit(StudentsError(_errorMessage(e)));
    }
  }

  Future<void> updateStudent(StudentModel student) async {
    emit(StudentsLoading());
    try {
      final newStudent = await studentsRepo.updateStudent(student);
      allStudents[allStudents.indexWhere((element) => element.id == student.id)] = newStudent;
      _emitLoadedState();
    } catch (e) {
      emit(StudentsError(_errorMessage(e)));
    }
  }

  Future<void> deleteStudent(String id) async {
    emit(StudentsLoading());
    try {
      await studentsRepo.deleteStudent(id);
      allStudents.removeWhere((element) => element.id == id);
      _emitLoadedState();
    } catch (e) {
      emit(StudentsError(_errorMessage(e)));
    }
  }

  void searchStudents(String query) {
    searchQuery = query;
    _emitLoadedState();
  }

  void filterByGrade(String grade) {
    selectedGrade = grade;
    _emitLoadedState();
  }

  void _emitLoadedState() {
    List<StudentModel> filtered = allStudents;

    if (selectedGrade != 'all') {
      filtered = filtered
          .where(
            (student) =>
                GradeHelper.gradeKeys(student.grade) == GradeHelper.gradeKeys(selectedGrade),
          )
          .toList();
    }

    if (searchQuery.trim().isNotEmpty) {
      final query = searchQuery.trim().toLowerCase();
      filtered = filtered.where((student) => student.name.toLowerCase().contains(query)).toList();
    }

    emit(
      StudentsLoaded(
        allStudents: allStudents,
        filteredStudents: filtered,
        searchQuery: searchQuery,
        selectedGrade: selectedGrade,
      ),
    );
  }

  String _errorMessage(Object error) {
    final message = error.toString();
    if (message.startsWith('Exception: ')) {
      return message.substring(11);
    }
    return message;
  }
}
