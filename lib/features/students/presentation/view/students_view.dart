import 'package:edu_center_manager/core/services/service_locator.dart';
import 'package:edu_center_manager/core/utils/size_config.dart';
import 'package:edu_center_manager/core/widgets/adaptive_layout.dart';
import 'package:edu_center_manager/features/students/presentation/view/widgets/students_view_body_desktop.dart';
import 'package:edu_center_manager/features/students/presentation/view/widgets/students_view_body_mobile.dart';
import 'package:edu_center_manager/features/students/presentation/view_model/students_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class StudentsView extends StatelessWidget {
  const StudentsView({super.key});

  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);

    return BlocProvider(
      create: (context) => getIt<StudentsCubit>()..getStudents(),
      child: Scaffold(
        body: AdaptiveLayout(
          mobileLayout: (context) => const StudentsViewBodyMobile(),
          desktopLayout: (context) => const StudentsViewBodyDesktop(),
        ),
      ),
    );
  }
}
