import 'package:edu_center_manager/core/utils/app_images.dart';
import 'package:edu_center_manager/core/utils/app_style.dart';
import 'package:edu_center_manager/features/auth/presentation/view/widgets/login_background_painter.dart';
import 'package:edu_center_manager/features/auth/presentation/view/widgets/login_form_card.dart';
import 'package:flutter/material.dart';

class LoginViewBodyDesktop extends StatelessWidget {
  const LoginViewBodyDesktop({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          // الجانب الأيسر الأبيض الفارغ (Desktop فقط)
          Expanded(flex: 1, child: Container()),
          // القسم الأزرق المركزي مع الفورم بداخله
          Expanded(
            flex: 2,
            child: Stack(
              children: [
                SizedBox(
                  height: double.infinity,
                  width: double.infinity,
                  child: CustomPaint(painter: LoginBackgroundPainter()),
                ),
                SingleChildScrollView(
                  child: Column(
                    children: [
                      SizedBox(height: MediaQuery.sizeOf(context).height * 0.1),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const SizedBox(height: 8),
                          Image.asset(Assets.logo, height: 140),
                          const SizedBox(height: 24),
                          Text(
                            'Login to your Account',
                            textAlign: TextAlign.center,
                            style: AppStyles.styleBold24(context),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'Enter your email and password to log in',
                            style: AppStyles.styleRegular14(context),
                          ),
                        ],
                      ),
                      const SizedBox(height: 48),
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 48),
                        child: LoginFormCard(
                          padding: EdgeInsets.all(24),
                          maxWidth: double.infinity,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          // الجانب الأيمن الأبيض الفارغ (Desktop فقط)
          Expanded(flex: 1, child: Container()),
        ],
      ),
    );
  }
}
