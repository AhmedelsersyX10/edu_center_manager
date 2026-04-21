import 'package:edu_center_manager/core/utils/app_style.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

class DeleteConfirmDialog extends StatelessWidget {
  final VoidCallback onConfirm;
  final String title;
  final String content;

  const DeleteConfirmDialog({
    super.key,
    required this.onConfirm,
    required this.title,
    required this.content,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      title: Row(
        children: [
          const Icon(Icons.warning_amber_rounded, size: 28),
          const SizedBox(width: 12),
          Text(title, style: AppStyles.styleBold18(context)),
        ],
      ),
      content: Text(content, style: AppStyles.styleRegular16(context)),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(false),
          child: Text('cancel'.tr(), style: AppStyles.styleBold16(context).copyWith()),
        ),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          ),
          onPressed: () {
            onConfirm();
            Navigator.of(context).pop(true);
          },
          child: Text('delete'.tr(), style: AppStyles.styleBold16(context)),
        ),
      ],
    );
  }
}
