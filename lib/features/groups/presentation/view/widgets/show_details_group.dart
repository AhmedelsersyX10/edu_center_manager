import 'package:edu_center_manager/core/utils/size_config.dart';
import 'package:flutter/material.dart';

Future<void> showDetailsGroup(
  BuildContext context, {
  required Widget child,
  double maxWidth = 700,
  double maxHeight = 700,
  bool isScrollControlled = true,
}) {
  final isMobile = MediaQuery.sizeOf(context).width < SizeConfig.desktop;

  if (isMobile) {
    return showModalBottomSheet(
      context: context,
      isScrollControlled: isScrollControlled,
      builder: (context) => child,
    );
  } else {
    return showDialog(
      context: context,
      barrierDismissible: true,
      builder: (context) => Center(
        child: ConstrainedBox(
          constraints: BoxConstraints(maxWidth: maxWidth, maxHeight: maxHeight),
          child: Material(child: child),
        ),
      ),
    );
  }
}
