import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class CustomButtonDetailsGroup extends StatelessWidget {
  const CustomButtonDetailsGroup({super.key, required this.onStudents});

  final VoidCallback onStudents;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12),
      child: SizedBox(
        width: double.infinity,
        child: ElevatedButton.icon(
          onPressed: onStudents,
          icon: const Icon(Icons.person_add_alt_1_rounded, size: 18),
          label: Text(
            'groups_view.card.details_group'.tr(),
            style: const TextStyle(fontFamily: 'cairo', fontWeight: FontWeight.w800),
          ),
          style: ElevatedButton.styleFrom(
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(vertical: 12),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            elevation: 0,
          ),
        ),
      ),
    );
  }
}
