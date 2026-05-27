import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:porfolio/constants/colors.dart';

class RotatingImageContainer extends StatelessWidget {
  const RotatingImageContainer({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final bool isMobile = size.width < 760;

    final double sidebarWidth = size.width >= 1000 ? 280 : 0;
    final double availableWidth = size.width - sidebarWidth;
    final double containerSize = (isMobile ? availableWidth * 0.3 : availableWidth * 0.35).clamp(200.0, 380.0);

    return Container(
      height: containerSize,
      width: containerSize,
      padding: const EdgeInsets.all(0),
      decoration: const BoxDecoration(
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
