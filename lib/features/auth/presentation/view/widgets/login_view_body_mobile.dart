import 'package:easy_localization/easy_localization.dart';
import 'package:edu_center_manager/core/utils/app_images.dart';
import 'package:edu_center_manager/core/utils/app_style.dart';
import 'package:edu_center_manager/features/auth/presentation/view/widgets/login_background_painter.dart';
import 'package:edu_center_manager/features/auth/presentation/view/widgets/login_form_card.dart';
import 'package:flutter/material.dart';

class LoginViewBodyMobile extends StatelessWidget {
  const LoginViewBodyMobile({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: double.infinity,
          width: double.infinity,
          color: const Color(0xFF2F69F8),
          child: CustomPaint(painter: LoginBackgroundPainter()),
        ),
        SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: MediaQuery.sizeOf(context).height * 0.1),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(Assets.logo, height: 150, color: Colors.white),
                  const SizedBox(height: 8),
                  Text(
                    'appTitle'.tr(),
                    textAlign: TextAlign.center,
                    style: AppStyles.styleBold24(
                      context,
                    ).copyWith(color: Colors.white, fontSize: 32),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'welcomeToEduCenterManager'.tr(),

                    style: AppStyles.styleRegular16(
                      context,
                    ).copyWith(color: Colors.white.withOpacity(.9)),
                  ),
                ],
              ),
              SizedBox(height: 48),
              const LoginFormCard(padding: EdgeInsets.all(24), maxWidth: double.infinity),
            ],
          ),
        ),
      ],
    );
  }
}
