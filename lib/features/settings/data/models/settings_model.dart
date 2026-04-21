import 'package:flutter/material.dart';

class SettingsModel {
  final ThemeMode themeMode;
  final Locale languageCode;

  SettingsModel({required this.themeMode, required this.languageCode});

  SettingsModel copyWith({ThemeMode? themeMode, Locale? languageCode}) {
    return SettingsModel(
      themeMode: themeMode ?? this.themeMode,
      languageCode: languageCode ?? this.languageCode,
    );
  }
}
