import 'package:edu_center_manager/core/services/service_locator.dart';
import 'package:edu_center_manager/core/widgets/adaptive_layout.dart';
import 'package:edu_center_manager/features/groups/presentation/view/widgets/groups_view_body_desktop.dart';
import 'package:edu_center_manager/features/groups/presentation/view/widgets/groups_view_body_mobile.dart';
import 'package:edu_center_manager/features/groups/presentation/view_model/groups_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class GroupsView extends StatelessWidget {
  const GroupsView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<GroupsCubit>()..getGroups(),
      child: Scaffold(
        body: AdaptiveLayout(
          mobileLayout: (context) => const GroupsViewBodyMobile(),
          desktopLayout: (context) => const GroupsViewBodyDesktop(),
        ),
      ),
    );
  }
}
