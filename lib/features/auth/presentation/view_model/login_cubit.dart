import 'package:edu_center_manager/core/utils/app_router.dart';
import 'package:edu_center_manager/features/auth/data/services/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitial()) {
    _checkLoggedIn(); // التحقق عند الإنشاء
  }

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool isObscure = true;

  /// تبديل عرض/إخفاء كلمة المرور
  void toggleObscure() {
    isObscure = !isObscure;
    emit(LoginObscureToggled(isObscure));
  }

  /// التحقق التلقائي من تسجيل الدخول
  Future<void> _checkLoggedIn() async {
    final prefs = await SharedPreferences.getInstance();
    final isLoggedIn = prefs.getBool('isLoggedIn') ?? false;
    final role = prefs.getString('role');

    if (isLoggedIn && role != null) {
      emit(LoginSuccess(role));
    }
  }

  /// تسجيل الدخول
  Future<void> login(BuildContext context) async {
    emit(LoginLoading());
    try {
      final data = await loginAndGetRole(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );

      final role = data['role'];

      // حفظ بيانات المستخدم في SharedPreferences
      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool('isLoggedIn', true);
      await prefs.setString('role', role);
      await prefs.setString('email', emailController.text.trim());

      emit(LoginSuccess(role));

      // الانتقال للشاشة المناسبة باستخدام AppRouter
      AppRouter.navigateToRole(context, role);
    } catch (e) {
      emit(LoginFailure(e.toString()));
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Login Failed')));
      }
      debugPrint('Login error: $e');
    }
  }

  /// تسجيل الخروج
  Future<void> logout(BuildContext context) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear(); // إزالة كل البيانات
    emit(LoginInitial());

    // الانتقال لشاشة تسجيل الدخول
    AppRouter.logout(context);
  }

  @override
  Future<void> close() {
    emailController.dispose();
    passwordController.dispose();
    return super.close();
  }
}
