import 'package:bloc/bloc.dart';
import 'package:edu_center_manager/features/settings/data/models/settings_model.dart';
import 'package:edu_center_manager/features/settings/data/repo/settings_repo.dart';
import 'package:meta/meta.dart';

part 'settings_state.dart';

class SettingsCubit extends Cubit<SettingsState> {
  SettingsCubit({required this.settingsRepo}) : super(SettingsInitial());
  final SettingsRepo settingsRepo;

  Future<void> getSettings() async {
    final settings = await settingsRepo.getSettings();
    emit(SettingsLoaded(settingsModel: settings));
  }

  Future<void> saveSettings(SettingsModel settings) async {
    await settingsRepo.saveSettings(settings);
    emit(SettingsLoaded(settingsModel: settings));
  }
}
