import 'package:easy_localization/easy_localization.dart';
import 'package:edu_center_manager/features/settings/data/models/settings_model.dart';
import 'package:edu_center_manager/features/settings/presentation/view_model/settings_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ThemeCard extends StatelessWidget {
  const ThemeCard({super.key, required this.settings});

  final SettingsModel settings;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: SegmentedButton<ThemeMode>(
                segments: [
                  ButtonSegment<ThemeMode>(
                    value: ThemeMode.light,
                    icon: const Icon(Icons.light_mode),
                    label: Text('light'.tr()),
                  ),
                  ButtonSegment<ThemeMode>(
                    value: ThemeMode.dark,
                    icon: const Icon(Icons.dark_mode),
                    label: Text('dark'.tr()),
                  ),
                  ButtonSegment<ThemeMode>(
                    value: ThemeMode.system,
                    icon: const Icon(Icons.settings_system_daydream),
                    label: Text('system'.tr()),
                  ),
                ],
                selected: {settings.themeMode},
                onSelectionChanged: (Set<ThemeMode> newSelection) {
                  context.read<SettingsCubit>().saveSettings(
                    settings.copyWith(themeMode: newSelection.first),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
