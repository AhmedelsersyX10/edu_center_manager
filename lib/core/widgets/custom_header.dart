import 'package:edu_center_manager/core/utils/app_style.dart';
import 'package:flutter/material.dart';

class CustomHeader extends StatelessWidget {
  const CustomHeader({
    super.key,
    required this.title,
    required this.description,
    required this.icon,
  });
  final String title;
  final String description;
  final IconData icon;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon, color: Theme.of(context).textTheme.titleMedium?.color, size: 40),
      title: Text(title, style: AppStyles.styleBold28(context)),
      subtitle: Text(description, style: AppStyles.styleRegular18(context)),
    );
  }
}
