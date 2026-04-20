import 'package:edu_center_manager/features/students/data/repo/students_repo.dart';
import 'package:edu_center_manager/features/students/data/repo/students_repo_impl.dart';
import 'package:edu_center_manager/features/students/data/services/students_service.dart';
import 'package:edu_center_manager/features/students/presentation/view_model/students_cubit.dart';
import 'package:get_it/get_it.dart';


void studentsGetIt(GetIt getIt) {
  getIt.registerLazySingleton<StudentsService>(() => StudentsService());

  getIt.registerLazySingleton<StudentsRepo>(
    () => StudentsRepoImpl(studentsService: getIt<StudentsService>()),
  );

  getIt.registerFactory<StudentsCubit>(() => StudentsCubit(getIt<StudentsRepo>()));
}
