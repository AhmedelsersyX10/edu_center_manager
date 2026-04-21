import 'package:easy_localization/easy_localization.dart';
import 'package:edu_center_manager/features/settings/data/models/settings_model.dart';
import 'package:edu_center_manager/features/settings/presentation/view_model/settings_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LanguageCard extends StatelessWidget {
  const LanguageCard({super.key, required this.settings});

  final SettingsModel settings;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: SegmentedButton<Locale>(
                segments: const [
                  ButtonSegment<Locale>(value: Locale('ar'), label: Text('العربية')),
                  ButtonSegment<Locale>(value: Locale('en'), label: Text('English')),
                ],
                selected: {settings.languageCode},
                onSelectionChanged: (Set<Locale> newSelection) async {
                  final newLocale = newSelection.first;
                  await context.setLocale(newLocale);
                  if (context.mounted) {
                    context.read<SettingsCubit>().saveSettings(
                      settings.copyWith(languageCode: newLocale),
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
