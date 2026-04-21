import 'package:edu_center_manager/features/settings/data/repo/settings_injection.dart';
import 'package:edu_center_manager/features/students/data/repo/students_injection.dart';
import 'package:edu_center_manager/features/teachers/data/repo/teachers_injection.dart';
import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;

void setupServiceLocator() {
  studentsGetIt(getIt);
  teachersGetIt(getIt);
  settingsGetIt(getIt);
}
