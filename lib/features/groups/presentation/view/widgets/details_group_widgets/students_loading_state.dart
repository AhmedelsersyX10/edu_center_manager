import 'package:flutter/material.dart';

class StudentsLoadingState extends StatelessWidget {
  const StudentsLoadingState({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.all(64),
      child: Center(child: CircularProgressIndicator()),
    );
  }
}
