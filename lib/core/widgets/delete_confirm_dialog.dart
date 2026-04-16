import 'package:edu_center_manager/core/utils/app_style.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

class DeleteConfirmDialog extends StatelessWidget {
  final VoidCallback onConfirm;

  const DeleteConfirmDialog({super.key, required this.onConfirm});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      title: Row(
        children: [
          Icon(Icons.warning_amber_rounded, color: Colors.redAccent, size: 28),
          const SizedBox(width: 12),
          Text('confirmDelete'.tr(), style: AppStyles.styleBold18(context)),
        ],
      ),
      content: Text('deleteStudentConfirmMsg'.tr(), style: AppStyles.styleRegular16(context)),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(false),
          child: Text(
            'cancel'.tr(),
            style: AppStyles.styleBold16(
              context,
            ).copyWith(color: Theme.of(context).colorScheme.primary),
          ),
        ),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.redAccent,
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          ),
          onPressed: () {
            onConfirm();
            Navigator.of(context).pop(true);
          },
          child: Text(
            'delete'.tr(),
            style: AppStyles.styleBold16(context).copyWith(color: Colors.white),
          ),
        ),
      ],
    );
  }
}
