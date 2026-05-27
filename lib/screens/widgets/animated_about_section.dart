import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../constants/colors.dart';

class AnimatedAboutScrollSection extends StatefulWidget {
  const AnimatedAboutScrollSection({super.key});

  @override
  State<AnimatedAboutScrollSection> createState() =>
      _AnimatedAboutScrollSectionState();
}

class _AnimatedAboutScrollSectionState extends State<AnimatedAboutScrollSection> {
  final List<String> lines = [
    "Software Developer with 3.9 years of experience,",
    "specializing in mobile and web app development.",
    "I have successfully completed 15+ projects,",
    "delivering high-quality solutions with a focus on UI/UX design.",
    "My expertise lies in building efficient, scalable,",
    "and user-friendly applications using modern technologies.",
  ];

  double visibilityThreshold = 0.1; // controls how early line appears
  double lineHeight = 60; // approx. pixel height per line

  double scrollOffset = 0;

  @override
  Widget build(BuildContext context) {
    final scrollable = Scrollable.of(context);
    scrollable.position.addListener(() {
      setState(() {
        scrollOffset = scrollable.position.pixels;
      });
    });

    final double sidebarWidth = MediaQuery.of(context).size.width >= 1000 ? 280 : 0;
    final double availableWidth = MediaQuery.of(context).size.width - sidebarWidth;

    return Container(
      width: double.infinity,
      height: 550,
      padding: const EdgeInsets.symmetric(vertical: 40),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Wrap text block in Expanded so it gracefully wraps and fills remaining space instead of causing overflow
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(lines.length, (index) {
                double startOffset = index * lineHeight;
                double endOffset = startOffset + lineHeight * 2;

                // Calculate visibility progress
                double visibility = (scrollOffset - startOffset) / (endOffset - startOffset);
                visibility = visibility.clamp(0.0, 1.0);

                return AnimatedOpacity(
                  opacity: visibility,
                  duration: const Duration(milliseconds: 400),
                  child: AnimatedSlide(
                    offset: Offset(0, 1 - visibility),
                    duration: const Duration(milliseconds: 400),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 0.0),
                      child: Text(
                        lines[index],
                        style: GoogleFonts.b612(
                          color: Colors.black87,
                          fontSize: (availableWidth * 0.014).clamp(13.0, 16.0),
                          letterSpacing: 2,
                        ),
                        textAlign: TextAlign.start,
                      ),
                    ),
                  ),
                );
              }),
            ),
          ),
          const SizedBox(width: 40),
          // Clamped responsive image container matching remaining width
          Container(
            height: 460,
            width: (availableWidth * 0.35).clamp(200.0, 360.0),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(24),
              child: Image.asset(
                "assets/images/me1.jpeg",
                fit: BoxFit.cover,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
