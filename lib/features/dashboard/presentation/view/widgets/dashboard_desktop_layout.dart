import 'package:edu_center_manager/core/widgets/drawer_page.dart';
import 'package:edu_center_manager/features/attendance/presentation/view/attendance_view.dart';
import 'package:edu_center_manager/features/attendance/presentation/view/widgets/attendance_report_view.dart';
import 'package:edu_center_manager/features/dashboard/presentation/view/widgets/home_view.dart';
import 'package:edu_center_manager/core/widgets/custom_drawer.dart';
import 'package:edu_center_manager/features/groups/presentation/view/groups_view.dart';
import 'package:edu_center_manager/features/payments/presentation/view/payments_view.dart';
import 'package:edu_center_manager/features/payments/presentation/view/widgets/payment_report_view.dart';
import 'package:edu_center_manager/features/settings/presentation/view/settings_view.dart';
import 'package:edu_center_manager/features/students/presentation/view/students_view.dart';
import 'package:edu_center_manager/features/teachers/presentation/view/teachers_view.dart';
import 'package:flutter/material.dart';

class DashboardDesktopLayout extends StatefulWidget {
  const DashboardDesktopLayout({super.key});

  @override
  State<DashboardDesktopLayout> createState() => _DashboardDesktopLayoutState();
}

class _DashboardDesktopLayoutState extends State<DashboardDesktopLayout> {
  DrawerPage _currentPage = DrawerPage.home;

  Widget _buildBody() {
    return switch (_currentPage) {
      DrawerPage.home => const HomeView(),
      DrawerPage.students => const StudentsView(),
      DrawerPage.teachers => const TeachersView(),
      DrawerPage.groups => const GroupsView(),
      DrawerPage.attendance => const AttendanceView(),
      DrawerPage.payments => const PaymentsView(),
      DrawerPage.paymentsReport => const PaymentReportView(),
      DrawerPage.attendReport => const AttendanceReportView(),
      DrawerPage.settings => const SettingsView(),
    };
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          SizedBox(
            child: CustomDrawer(
              activePage: _currentPage,
              onItemSelected: (_, page) => setState(() => _currentPage = page),
            ),
          ),
          Expanded(child: _buildBody()),
        ],
      ),
    );
  }
}
