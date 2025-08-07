import 'package:animated_background/animated_background.dart';
import 'package:flutter/material.dart';

import '../../constants/colors.dart';

class AnimatedParticleBackground extends StatefulWidget {
  const AnimatedParticleBackground({super.key});

  @override
  State<AnimatedParticleBackground> createState() => _AnimatedParticleBackgroundState();
}

class _AnimatedParticleBackgroundState extends State<AnimatedParticleBackground>
    with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return Positioned.fill(
      child: AnimatedBackground(
        behaviour: RandomParticleBehaviour(
          options: ParticleOptions(
            // baseColor: Color(0XFF45D1FC),
            baseColor: Color(0XFF01529A),
            spawnOpacity: 0.0,
            opacityChangeRate: 0.25,
            minOpacity: 0.03,
            maxOpacity: 0.07,
            spawnMinSpeed: 10.0,
            spawnMaxSpeed: 40.0,
            spawnMinRadius: 5.0,
            spawnMaxRadius: 80,
            particleCount: 10
            ,
          ),
        ),
        vsync: this,
        child: const SizedBox(),
      ),
    );
  }
}
