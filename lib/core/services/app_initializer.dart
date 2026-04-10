import 'package:easy_localization/easy_localization.dart';
import 'package:edu_center_manager/core/utils/app_router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AppInitializer {
  static Future<String> getInitialRoute() async {
    try {
      WidgetsFlutterBinding.ensureInitialized();
      await dotenv.load(fileName: ".env");

      await EasyLocalization.ensureInitialized();

      await Supabase.initialize(
        url: dotenv.env['SUPABASE_URL']!,
        anonKey: dotenv.env['SUPABASE_ANON_KEY']!,
      );

      final prefs = await SharedPreferences.getInstance();
      final isLoggedIn = prefs.getBool('isLoggedIn') ?? false;
      final role = prefs.getString('role');

      return _resolveRoute(isLoggedIn, role);
    } catch (_) {
      // Log error if needed
      return AppRouter.kLoginView; // Fallback
    }
  }

  static String _resolveRoute(bool isLoggedIn, String? role) {
    if (!isLoggedIn) return AppRouter.kLoginView;
    return switch (role) {
      'admin' => AppRouter.kDashboardView,
      'teacher' => AppRouter.kDashboardView,
      _ => AppRouter.kLoginView,
    };
  }
}
