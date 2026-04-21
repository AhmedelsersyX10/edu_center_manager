import 'package:edu_center_manager/features/settings/data/repo/settings_repo.dart';
import 'package:edu_center_manager/features/settings/data/repo/settings_repo_impl.dart';
import 'package:edu_center_manager/features/settings/data/service/settings_service.dart';
import 'package:edu_center_manager/features/settings/presentation/view_model/settings_cubit.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

void settingsGetIt(GetIt getIt) {
  getIt.registerLazySingleton<SettingsService>(() => SettingsService(getIt<SharedPreferences>()));

  getIt.registerLazySingleton<SettingsRepo>(
    () => SettingsRepoImpl(settingsService: getIt<SettingsService>()),
  );

  getIt.registerLazySingleton<SettingsCubit>(
    () => SettingsCubit(settingsRepo: getIt<SettingsRepo>()),
  );
}
