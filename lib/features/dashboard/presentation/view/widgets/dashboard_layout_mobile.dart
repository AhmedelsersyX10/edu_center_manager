import 'package:easy_localization/easy_localization.dart';
import 'package:edu_center_manager/core/widgets/drawer_page.dart';
import 'package:edu_center_manager/features/dashboard/presentation/view/widgets/root_view.dart';
import 'package:edu_center_manager/core/widgets/custom_drawer.dart';
import 'package:flutter/material.dart';

class DashboardLayoutMobile extends StatefulWidget {
  const DashboardLayoutMobile({super.key});

  @override
  State<DashboardLayoutMobile> createState() => _DashboardLayoutMobileState();
}

class _DashboardLayoutMobileState extends State<DashboardLayoutMobile> {
  final GlobalKey<RootViewState> _rootViewKey = GlobalKey<RootViewState>();
  DrawerPage _currentDashboardPage = DrawerPage.home;
  int _currentTabIndex = 1;

  String get _appBarTitle {
    if (_currentTabIndex == 1) {
      switch (_currentDashboardPage) {
        case DrawerPage.home:
          return 'home'.tr();
        case DrawerPage.students:
          return 'studentsManagement'.tr();
        case DrawerPage.teachers:
          return 'teachersManagement'.tr();
        case DrawerPage.groups:
          return 'groupsManagement'.tr();
        case DrawerPage.attendance:
          return 'attendanceManagement'.tr();
        case DrawerPage.payments:
          return 'paymentsManagement'.tr();
        case DrawerPage.paymentsReport:
          return 'paymentsReport'.tr();
        case DrawerPage.attendReport:
          return 'attendanceReport'.tr();
        case DrawerPage.settings:
          return 'settings'.tr();
      }
    }

    switch (_currentTabIndex) {
      case 0:
        return 'reports'.tr();
      case 2:
        return 'settings'.tr();
      default:
        return 'appTitle'.tr();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(_appBarTitle), centerTitle: true),
      drawer: CustomDrawer(
        isMobile: true,
        activePage: _currentDashboardPage,
        onItemSelected: (index, page) {
          setState(() {
            _currentDashboardPage = page;
          });
          _rootViewKey.currentState?.setDashboardPage(page);
          Navigator.pop(context); // Close the drawer
        },
      ),
      body: RootView(
        key: _rootViewKey,
        onTabChanged: (index) {
          setState(() {
            _currentTabIndex = index;
          });
        },
        onDashboardTabTap: () {
          if (_currentDashboardPage != DrawerPage.home) {
            setState(() {
              _currentDashboardPage = DrawerPage.home;
            });
          }
        },
      ),
    );
  }
}
