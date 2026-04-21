import 'package:edu_center_manager/features/settings/data/models/settings_model.dart';

abstract class SettingsRepo {
  Future<SettingsModel> getSettings();
  Future<void> saveSettings(SettingsModel settings);
}
