import 'package:edu_center_manager/core/services/service_locator.dart';
import 'package:edu_center_manager/core/widgets/adaptive_layout.dart';
import 'package:edu_center_manager/features/attendance/presentation/view/widgets/attendance_view_body_desktop.dart';
import 'package:edu_center_manager/features/attendance/presentation/view/widgets/attendance_view_body_mobil.dart';
import 'package:edu_center_manager/features/attendance/presentation/view_model/attendance_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AttendanceView extends StatelessWidget {
  const AttendanceView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<AttendanceCubit>()..initialize(),
      child: Scaffold(
        body: AdaptiveLayout(
          mobileLayout: (context) => const AttendanceViewBodyMobile(),
          desktopLayout: (context) => const AttendanceViewBodyDesktop(),
        ),
      ),
    );
  }
}
