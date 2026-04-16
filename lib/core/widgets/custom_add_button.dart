import 'package:edu_center_manager/core/utils/app_style.dart';
import 'package:flutter/material.dart';

class CustomAddButton extends StatelessWidget {
  const CustomAddButton({super.key, required this.onAdd, required this.text});

  final VoidCallback onAdd;
  final String text;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onAdd,
      style: ElevatedButton.styleFrom(
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Theme.of(context).colorScheme.onPrimary,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            text,
            style: AppStyles.styleBold18(
              context,
            ).copyWith(color: Theme.of(context).colorScheme.onPrimary),
          ),
          const SizedBox(width: 8),
          Icon(Icons.add_circle_outline_sharp, color: Theme.of(context).colorScheme.onPrimary),
        ],
      ),
    );
  }
}
