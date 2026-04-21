import 'package:easy_localization/easy_localization.dart';
import 'package:edu_center_manager/core/models/user_info_model.dart';
import 'package:edu_center_manager/core/utils/app_images.dart';
import 'package:edu_center_manager/core/utils/app_style.dart';
import 'package:edu_center_manager/core/widgets/drawer_page.dart';
import 'package:edu_center_manager/core/widgets/list_view_drawer_item.dart';
import 'package:edu_center_manager/core/widgets/user_info_list_tile.dart';
import 'package:flutter/material.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({super.key, this.onItemSelected, this.isMobile = false, this.activePage});
  final Function(int index, DrawerPage page)? onItemSelected;
  final bool isMobile;
  final DrawerPage? activePage;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: SizedBox(
              height: 120,
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(Assets.logo, height: 70),
                    FittedBox(
                      fit: BoxFit.scaleDown,
                      child: Text('appTitle'.tr(), style: AppStyles.styleRegular16(context)),
                    ),
                  ],
                ),
              ),
            ),
          ),
          const SliverToBoxAdapter(child: Divider(height: 1, thickness: 1)),
          const SliverToBoxAdapter(
            child: UserInfoListTile(
              userInfoModel: UserInfoModel(
                image: Assets.logo,
                title: 'Admin',
                subTitle: 'admin@edu.com',
              ),
            ),
          ),
          const SliverToBoxAdapter(child: Divider(height: 1, thickness: 1)),
          ListViewDrawerItem(
            onItemSelected: onItemSelected,
            isMobile: isMobile,
            activePage: activePage,
          ),
        ],
      ),
    );
  }
}
