import 'package:edu_center_manager/core/utils/app_themes.dart';
import 'package:flutter/material.dart';

class SectionCard extends StatelessWidget {
  const SectionCard({super.key, required this.child, this.padding, this.backgroundColor});

  final Widget child;
  final EdgeInsetsGeometry? padding;
  final Color? backgroundColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding,
      decoration: BoxDecoration(
        color: backgroundColor ?? context.colors.pageBackground,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: context.colors.border, width: 1.5),
      ),
      child: child,
    );
  }
}
