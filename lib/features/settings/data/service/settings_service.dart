import 'package:edu_center_manager/features/settings/data/models/settings_model.dart';
import 'package:edu_center_manager/features/settings/data/service/setting_extension.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsService {
  SettingsService(this.sharedPreferences);
  final SharedPreferences sharedPreferences;

  final String theme = 'theme_mode';
  final String lang = 'language';

  Future<SettingsModel> getSettings() async {
    final themeMode = sharedPreferences.getString(theme)?.toThemeMode();
    final languageCode = sharedPreferences.getString(lang)?.toLocale();
    
    return SettingsModel(
      themeMode: themeMode ?? ThemeMode.system,
      languageCode: languageCode ?? const Locale('ar'),
    );
  }

  Future<void> saveSettings(SettingsModel settings) async {
    final themeMode = settings.themeMode.toStringValue();
    final language = settings.languageCode.toStringValue();

    await sharedPreferences.setString(theme, themeMode);
    await sharedPreferences.setString(lang, language);
  }
}
