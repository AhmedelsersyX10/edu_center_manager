part of 'settings_cubit.dart';

@immutable
sealed class SettingsState {}

final class SettingsInitial extends SettingsState {}
final class SettingsLoaded extends SettingsState {
  final SettingsModel settingsModel;

  SettingsLoaded({required this.settingsModel});
}

