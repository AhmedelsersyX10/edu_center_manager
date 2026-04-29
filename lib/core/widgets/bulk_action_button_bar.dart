import 'package:edu_center_manager/core/utils/app_themes.dart';
import 'package:flutter/material.dart';

class BulkActionButtonBar extends StatelessWidget {
  const BulkActionButtonBar({
    super.key,
    required this.isLoading,
    required this.onPressed,
    required this.label,
    required this.icon,
    this.visible = true,
    this.padding = const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
    this.buttonPadding = const EdgeInsets.symmetric(vertical: 16),
    this.elevation = 4,
  });

  final bool isLoading;
  final VoidCallback onPressed;
  final Widget label;
  final IconData icon;
  final bool visible;
  final EdgeInsetsGeometry padding;
  final EdgeInsetsGeometry buttonPadding;
  final double elevation;

  @override
  Widget build(BuildContext context) {
    if (!visible) return const SizedBox.shrink();

    return Container(
      decoration: BoxDecoration(
        color: context.colors.pageBackground,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: context.colors.border, width: 1.5),
      ),
      padding: padding,
      child: ElevatedButton(
        onPressed: isLoading ? null : onPressed,
        style: ElevatedButton.styleFrom(
          padding: buttonPadding,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          elevation: elevation,
        ),
        child: isLoading
            ? const SizedBox(
                height: 24,
                width: 24,
                child: CircularProgressIndicator(strokeWidth: 2.5, color: Colors.white),
              )
            : Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(icon, size: 20),
                  const SizedBox(width: 10),
                  label,
                ],
              ),
      ),
    );
  }
}
