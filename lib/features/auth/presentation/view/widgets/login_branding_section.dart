import 'package:edu_center_manager/core/utils/app_images.dart';
import 'package:edu_center_manager/core/utils/app_style.dart';
import 'package:edu_center_manager/features/auth/presentation/view/widgets/login_background_painter.dart';
import 'package:flutter/material.dart';

/// القسم الأزرق المشترك (اللوجو + النصوص + الخلفية) يُستخدم في Tablet و Desktop و Mobile
class LoginBrandingSection extends StatelessWidget {
  const LoginBrandingSection({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: double.infinity,
      width: double.infinity,
      child: CustomPaint(
        painter: LoginBackgroundPainter(),
        child: Column(
          mainAxisAlignment:
              MediaQuery.sizeOf(context).width < 1200 && MediaQuery.sizeOf(context).width > 800
              ? MainAxisAlignment.center
              : MainAxisAlignment.start,
          children: [
            Image.asset(Assets.logo, height: 140),
            const SizedBox(height: 24),
            Text(
              'Login to your Account',
              textAlign: TextAlign.center,
              style: AppStyles.styleBold24(context).copyWith(fontSize: 32),
            ),
            const SizedBox(height: 8),
            Text(
              'Enter your email and password to log in',
              style: AppStyles.styleRegular14(context),
            ),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }
}
