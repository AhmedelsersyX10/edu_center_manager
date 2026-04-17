import 'package:edu_center_manager/core/utils/app_router.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class RouteResolver {
  Future<String> resolve() async {
    final session = Supabase.instance.client.auth.currentSession;
    if (session == null) return AppRouter.kLoginView;

    final response = await Supabase.instance.client
        .from('profiles')
        .select('role')
        .eq('id', session.user.id)
        .single();

    final role = response['role'] as String?;
    return _resolveRoute(role);
  }

  String _resolveRoute(String? role) {
    return switch (role) {
      'admin' || 'teacher' => AppRouter.kDashboardView,
      _ => AppRouter.kLoginView,
    };
  }
}
