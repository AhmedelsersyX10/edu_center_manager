import 'package:edu_center_manager/core/utils/app_style.dart';
import 'package:flutter/material.dart';

class SectionHeader extends StatelessWidget {
  const SectionHeader({super.key, required this.title, required this.icon});
  final String title;
  final IconData icon;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, size: 24),
        const SizedBox(width: 12),
        Text(title, style: AppStyles.styleBold24(context)),
      ],
    );
  }
}
