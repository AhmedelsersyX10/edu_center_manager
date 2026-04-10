import 'package:easy_localization/easy_localization.dart';
import 'package:edu_center_manager/core/utils/app_style.dart';
import 'package:edu_center_manager/features/auth/presentation/view_model/login_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// فورم تسجيل الدخول المشترك (Email + Password + Login Button)
/// يُستخدم في Mobile و Tablet و Desktop
class LoginFormCard extends StatelessWidget {
  const LoginFormCard({
    super.key,
    this.maxWidth = 450,
    this.padding = const EdgeInsets.all(40),
    this.showShadow = true,
  });

  final double maxWidth;
  final EdgeInsetsGeometry padding;
  final bool showShadow;

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<LoginCubit>();

    return Container(
      constraints: BoxConstraints(maxWidth: maxWidth),
      margin: const EdgeInsets.symmetric(horizontal: 24),
      padding: padding,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: showShadow
            ? [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 20,
                  offset: const Offset(0, 10),
                ),
              ]
            : null,
      ),
      child: BlocBuilder<LoginCubit, LoginState>(
        builder: (context, state) {
          final isLoading = state is LoginLoading;
          final isObscure = cubit.isObscure;

          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'enterYourEmailAndPasswordToLogIn'.tr(),

                style: AppStyles.styleRegular16(context).copyWith(color: Colors.grey),
              ),
              const SizedBox(height: 32),
              // Email Field
              _LoginTextField(
                controller: cubit.emailController,
                label: 'email'.tr(),
                prefixIcon: Icons.email_outlined,
              ),
              const SizedBox(height: 20),
              // Password Field
              _LoginTextField(
                controller: cubit.passwordController,
                label: 'password'.tr(),
                prefixIcon: Icons.lock_outline,
                obscureText: isObscure,
                suffixIcon: IconButton(
                  icon: Icon(
                    isObscure ? Icons.visibility_off_outlined : Icons.visibility_outlined,
                    color: Colors.grey,
                  ),
                  onPressed: () => cubit.toggleObscure(),
                ),
              ),
              const SizedBox(height: 32),
              // Login Button
              ElevatedButton(
                onPressed: isLoading ? null : () => cubit.login(context),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF2F69F8),
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  elevation: 0,
                ),
                child: isLoading
                    ? const SizedBox(
                        height: 24,
                        width: 24,
                        child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2),
                      )
                    : Text(
                        'logIn'.tr(),
                        style: AppStyles.styleBold18(context).copyWith(color: Colors.white),
                      ),
              ),
            ],
          );
        },
      ),
    );
  }
}

class _LoginTextField extends StatelessWidget {
  const _LoginTextField({
    required this.controller,
    required this.label,
    required this.prefixIcon,
    this.obscureText = false,
    this.suffixIcon,
  });

  final TextEditingController controller;
  final String label;
  final IconData prefixIcon;
  final bool obscureText;
  final Widget? suffixIcon;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      obscureText: obscureText,
      decoration: InputDecoration(
        label: Text(label),
        labelStyle: TextStyle(color: Colors.grey.shade400),
        filled: true,
        fillColor: Colors.grey.shade50,
        prefixIcon: Icon(prefixIcon, color: Colors.grey),
        suffixIcon: suffixIcon,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.grey.shade200),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.grey.shade200),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Color(0xFF2F69F8)),
        ),
      ),
    );
  }
}
