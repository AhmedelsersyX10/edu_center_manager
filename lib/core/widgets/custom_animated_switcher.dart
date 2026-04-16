import 'package:edu_center_manager/features/students/data/models/student_model.dart';
import 'package:flutter/material.dart';

class CustomAnimatedSwitcher extends StatelessWidget {
  const CustomAnimatedSwitcher({
    super.key,
    required this.isLoading,
    required this.students,
    required this.allCount,
    required this.child,
  });

  final bool isLoading;
  final List<StudentModel> students;
  final int allCount;
  final Widget child;

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
        key: ValueKey<String>('${isLoading}_${students.length}_$allCount'),
        child: child,
      ),
    );
  }
}
