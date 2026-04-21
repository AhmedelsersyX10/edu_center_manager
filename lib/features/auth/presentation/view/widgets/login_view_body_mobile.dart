import 'package:easy_localization/easy_localization.dart';
import 'package:edu_center_manager/core/utils/app_images.dart';
import 'package:edu_center_manager/core/utils/app_style.dart';
import 'package:edu_center_manager/features/auth/presentation/view/widgets/login_form_card.dart';
import 'package:flutter/material.dart';

class LoginViewBodyMobile extends StatelessWidget {
  const LoginViewBodyMobile({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: MediaQuery.sizeOf(context).height * 0.1),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(Assets.logo, height: 150),
                  const SizedBox(height: 8),
                  Text(
                    'appTitle'.tr(),
                    textAlign: TextAlign.center,
                    style: AppStyles.styleBold24(context).copyWith(fontSize: 32),
                  ),
                  const SizedBox(height: 8),
                  Text('welcomeToEduCenterManager'.tr(), style: AppStyles.styleRegular16(context)),
                ],
              ),
              const SizedBox(height: 48),
              const LoginFormCard(padding: EdgeInsets.all(24), maxWidth: double.infinity),
            ],
          ),
        ),
      ],
    );
  }
}
