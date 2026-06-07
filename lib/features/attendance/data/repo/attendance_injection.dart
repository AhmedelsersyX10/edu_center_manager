import 'package:edu_center_manager/features/attendance/data/repo/attendance_repo.dart';
import 'package:edu_center_manager/features/attendance/data/repo/attendance_repo_impl.dart';
import 'package:edu_center_manager/features/attendance/data/service/attendance_service.dart';
import 'package:edu_center_manager/features/attendance/presentation/view_model/attendance_cubit.dart';
import 'package:edu_center_manager/features/groups/data/repo/groups_repo.dart';
import 'package:get_it/get_it.dart';

void attendanceGetIt(GetIt getIt) {
  getIt.registerLazySingleton<AttendanceService>(() => AttendanceService());

  getIt.registerLazySingleton<AttendanceRepo>(
    () => AttendanceRepoImpl(dataSource: getIt<AttendanceService>()),
  );
  getIt.registerFactory<AttendanceCubit>(
    () => AttendanceCubit(getIt<AttendanceRepo>(), getIt<GroupsRepo>()),
  );
}
