import 'package:device_preview/device_preview.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:edu_center_manager/core/services/app_initializer.dart';
import 'package:edu_center_manager/core/services/route_resolver.dart';
import 'package:edu_center_manager/core/services/service_locator.dart';
import 'package:edu_center_manager/core/utils/app_router.dart';
import 'package:edu_center_manager/core/utils/app_themes.dart';
import 'package:edu_center_manager/features/settings/presentation/view_model/settings_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  String initialRoute;
  try {
    await AppInitializer().initialize();
    initialRoute = await RouteResolver().resolve();
  } catch (e) {
    debugPrint('Startup error: $e');
    initialRoute = AppRouter.kLoginView;
  }

  final router = AppRouter.getRouter(initialRoute: initialRoute);
  final settingsCubit = getIt<SettingsCubit>();
  runApp(
    DevicePreview(
      enabled: false,
      builder: (context) => EasyLocalization(
        supportedLocales: const [Locale("ar"), Locale('en')],
        fallbackLocale: const Locale('ar'),
        startLocale: const Locale('ar'),
        path: 'assets/translations',
        child: EduCenterManager(router: router, settingsCubit: settingsCubit),
      ),
    ),
  );
}

class EduCenterManager extends StatelessWidget {
  final GoRouter router;
  final SettingsCubit settingsCubit;
  const EduCenterManager({super.key, required this.router, required this.settingsCubit});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => settingsCubit..getSettings(),
      child: BlocBuilder<SettingsCubit, SettingsState>(
        builder: (context, state) {
          final themeMode = state is SettingsLoaded
              ? state.settingsModel.themeMode
              : ThemeMode.system;
          final languageCode = state is SettingsLoaded
              ? state.settingsModel.languageCode
              : const Locale('ar');
          return MaterialApp.router(
            title: 'appTitle'.tr(),
            debugShowCheckedModeBanner: false,
            localizationsDelegates: context.localizationDelegates,
            supportedLocales: context.supportedLocales,
            routerConfig: router,
            locale: languageCode,
            theme: lightTheme,
            darkTheme: darkTheme,
            themeMode: themeMode,
          );
        },
      ),
    );
  }
}
