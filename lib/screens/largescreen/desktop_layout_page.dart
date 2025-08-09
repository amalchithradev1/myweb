import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:porfolio/constants/colors.dart';
import 'package:porfolio/constants/styles.dart';
import 'package:porfolio/screens/widgets/count_container_widget.dart';
import 'package:porfolio/screens/widgets/header_text_widget.dart';
import 'package:porfolio/screens/widgets/myservice_widgets.dart';
import 'package:porfolio/screens/widgets/rotating_image_widget.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';
import 'package:visibility_detector/visibility_detector.dart';

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
  bool isScrolledPastHome = false;

  final homeKey = GlobalKey();
  final aboutKey = GlobalKey();
  final skillsKey = GlobalKey();
  final services = GlobalKey();
  final projectsKey = GlobalKey();
  final contactKey = GlobalKey();

  final ScrollController _scrollController = ScrollController();


  void scrollToSection(GlobalKey key) {
    Scrollable.ensureVisible(
      key.currentContext!,
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOut,
    );
  }

  void _onScroll() {
    final homeContext = homeKey.currentContext;
    if (homeContext != null) {
      final RenderBox renderBox = homeContext.findRenderObject() as RenderBox;
      final position = renderBox.localToGlobal(Offset.zero).dy;

      // If top of home section is above app bar (i.e. scrolled past)
      if (position < 0 && !isScrolledPastHome) {
        setState(() => isScrolledPastHome = true);
      } else if (position >= 0 && isScrolledPastHome) {
        setState(() => isScrolledPastHome = false);
      }
    }
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
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        toolbarHeight: 30,
        backgroundColor: isScrolledPastHome ? Color(0XFF01529A) : Color(0XFF01529A),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            TextButton(
              onPressed: () => scrollToSection(homeKey),
              child: Text("Home", style: GoogleFonts.b612(color: Colors.white70, fontWeight: FontWeight.w500, fontSize: 12)),
            ),
            const SizedBox(width: 30,),
            TextButton(
              onPressed: () => scrollToSection(aboutKey),
              child: Text("About", style: GoogleFonts.b612(color: Colors.white70, fontWeight: FontWeight.w500, fontSize: 12)),
            ),
            const SizedBox(width: 30,),
            TextButton(
              onPressed: () => scrollToSection(skillsKey),
              child: Text("Skills", style: GoogleFonts.b612(color: Colors.white70, fontWeight: FontWeight.w500, fontSize: 12)),
            ),
            const SizedBox(width: 30,),
            TextButton(
              onPressed: () => scrollToSection(services),
              child: Text("Services", style: GoogleFonts.b612(color: Colors.white70, fontWeight: FontWeight.w500, fontSize: 12)),
            ),
            const SizedBox(width: 30,),
            TextButton(
              onPressed: () => scrollToSection(projectsKey),
              child: Text("Projects", style: GoogleFonts.b612(color: Colors.white70, fontWeight: FontWeight.w500, fontSize: 12)),
            ),
            const SizedBox(width: 30,),
            TextButton(
              onPressed: () => scrollToSection(contactKey),
              child: Text("Contact", style: GoogleFonts.b612(color: Colors.white70, fontWeight: FontWeight.w500, fontSize: 12)),
            ),
          ],
        ),
      ),
      body: NotificationListener<ScrollNotification>(
        onNotification: (_) {
          _onScroll();
          return true;
        },
        child: Container(
          height: double.infinity,
          width: double.infinity,
          decoration: Styles.gradientDecoration,
          child: SingleChildScrollView(
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
                      padding: EdgeInsets.only(top: size.height * 0.02  , left: size.width * 0.05, right: size.width * 0.05, bottom: size.height * 0.04),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(height: size.height * 0.1),
                              HeaderTextWidget(size: size),
                              const SizedBox(height: 20),
                              Social_large(size: size),
                            ],
                          ),
                          VisibilityDetector(
                            key: const Key('rotating-image'),
                            onVisibilityChanged: (info) {
                              final visiblePercentage = info.visibleFraction * 100;
                              setState(() => isImageVisible = visiblePercentage > 50);
                            },
                            child: RotatingImageContainer(),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: size.width * 0.05),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CountWidget(text1: "3", text2: "Years of", text3: "Experience",size: size,),
                      CountWidget(text1: "15+", text2: "Projects", text3: "Completed",size: size,),
                      CountWidget(text1: "50+", text2: "Happy", text3: "Customers",size: size,),
                      CountWidget(text1: "15k", text2: "Awesome", text3: "Reviews",size: size,),
                    ],
                  ),
                ),
                SizedBox(height: 50),
                Container(key: aboutKey,
                    color: Colors.white,
                    padding: EdgeInsets.symmetric(horizontal: size.width * 0.05),
                    child: AnimatedAboutScrollSection()),
                Container(
                  key: skillsKey,
                  color: Colors.white,
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(vertical: size.width * 0.01,horizontal: size.width * 0.05),
                  child: Column(
                    children: [
                      GradientText(
                        "Expertise In",
                        colors: [
                          Color(0XFF01529A),
                          Color(0XFF45D1FC),
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
                            color: Colors.black,
                            letterSpacing: 1,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: size.height * 0.05),
                      MySkillsWidget(size: size)
                    ],
                  ),
                ),
                Container(
                  key: services,
                  // color: AppColors.ebony,
                  color: Colors.transparent,
                  padding: EdgeInsets.symmetric(vertical: size.width * 0.05, horizontal: size.width * 0.05),
                  child: Stack(
                    children: [
                      const AnimatedParticleBackground(),
                      Column(
                        children: [
                          GradientText(
                            "My Quality Services",
                            colors: [
                              Color(0XFF01529A),
                              Color(0XFF45D1FC),
                            ],
                            style: GoogleFonts.b612(
                                fontSize: size.width * 0.030,
                                fontWeight: FontWeight.bold),
                          ),
                          SizedBox(height: size.height * 0.02),
                          Text(
                            'Services crafted from real-world experience in mobile apps, payment integration, Firebase, APIs, and CI/CD.',
                            style: GoogleFonts.b612(
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                                color: Colors.black),
                          ),
                          SizedBox(height: size.height * 0.05),
                          MyServicesWidget(size: size),
                        ],
                      ),
                    ],
                  ),
                ),
                Container(
                  color: Colors.white,
                  // color: Colors.transparent,
                  key: projectsKey,
                  width: double.infinity,
                  padding: EdgeInsets.only(bottom: size.height * 0.1),
                  child: Container(
                    width: double.infinity,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        GradientText(
                          "Featured Projects",
                          colors: [
                            Color(0XFF01529A),
                            Color(0XFF45D1FC),
                          ],
                          style: GoogleFonts.b612(
                            fontSize: size.width * 0.030,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: size.height * 0.05),
                        Container(
                          width: double.infinity,
                          height: 600,
                          padding: EdgeInsets.symmetric(horizontal: size.width * 0.05),
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: projects.length,
                            itemBuilder: (context, index) {
                              final project = projects[index];
                              return Row(
                                children: [
                                  ProjectTile(
                                    project: project,
                                    width: size.width > 800 ? size.width * 0.22 : size.width * 0.85,
                                    index: index, // Pass index here
                                  ),
                                  const SizedBox(width: 20),
                                ],
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  key: contactKey,
                  color: AppColors.ebony,
                  child: const Center(
                    child: ContactSection()
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  final List<Project> projects = [
    Project(
        title: "Ekasys ERP",
        description: "Ekasys ERP is a Cloud ERP Solution that Aims in Providing an integrated Inventory Management and Accounting Software to small and medium-sized Businesses.",
        videoPath: "assets/videos/ekasys.mp4",
        link: "",
        isWeb: true,
    ),
    Project(
      title: "WAW",
      description: "You can potentially earn money by watching advertisements through certain apps, which reward users for engaging with ads",
      videoPath: "assets/videos/waw_ad.mp4",
      link: "",
    ),
    Project(
        title: "Medoc HMS",
        description: "Medoc HMS provides operations management software to manage the day-to-day activities of your hospital, clinic, lab or pharmacy.",
        videoPath: "assets/videos/medoc.mp4", // Add actual video path later
        link: "",
        isWeb: true
    ),
    Project(
      title: "Al-aysh",
      description: "E-commerce platform for customers in Kuwait and Gulf countries.",
      videoPath: "assets/videos/alaysh_ad.mp4",
      link: "https://play.google.com/store/apps/details?id=com.smartsolns.alaysh&pcampaignid=web_share",
    ),
    Project(
      title: "Smart - Ecommerce",
      description: "Provide all its capabilities to serve our valued customers in the local range in Kuwait and Gulf countries, by providing all our products with the best quality and the best prices that suit our customers",
      videoPath: "assets/videos/alsanafer_ad.mp4",
      link: "https://play.google.com/store/apps/details?id=com.smartsolns.alaysh&pcampaignid=web_share",
    ),
    Project(
        title: "OlloBillz",
        description: "Contributed to revolutionizing the retail industry by developing an in-house marketplace and reward system, streamlining operations, and enhancing customer experiences.",
        videoPath: "assets/videos/olobillz_ad.mp4",
        link: "",
        isWeb: true
    ),
    Project(
      title: "SpotFeed",
      description: "SpotFeed is envisaged as an app that can help crowds/group of people within a particular geo - location to coordinate among each other, all without the need of exchanging phone numbers.",
      videoPath: "assets/videos/spotfeed.mp4",
      link: "",
    ),
    Project(
      title: "Deepus EC",
      description: "This application streamlines the process of obtaining an encumbrance certificate in Kerala, allowing users to easily download the document online.",
      videoPath: "assets/videos/deepus_ec_ad.mp4",
      link: "",
    ),
    Project(
        title: "Devasthanam",
        description: "Official Mobile App Of Peringottukara Devasthanam Sree Vishnumaya Swami Temple, ultimate destination for spiritual experiences and divine connection.",
        videoPath: "assets/videos/devasthanam-ad.mp4",
        link: "https://play.google.com/store/apps/details?id=com.devasthanam.app&pcampaignid=web_share",
    ),
  ];
}