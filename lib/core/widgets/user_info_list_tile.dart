import 'package:edu_center_manager/core/models/user_info_model.dart';
import 'package:edu_center_manager/core/utils/app_style.dart';
import 'package:flutter/material.dart';

class UserInfoListTile extends StatelessWidget {
  const UserInfoListTile({super.key, required this.userInfoModel});

  final UserInfoModel userInfoModel;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: FittedBox(
        fit: BoxFit.scaleDown,
        alignment: Alignment.centerLeft,
        child: Text(userInfoModel.title, style: AppStyles.styleRegular20(context)),
      ),
      subtitle: FittedBox(
        fit: BoxFit.scaleDown,
        alignment: Alignment.centerLeft,
        child: Text(userInfoModel.subTitle, style: AppStyles.styleRegular18(context)),
      ),
    );
  }
}
