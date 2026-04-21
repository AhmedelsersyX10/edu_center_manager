// ignore_for_file: camel_case_types

import 'package:easy_localization/easy_localization.dart';
import 'package:edu_center_manager/core/models/drawer_item_model.dart';
import 'package:edu_center_manager/core/utils/app_style.dart';
import 'package:flutter/material.dart';

class inActiveDrawerItem extends StatelessWidget {
  const inActiveDrawerItem({super.key, required this.drawerItemModel});
  final DrawerItemModel drawerItemModel;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const SizedBox(width: 16),
        Icon(drawerItemModel.icon),
        const SizedBox(width: 16),
        FittedBox(
          fit: BoxFit.scaleDown,
          child: Text(drawerItemModel.title.tr(), style: AppStyles.styleRegular16(context)),
        ),
      ],
    );
  }
}
