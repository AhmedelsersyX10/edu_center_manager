import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerTable extends StatelessWidget {
  const ShimmerTable({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        children: List.generate(
          5,
          (index) => Padding(
            padding: const EdgeInsets.symmetric(vertical: 12),
            child: Shimmer.fromColors(
              baseColor: Colors.grey[300]!,
              highlightColor: Colors.grey[100]!,
              child: Row(
                children: [
                  Expanded(flex: 2, child: Container(height: 16, color: Colors.white)),
                  const SizedBox(width: 16),
                  Expanded(flex: 1, child: Container(height: 16, color: Colors.white)),
                  const SizedBox(width: 16),
                  Expanded(flex: 1, child: Container(height: 16, color: Colors.white)),
                  const SizedBox(width: 16),
                  Expanded(flex: 2, child: Container(height: 16, color: Colors.white)),
                  const SizedBox(width: 16),
                  Expanded(flex: 1, child: Container(height: 16, color: Colors.white)),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
