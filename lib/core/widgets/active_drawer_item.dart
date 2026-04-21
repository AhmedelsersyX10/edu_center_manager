import 'package:easy_localization/easy_localization.dart';
import 'package:edu_center_manager/core/models/drawer_item_model.dart';
import 'package:edu_center_manager/core/utils/app_themes.dart';
import 'package:edu_center_manager/core/utils/app_style.dart';
import 'package:flutter/material.dart';

class ActiveDrawerItem extends StatelessWidget {
  const ActiveDrawerItem({super.key, required this.drawerItemModel});
  final DrawerItemModel drawerItemModel;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        const SizedBox(width: 16),
        Icon(drawerItemModel.icon),
        const SizedBox(width: 16),
        FittedBox(
          fit: BoxFit.scaleDown,
          child: Text(drawerItemModel.title.tr(), style: AppStyles.styleBold18(context)),
        ),
        const SizedBox(width: 16),
        Container(width: 3.27, color: context.colors.primaryButton),
        const SizedBox(width: 16),
      ],
    );
  }
}
