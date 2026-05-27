import 'package:flutter/material.dart';
import 'package:porfolio/constants/colors.dart';

class Styles {
  static const BoxDecoration gradientDecoration = BoxDecoration(
    gradient: LinearGradient(
      colors: [
        Color(0xFFF6F8FD), // Deep ebony
        Color(0xFFFFFFFF), // Dark slate
      ],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
    ),
  );
}

