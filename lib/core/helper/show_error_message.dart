import 'package:edu_center_manager/core/utils/app_style.dart';
import 'package:flutter/material.dart';

extension ContextExt on BuildContext {
  void showErrorMessage(String message) {
    ScaffoldMessenger.of(this).showSnackBar(
      SnackBar(
        content: Text(message, style: AppStyles.styleBold18(this)),
      ),
    );
  }
}
