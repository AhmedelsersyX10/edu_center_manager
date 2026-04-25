import 'package:edu_center_manager/core/utils/app_themes.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerInfoCard extends StatelessWidget {
  const ShimmerInfoCard({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 5,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.only(bottom: 12),
          child: Shimmer.fromColors(
            baseColor: Colors.grey[300]!,
            highlightColor: Colors.grey[100]!,
            child: Container(
              height: 132,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: context.colors.border.withValues(alpha: 0.5),
              ),
            ),
          ),
        );
      },
    );
  }
}
