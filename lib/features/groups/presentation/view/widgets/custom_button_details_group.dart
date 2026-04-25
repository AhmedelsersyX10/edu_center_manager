import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class CustomActionsButtonsGroup extends StatelessWidget {
  const CustomActionsButtonsGroup({
    super.key,
    required this.onStudents,
    required this.onEdit,
    required this.onDelete,
  });

  final VoidCallback onStudents;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12),
      child: Column(
        children: [
          SizedBox(
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
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: OutlinedButton.icon(
                  onPressed: onEdit,
                  icon: const Icon(Icons.edit_rounded, size: 16),
                  label: Text(
                    'edit'.tr(),
                    style: const TextStyle(fontFamily: 'cairo', fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: OutlinedButton.icon(
                  onPressed: onDelete,
                  icon: const Icon(Icons.delete_outline_rounded, size: 16),
                  label: Text(
                    'delete'.tr(),
                    style: const TextStyle(fontFamily: 'cairo', fontWeight: FontWeight.bold),
                  ),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: Colors.redAccent,
                    side: const BorderSide(color: Colors.redAccent, width: 1.5),
                    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
