import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:porfolio/constants/colors.dart';

class RotatingImageContainer extends StatelessWidget {
  const RotatingImageContainer({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final bool isMobile = size.width < 600;

    final double containerSize = isMobile ? size.height * 0.3 : size.height * 0.6;

    return Container(
      height: containerSize,
      width: containerSize,
      padding: const EdgeInsets.all(0),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.transparent,
      ),
      child: Lottie.asset(
        'assets/lottie/applottie.json',
        fit: BoxFit.cover,
        repeat: true,
      ),
    );
  }
}
