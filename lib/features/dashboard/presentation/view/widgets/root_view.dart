import 'package:easy_localization/easy_localization.dart';
import 'package:edu_center_manager/core/utils/app_themes.dart';
import 'package:edu_center_manager/features/attendance/presentation/view/attendance_view.dart';
import 'package:edu_center_manager/features/dashboard/presentation/view/widgets/home_view.dart';
import 'package:edu_center_manager/features/dashboard/presentation/view/widgets/reports_view.dart';
import 'package:edu_center_manager/features/payments/presentation/view/payments_view.dart';
import 'package:edu_center_manager/features/settings/presentation/view/settings_view.dart';
import 'package:edu_center_manager/core/widgets/drawer_page.dart';
import 'package:edu_center_manager/features/students/presentation/view/students_view.dart';
import 'package:edu_center_manager/features/teachers/presentation/view/teachers_view.dart';
import 'package:edu_center_manager/features/groups/presentation/view/groups_view.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';

class RootView extends StatefulWidget {
  final VoidCallback? onDashboardTabTap;
  final ValueChanged<int>? onTabChanged;
  const RootView({super.key, this.onDashboardTabTap, this.onTabChanged});

  @override
  State<RootView> createState() => RootViewState();
}

class RootViewState extends State<RootView> {
  late final PersistentTabController _controller;
  DrawerPage _currentDashboardPage = DrawerPage.home;

  void setDashboardPage(DrawerPage page) {
    setState(() {
      _currentDashboardPage = page;
    });
    _controller.jumpToTab(1);
    widget.onTabChanged?.call(1);
  }

  @override
  void initState() {
    super.initState();
    _controller = PersistentTabController(initialIndex: 1);
  }

  Widget _buildDashboardPage() {
    switch (_currentDashboardPage) {
      case DrawerPage.students:
        return const StudentsView();
      case DrawerPage.teachers:
        return const TeachersView();
      case DrawerPage.groups:
        return const GroupsView();
      case DrawerPage.attendance:
        return const AttendanceView();
      case DrawerPage.payments:
        return const PaymentsView();
      default:
        return const HomeView();
    }
  }

  List<Widget> _buildScreens() {
    return [const ReportsView(), _buildDashboardPage(), const SettingsView()];
  }

  List<PersistentBottomNavBarItem> _navBarsItems() {
    return [
      PersistentBottomNavBarItem(
        icon: const Icon(Icons.receipt_long_rounded),
        title: 'reports'.tr(),
        activeColorPrimary: context.colors.primaryButton,
        inactiveColorPrimary: context.colors.primaryButton.withValues(alpha: 0.5),
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(Icons.dashboard_outlined),
        title: 'dashboard'.tr(),
        activeColorPrimary: context.colors.primaryButton,
        inactiveColorPrimary: context.colors.primaryButton.withValues(alpha: 0.5),
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(Icons.settings_outlined),
        title: 'settings'.tr(),
        activeColorPrimary: context.colors.primaryButton,
        inactiveColorPrimary: context.colors.primaryButton.withValues(alpha: 0.5),
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return PersistentTabView(
      context,
      controller: _controller,
      screens: _buildScreens(),
      items: _navBarsItems(),
      navBarStyle: NavBarStyle.style3,
      onItemSelected: (index) {
        widget.onTabChanged?.call(index);
        if (index == 1) {
          widget.onDashboardTabTap?.call();
          if (_currentDashboardPage != DrawerPage.home) {
            setState(() {
              _currentDashboardPage = DrawerPage.home;
            });
          }
        }
      },
      popBehaviorOnSelectedNavBarItemPress: PopBehavior.once,
      handleAndroidBackButtonPress: true,
      resizeToAvoidBottomInset: true,
      stateManagement: true,
      hideNavigationBarWhenKeyboardAppears: true,
      backgroundColor: context.colors.cardBackground,
    );
  }
}
