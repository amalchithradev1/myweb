import 'package:animated_background/animated_background.dart';
import 'package:flutter/material.dart';


class AnimatedParticleMobileHomeBackground extends StatefulWidget {
  const AnimatedParticleMobileHomeBackground({super.key});

  @override
  State<AnimatedParticleMobileHomeBackground> createState() => _AnimatedParticleMobileHomeBackgroundState();
}

class _AnimatedParticleMobileHomeBackgroundState extends State<AnimatedParticleMobileHomeBackground>
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
            minOpacity: 0.05,
            maxOpacity: 0.1,
            spawnMinSpeed: 10.0,
            spawnMaxSpeed: 40.0,
            spawnMinRadius: 3.0,
            spawnMaxRadius: 20,
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
