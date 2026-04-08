import 'package:edu_center_manager/core/utils/size_config.dart';
import 'package:edu_center_manager/features/dashboard/presentation/widgets/adaptive_layout.dart';
import 'package:edu_center_manager/features/dashboard/presentation/widgets/custom_drawer.dart';
import 'package:edu_center_manager/features/dashboard/presentation/widgets/dashboard_desktop_layout.dart';
import 'package:edu_center_manager/features/dashboard/presentation/widgets/dashboard_layout_mobile.dart';
import 'package:edu_center_manager/features/dashboard/presentation/widgets/dashboard_tablet_layout.dart';
import 'package:flutter/material.dart';

class DashboardView extends StatelessWidget {
  const DashboardView({super.key});

  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);
    return SafeArea(
      child: Scaffold(
        appBar: MediaQuery.of(context).size.width < SizeConfig.tablet
            ? AppBar(
                backgroundColor: const Color(0xfffafafa),
                elevation: 0,
                foregroundColor: Colors.black,
              )
            : null,
        drawer: MediaQuery.of(context).size.width < SizeConfig.tablet ? const CustomDrawer() : null,
        backgroundColor: const Color(0xffE5E5E5),
        body: AdaptiveLayout(
          mobileLayout: (context) => const DashboardLayoutMobile(),
          tabletLayout: (context) => const DashboardTabletLayout(),
          desktopLayout: (context) => const DashboardDesktopLayout(),
        ),
      ),
    );
  }
}
