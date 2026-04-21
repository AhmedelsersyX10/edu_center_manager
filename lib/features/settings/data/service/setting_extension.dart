import 'package:flutter/material.dart';

extension ThemeModeToString on ThemeMode {
  String toStringValue() {
    switch (this) {
      case ThemeMode.dark:
        return 'dark';
      case ThemeMode.light:
        return 'light';
      case ThemeMode.system:
        return 'system';
    }
  }
}

extension LangExtension on String? {
  Locale toLocale() {
    switch (this) {
      case 'ar':
        return const Locale('ar');
      case 'en':
        return const Locale('en');
      default:
        return const Locale('ar');
    }
  }
}

extension LangToString on Locale {
  String toStringValue() {
    return languageCode;
  }
}

extension ThemeModeExtension on String {
  ThemeMode toThemeMode() {
    switch (this) {
      case 'dark':
        return ThemeMode.dark;
      case 'light':
        return ThemeMode.light;
      case 'system':
        return ThemeMode.system;
      default:
        return ThemeMode.system;
    }
  }
}
