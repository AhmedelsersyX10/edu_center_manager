import 'package:edu_center_manager/features/settings/data/models/settings_model.dart';
import 'package:edu_center_manager/features/settings/data/repo/settings_repo.dart';
import 'package:edu_center_manager/features/settings/data/service/settings_service.dart';

class SettingsRepoImpl implements SettingsRepo {
  final SettingsService settingsService;

  SettingsRepoImpl({required this.settingsService});
  @override
  Future<SettingsModel> getSettings() async {
    try {
      return settingsService.getSettings();
    } catch (e) {
      throw Exception('');
    }
  }

  @override
  Future<void> saveSettings(SettingsModel settings) async {
    try {
      return settingsService.saveSettings(settings);
    } catch (e) {
      throw Exception('');
    }
  }
}
