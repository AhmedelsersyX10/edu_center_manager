import 'package:easy_localization/easy_localization.dart';
import 'package:edu_center_manager/core/services/service_locator.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AppInitializer {
  Future<void> initialize() async {
    await dotenv.load(fileName: ".env");
    await EasyLocalization.ensureInitialized();
    await Supabase.initialize(
      url: dotenv.env['SUPABASE_URL']!,
      anonKey: dotenv.env['SUPABASE_ANON_KEY']!,
    );
    final sharedPreferences = await SharedPreferences.getInstance();
    getIt.registerSingleton<SharedPreferences>(sharedPreferences);
    setupServiceLocator();
  }
}
