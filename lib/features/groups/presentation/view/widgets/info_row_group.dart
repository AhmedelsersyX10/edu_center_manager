import 'package:edu_center_manager/core/utils/app_style.dart';
import 'package:flutter/material.dart';

class InfoRowGroup extends StatelessWidget {
  const InfoRowGroup({super.key, required this.icon, required this.label, required this.value});

  final IconData icon;
  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, size: 18),
        const SizedBox(width: 10),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(label, style: AppStyles.styleRegular14(context)),
              Text(
                value,
                style: AppStyles.styleBold18(context),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
