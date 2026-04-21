import 'package:edu_center_manager/core/utils/app_style.dart';
import 'package:flutter/material.dart';

class CustomInfoRowCard extends StatelessWidget {
  final IconData icon;
  final String text;
  final BuildContext context;
  const CustomInfoRowCard({
    super.key,
    required this.icon,
    required this.text,
    required this.context,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, size: 16,),
        const SizedBox(width: 8),
        Expanded(child: Text(text, style: AppStyles.styleRegular16(context))),
      ],
    );
  }
}
