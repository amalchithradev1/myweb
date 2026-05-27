import 'package:flutter/material.dart';
import '../skills_section.dart';

class MySkillsTabWidget extends StatelessWidget {
  final Size size;

  const MySkillsTabWidget({super.key, required this.size});

  @override
  Widget build(BuildContext context) {
    // Reuses the identical responsive Clyde-themed skills card layout
    return MySkillsWidget(size: size);
  }
}
