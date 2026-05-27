import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:porfolio/constants/colors.dart';
import 'package:porfolio/constants/styles.dart';
import 'package:porfolio/screens/widgets/count_container_widget.dart';
import 'package:porfolio/screens/widgets/header_text_widget.dart';
import 'package:porfolio/screens/widgets/rotating_image_widget.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';
import 'package:visibility_detector/visibility_detector.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'dart:ui';
import 'package:porfolio/data/portfolio_data.dart';

import '../widgets/animated_about_section.dart';
import '../widgets/contact_section.dart';
import '../widgets/effects_a.dart';
import '../widgets/project_tile_card.dart';
import '../widgets/skills_section.dart';

class DesktopLayout extends StatefulWidget {
  const DesktopLayout({super.key});

  @override
  State<DesktopLayout> createState() => _DesktopLayoutState();
}

class _DesktopLayoutState extends State<DesktopLayout> {
  bool isImageVisible = false;

  final homeKey = GlobalKey();
  final aboutKey = GlobalKey();
  final skillsKey = GlobalKey();
  // final services = GlobalKey();
  final projectsKey = GlobalKey();
  final contactKey = GlobalKey();

  final ScrollController _scrollController = ScrollController();
  final ScrollController _projectScrollController = ScrollController();

  void scrollToSection(GlobalKey key) {
    Scrollable.ensureVisible(
      key.currentContext!,
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOut,
    );
  }

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    _projectScrollController.dispose();
    super.dispose();
  }

  String activeSection = "Home";

  void _onScroll() {
    final homeContext = homeKey.currentContext;
    final aboutContext = aboutKey.currentContext;
    final skillsContext = skillsKey.currentContext;
    final projectsContext = projectsKey.currentContext;
    final contactContext = contactKey.currentContext;

    double? homeY = homeContext != null
        ? (homeContext.findRenderObject() as RenderBox)
            .localToGlobal(Offset.zero)
            .dy
        : null;
    double? aboutY = aboutContext != null
        ? (aboutContext.findRenderObject() as RenderBox)
            .localToGlobal(Offset.zero)
            .dy
        : null;
    double? skillsY = skillsContext != null
        ? (skillsContext.findRenderObject() as RenderBox)
            .localToGlobal(Offset.zero)
            .dy
        : null;
    double? projectsY = projectsContext != null
        ? (projectsContext.findRenderObject() as RenderBox)
            .localToGlobal(Offset.zero)
            .dy
        : null;
    double? contactY = contactContext != null
        ? (contactContext.findRenderObject() as RenderBox)
            .localToGlobal(Offset.zero)
            .dy
        : null;

    double threshold = 220.0;

    String newActive = "Home";
    if (contactY != null && contactY < threshold) {
      newActive = "Contact";
    } else if (projectsY != null && projectsY < threshold) {
      newActive = "Projects";
    } else if (skillsY != null && skillsY < threshold) {
      newActive = "Skills";
    } else if (aboutY != null && aboutY < threshold) {
      newActive = "About";
    } else {
      newActive = "Home";
    }

    if (newActive != activeSection) {
      setState(() {
        activeSection = newActive;
      });
    }
  }

  Widget _buildMenuButton(String label, GlobalKey sectionKey) {
    final bool isActive = activeSection == label;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: InkWell(
        onTap: () => scrollToSection(sectionKey),
        hoverColor: Colors.transparent,
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
        child: AnimatedDefaultTextStyle(
          duration: const Duration(milliseconds: 200),
          style: GoogleFonts.b612(
            color: isActive ? Colors.black : Colors.black38,
            fontSize: 16,
            fontWeight: isActive ? FontWeight.bold : FontWeight.w400,
            letterSpacing: 1,
          ),
          child: Row(
            children: [
              AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                margin: const EdgeInsets.only(right: 12),
                width: isActive ? 24 : 0,
                height: 2,
                color: Colors.black,
              ),
              Text(label),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;

    // Adjust size dimensions for right side content rendering area
    Size size = Size(screenSize.width - 280, screenSize.height);

    return Scaffold(
      backgroundColor: Colors.white,
      body: Row(
        children: [
          // Fixed Left Sidebar Panel (Minimalist Clean Design inspired by elen)
          Container(
            width: 280,
            height: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 50, horizontal: 40),
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border(
                right: BorderSide(
                  color: Colors.black.withOpacity(0.06),
                  width: 1,
                ),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Logo Section
                Text(
                  "amal.",
                  style: GoogleFonts.outfit(
                    fontSize: 34,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                    letterSpacing: -0.5,
                  ),
                ),
                const SizedBox(height: 80),

                // Vertical Navigation Menus
                _buildMenuButton("Home", homeKey),
                _buildMenuButton("About", aboutKey),
                _buildMenuButton("Skills", skillsKey),
                _buildMenuButton("Projects", projectsKey),
                _buildMenuButton("Contact", contactKey),

                const Spacer(),

                // Footer Content & Copyright
                Text(
                  "Copyright ©2026 All rights reserved.",
                  style: GoogleFonts.b612(
                    color: Colors.black38,
                    fontSize: 11,
                    height: 1.5,
                  ),
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    Icon(Icons.code, size: 14, color: Colors.black38),
                    const SizedBox(width: 8),
                    Text(
                      "Made with Flutter",
                      style: GoogleFonts.b612(
                        color: Colors.black38,
                        fontSize: 11,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          // Expanded Content Area (Vertically Scrollable)
          Expanded(
            child: NotificationListener<ScrollNotification>(
              onNotification: (_) {
                _onScroll();
                return true;
              },
              child: Container(
                decoration: Styles.gradientDecoration,
                height: double.infinity,
                width: double.infinity,
                child: SingleChildScrollView(
                  controller: _scrollController,
                  padding: const EdgeInsets.all(0.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Stack(
                        children: [
                          const AnimatedParticleBackground(),
                          Container(
                            key: homeKey,
                            width: double.infinity,
                            padding: EdgeInsets.only(
                                top: size.height * 0.02,
                                left: size.width * 0.05,
                                right: size.width * 0.05,
                                bottom: size.height * 0.04),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(height: size.height * 0.1),
                                    HeaderTextWidget(size: size)
                                        .animate()
                                        .fade(duration: 600.ms)
                                        .slideX(begin: -0.1, end: 0),
                                    const SizedBox(height: 20),
                                    Social_large(size: size)
                                        .animate()
                                        .fade(duration: 800.ms, delay: 200.ms)
                                        .slideY(begin: 0.2, end: 0),
                                  ],
                                ),
                                VisibilityDetector(
                                  key: const Key('rotating-image'),
                                  onVisibilityChanged: (info) {
                                    final visiblePercentage =
                                        info.visibleFraction * 100;
                                    setState(() => isImageVisible =
                                        visiblePercentage > 50);
                                  },
                                  child: RotatingImageContainer(),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: size.width * 0.05),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            CountWidget(
                              text1: "3.9",
                              text2: "Years of",
                              text3: "Experience",
                              size: size,
                            ),
                            CountWidget(
                              text1: "25+",
                              text2: "Projects",
                              text3: "Completed",
                              size: size,
                            ),
                            CountWidget(
                              text1: "50+",
                              text2: "Happy",
                              text3: "Customers",
                              size: size,
                            ),
                            CountWidget(
                              text1: "15k",
                              text2: "Awesome",
                              text3: "Reviews",
                              size: size,
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 50),
                      Container(
                          key: aboutKey,
                          color: Colors.transparent,
                          padding: EdgeInsets.symmetric(
                              horizontal: size.width * 0.05),
                          child: AnimatedAboutScrollSection()),
                      Container(
                        key: skillsKey,
                        color: Colors.transparent,
                        width: double.infinity,
                        padding: EdgeInsets.symmetric(
                            vertical: size.width * 0.01,
                            horizontal: size.width * 0.05),
                        child: Column(
                          children: [
                            GradientText(
                              "Expertise In",
                              colors: const [
                                Color(0xFF000000), // Pure Black
                                Color(0xFF7F7F7F), // Silver Platinum
                              ],
                              style: GoogleFonts.b612(
                                  fontSize: size.width * 0.030,
                                  fontWeight: FontWeight.bold),
                            ),
                            SizedBox(height: size.height * 0.02),
                            Text(
                              'Skilled in crafting high-performance Flutter apps with modern UI, API integration, and scalable architecture. Specialized in payment systems, Firebase backend, CI/CD, and state management using Riverpod and MVVM principles.',
                              style: GoogleFonts.b612(
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                                color: Colors.black87,
                                letterSpacing: 1,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            SizedBox(height: size.height * 0.05),
                            MySkillsWidget(size: size)
                          ],
                        ),
                      ),
                      // Container(
                      //   key: services,
                      //   // color: AppColors.ebony,
                      //   color: Colors.transparent,
                      //   padding: EdgeInsets.symmetric(vertical: size.width * 0.05, horizontal: size.width * 0.05),
                      //   child: Stack(
                      //     children: [
                      //       const AnimatedParticleBackground(),
                      //       Column(
                      //         children: [
                      //           GradientText(
                      //             "My Quality Services",
                      //             colors: [
                      //               Color(0XFF01529A),
                      //               Color(0XFF45D1FC),
                      //             ],
                      //             style: GoogleFonts.b612(
                      //                 fontSize: size.width * 0.030,
                      //                 fontWeight: FontWeight.bold),
                      //           ),
                      //           SizedBox(height: size.height * 0.02),
                      //           Text(
                      //             'Services crafted from real-world experience in mobile apps, payment integration, Firebase, APIs, and CI/CD.',
                      //             style: GoogleFonts.b612(
                      //                 fontSize: 16,
                      //                 fontWeight: FontWeight.w400,
                      //                 color: Colors.black),
                      //           ),
                      //           SizedBox(height: size.height * 0.05),
                      //           MyServicesWidget(size: size),
                      //         ],
                      //       ),
                      //     ],
                      //   ),
                      // ),
                      Container(
                        color: Colors.transparent,
                        key: projectsKey,
                        width: double.infinity,
                        padding:
                            EdgeInsets.symmetric(vertical: size.width * 0.03),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            GradientText(
                              "Featured Projects",
                              colors: const [
                                Color(0xFF000000), // Pure Black
                                Color(0xFF7F7F7F), // Silver Platinum
                              ],
                              style: GoogleFonts.b612(
                                fontSize:
                                    (size.width * 0.030).clamp(24.0, 38.0),
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 40),

                            // Section 1: Mobile Apps Row
                            Text(
                              "MOBILE APPLICATIONS",
                              style: GoogleFonts.outfit(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.black87.withOpacity(0.75),
                                letterSpacing: 1.8,
                              ),
                            ),
                            const SizedBox(height: 20),
                            Container(
                              width: double.infinity,
                              padding: EdgeInsets.symmetric(
                                  horizontal: size.width * 0.05),
                              child: Wrap(
                                alignment: WrapAlignment.center,
                                runSpacing: 24,
                                children: portfolioProjects
                                    .where((p) => !p.isWeb)
                                    .toList()
                                    .asMap()
                                    .entries
                                    .map((entry) {
                                  final int index = entry.key;
                                  final project = entry.value;
                                  return ProjectTile(
                                    project: project,
                                    width:
                                        145, // Compact mobile mockup width aligning with page padding
                                    index: index,
                                  );
                                }).toList(),
                              ),
                            ),
                            const SizedBox(height: 50),

                            // Section 2: Web Projects Row
                            Text(
                              "WEB & CLOUD PLATFORMS",
                              style: GoogleFonts.outfit(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.black87.withOpacity(0.75),
                                letterSpacing: 1.8,
                              ),
                            ),
                            const SizedBox(height: 20),
                            Container(
                              width: double.infinity,
                              padding: EdgeInsets.symmetric(
                                  horizontal: size.width * 0.05),
                              child: Wrap(
                                alignment: WrapAlignment.center,
                                runSpacing: 24,
                                children: portfolioProjects
                                    .where((p) => p.isWeb)
                                    .toList()
                                    .asMap()
                                    .entries
                                    .map((entry) {
                                  final int index = entry.key;
                                  final project = entry.value;
                                  return ProjectTile(
                                    project: project,
                                    width:
                                        370, // Compact web mockup width aligning with page padding
                                    index: index,
                                  );
                                }).toList(),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        key: contactKey,
                        color: AppColors.ebony,
                        child: const Center(child: ContactSection()),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
