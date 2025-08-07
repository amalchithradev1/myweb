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
    "Software Developer with 3 years of experience,",
    "specializing in mobile and web app development.",
    "I have successfully completed 13 projects,",
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

    return Container(
      width: double.infinity,
      height: MediaQuery.of(context).size.height * 0.7,
      // color: Colors.white,
      padding: const EdgeInsets.symmetric(vertical: 40),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Column(
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
                  offset: Offset(0, 1 - visibility), // slide up while appearing
                  duration: const Duration(milliseconds: 400),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 0.0),
                    child: Text(
                      lines[index],
                      style: GoogleFonts.b612(
                        color: Colors.black,
                        fontSize: MediaQuery.of(context).size.width * 0.013,
                        letterSpacing: 3
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              );
            }),
          ),
          Container(
            height: 350,
            width: MediaQuery.of(context).size.width * 0.25,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(200),
              child: Opacity(
                opacity: 0.8,
                child: Image.asset("assets/images/me.png", fit: BoxFit.cover),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
