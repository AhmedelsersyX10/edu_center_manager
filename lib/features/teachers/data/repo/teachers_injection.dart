import 'package:edu_center_manager/features/teachers/data/repo/teacher_repo.dart';
import 'package:edu_center_manager/features/teachers/data/repo/teacher_repo_impl.dart';
import 'package:edu_center_manager/features/teachers/data/service/teacher_service.dart';
import 'package:edu_center_manager/features/teachers/presentation/view_model/teacher_cubit.dart';
import 'package:get_it/get_it.dart';


void teachersGetIt(GetIt getIt) {
  getIt.registerLazySingleton<TeacherService>(() => TeacherService());
  getIt.registerLazySingleton<TeacherRepo>(
    () => TeacherRepoImpl(teacherService: getIt<TeacherService>()),
  );
  getIt.registerFactory<TeacherCubit>(() => TeacherCubit(getIt<TeacherRepo>()));
}
