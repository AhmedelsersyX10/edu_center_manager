import 'package:edu_center_manager/features/groups/data/repo/groups_repo.dart';
import 'package:edu_center_manager/features/groups/data/repo/groups_repo_impl.dart';
import 'package:edu_center_manager/features/groups/data/service/groups_service.dart';
import 'package:edu_center_manager/features/groups/presentation/view_model/groups_cubit.dart';
import 'package:edu_center_manager/features/teachers/data/repo/teacher_repo.dart';
import 'package:get_it/get_it.dart';

void groupGetIt(GetIt getIt) {
  getIt.registerLazySingleton<GroupsService>(() => GroupsService());

  getIt.registerLazySingleton<GroupsRepo>(
    () => GroupsRepoImpl(groupsService: getIt<GroupsService>()),
  );
  getIt.registerFactory<GroupsCubit>(() => GroupsCubit(getIt<GroupsRepo>(), getIt<TeacherRepo>()));
}
