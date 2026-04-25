import 'package:flutter/material.dart';

class CustomAnimatedSwitcher extends StatelessWidget {
  const CustomAnimatedSwitcher({
    super.key,
    required this.isLoading,
    required this.items,
    required this.allCount,
    required this.child,
    this.scheduleRowsCount,
  });

  final bool isLoading;
  final List<Object> items;
  final int allCount;
  final Widget child;
  final int? scheduleRowsCount;

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 280),
      switchInCurve: Curves.easeOutCubic,
      switchOutCurve: Curves.easeInCubic,
      transitionBuilder: (child, anim) {
        return FadeTransition(
          opacity: anim,
          child: ScaleTransition(
            scale: Tween<double>(begin: 0.98, end: 1).animate(anim),
            child: child,
          ),
        );
      },
      child: KeyedSubtree(
        key: ValueKey<String>('${isLoading}_${items.length}_${allCount}_$scheduleRowsCount'),
        child: child,
      ),
    );
  }
}
