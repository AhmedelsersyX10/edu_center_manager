import 'package:edu_center_manager/features/auth/presentation/view/login_view.dart';
import 'package:edu_center_manager/features/dashboard/presentation/view/dashboard_view.dart';
import 'package:edu_center_manager/features/home/presentation/view/widgets/home_view.dart';
import 'package:edu_center_manager/features/splash/presentation/view/splash_view.dart';
import 'package:go_router/go_router.dart';

abstract class AppRouter {
  static const kLoginView = '/loginView';
  static const kDashboardView = '/dashboardView';
  static const kHomeView = '/homeView';
  static final GoRouter router = GoRouter(
    routes: <RouteBase>[
      GoRoute(
        path: '/',
        builder: (context, state) {
          return const SplashView();
        },
      ),
      GoRoute(
        path: kLoginView,
        builder: (context, state) {
          return const LoginView();
        },
      ),
      GoRoute(
        path: kDashboardView,
        builder: (context, state) {
          return const DashboardView();
        },
      ),
      GoRoute(
        path: kHomeView,
        builder: (context, state) {
          return const HomeView();
        },
      ),
    ],
  );
}
