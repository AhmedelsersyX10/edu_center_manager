import 'package:device_preview/device_preview.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:edu_center_manager/core/services/app_initializer.dart';
import 'package:edu_center_manager/core/services/route_resolver.dart';
import 'package:edu_center_manager/core/utils/app_router.dart';
import 'package:edu_center_manager/core/utils/app_themes.dart';
import 'package:flutter/material.dart';
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
  runApp(
    DevicePreview(
      enabled: false,
      builder: (context) => EasyLocalization(
        supportedLocales: const [Locale("ar"), Locale('en')],
        fallbackLocale: Locale('ar'),
        startLocale: Locale('ar'),
        path: 'assets/translations',
        child: EduCenterManager(router: router),
      ),
    ),
  );
}

class EduCenterManager extends StatelessWidget {
  final GoRouter router;
  const EduCenterManager({super.key, required this.router});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'appTitle'.tr(),
      debugShowCheckedModeBanner: false,
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
      routerConfig: router,
      theme: lightTheme,
      // darkTheme: darkTheme,
    );
  }
}
