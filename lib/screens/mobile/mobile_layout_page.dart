import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:porfolio/constants/colors.dart';
import 'package:porfolio/constants/styles.dart';
import 'package:porfolio/screens/tablet/tablet_layout_page.dart';
import 'package:porfolio/screens/widgets/count_container_widget.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';
import '../widgets/mobile_widgets/about_section_mobile.dart';
import '../widgets/mobile_widgets/contact_section_mobile.dart';
import '../widgets/mobile_widgets/header_text_mobile.dart';
import '../widgets/mobile_widgets/my_services_mobile_widget.dart';
import '../widgets/mobile_widgets/particle_animation_home_section.dart';
import '../widgets/mobile_widgets/particle_animation_service_section.dart';
import '../widgets/mobile_widgets/project_section_mobile.dart';
import '../widgets/mobile_widgets/skills_mobile.dart';
import '../widgets/project_tile_card.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'dart:ui';
import 'package:porfolio/data/portfolio_data.dart';

class MobileLayout extends StatefulWidget {
  const MobileLayout({super.key});

  @override
  State<MobileLayout> createState() => _MobileLayoutState();
}

class _MobileLayoutState extends State<MobileLayout> {
  bool isImageVisible = false;
  bool isScrolledPastHome = false;
  bool isSidebarExpanded = false;
  String activeSection = "Home";

  final homeKey = GlobalKey();
  final aboutKey = GlobalKey();
  final skillsKey = GlobalKey();
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

    String newSection = activeSection;
    if (homeY != null && homeY.abs() < threshold) {
      newSection = "Home";
    } else if (aboutY != null && aboutY < threshold && aboutY > -threshold) {
      newSection = "About";
    } else if (skillsY != null && skillsY < threshold && skillsY > -threshold) {
      newSection = "Skills";
    } else if (projectsY != null && projectsY < threshold && projectsY > -threshold) {
      newSection = "Projects";
    } else if (contactY != null && contactY < threshold && contactY > -threshold) {
      newSection = "Contact";
    }

    if (newSection != activeSection) {
      setState(() {
        activeSection = newSection;
      });
    }

    // Update scrolled past state for backward compatibility
    if (homeY != null) {
      if (homeY < 0 && !isScrolledPastHome) {
        setState(() => isScrolledPastHome = true);
      } else if (homeY >= 0 && isScrolledPastHome) {
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

  Widget _buildSidebar(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
      width: isSidebarExpanded ? 180 : 65,
      height: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          if (isSidebarExpanded)
            BoxShadow(
              color: Colors.black.withOpacity(0.08),
              blurRadius: 15,
              offset: const Offset(4, 0),
            ),
        ],
      ),
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Top Header / Toggle Button
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 16),
              child: Row(
                mainAxisAlignment: isSidebarExpanded ? MainAxisAlignment.spaceBetween : MainAxisAlignment.center,
                children: [
                  if (isSidebarExpanded)
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: Text(
                        "amal.",
                        style: GoogleFonts.outfit(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                          letterSpacing: -0.5,
                        ),
                      ),
                    ),
                  IconButton(
                    icon: Icon(
                      isSidebarExpanded ? Icons.menu_open : Icons.menu,
                      color: Colors.black87,
                      size: 22,
                    ),
                    onPressed: () {
                      setState(() {
                        isSidebarExpanded = !isSidebarExpanded;
                      });
                    },
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            // Navigation Items
            _buildSidebarNavItem("Home", Icons.home_outlined, homeKey),
            _buildSidebarNavItem("About", Icons.person_outline, aboutKey),
            _buildSidebarNavItem("Skills", Icons.bolt_outlined, skillsKey),
            _buildSidebarNavItem("Projects", Icons.folder_outlined, projectsKey),
            _buildSidebarNavItem("Contact", Icons.mail_outline, contactKey),
          ],
        ),
      ),
    );
  }

  Widget _buildSidebarNavItem(String label, IconData icon, GlobalKey sectionKey) {
    final bool isActive = activeSection == label;
    
    return InkWell(
      onTap: () {
        scrollToSection(sectionKey);
        // Auto-collapse sidebar on mobile screen once selected to clear readability space
        if (MediaQuery.of(context).size.width < 600) {
          setState(() {
            isSidebarExpanded = false;
          });
        }
      },
      borderRadius: BorderRadius.circular(10),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 8),
        padding: const EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          color: isActive ? Colors.black.withOpacity(0.05) : Colors.transparent,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          mainAxisAlignment: isSidebarExpanded ? MainAxisAlignment.start : MainAxisAlignment.center,
          children: [
            SizedBox(width: isSidebarExpanded ? 12 : 0),
            Icon(
              icon,
              color: isActive ? Colors.black : Colors.black38,
              size: 20,
            ),
            if (isSidebarExpanded) ...[
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  label,
                  style: GoogleFonts.outfit(
                    color: isActive ? Colors.black87 : Colors.black45,
                    fontWeight: isActive ? FontWeight.bold : FontWeight.w500,
                    fontSize: 13,
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    
    // Main content width is strictly decoupled from the expanding overlay drawer to prevent constraint breakdown!
    double contentWidth = screenSize.width - 65;
    Size size = Size(contentWidth, screenSize.height);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        toolbarHeight: 0.0,
        backgroundColor: Colors.transparent,
      ),
      body: Stack(
        children: [
          // 1. Full Screen Layout containing Content + fixed placeholder spacing for Collapsed Menu
          Positioned.fill(
            child: Row(
              children: [
                // Clean structural spacer matching the exact collapsed menu width
                const SizedBox(width: 65),
                // Content area
                Expanded(
                  child: NotificationListener<ScrollNotification>(
                    onNotification: (_) {
                      _onScroll();
                      return true;
                    },
                    child: Container(
                      height: double.infinity,
                      width: double.infinity,
                      decoration: Styles.gradientDecoration,
                      child: SingleChildScrollView(
                        controller: _scrollController,
                        child: Column(
                          children: [
                            const SizedBox(height: 20),
                            Container(
                              key: homeKey,
                              padding: EdgeInsets.only(left: size.height * 0.02, right: size.height * 0.02),
                              child: Stack(
                                children: [
                                  AnimatedParticleMobileHomeBackground(),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      HeaderTextMobileWidget(
                                        size: size,
                                      ).animate().fade(duration: 600.ms).slideY(begin: 0.1, end: 0),
                                      const SizedBox(height: 20),
                                      Social_Tab(size: size).animate().fade(duration: 800.ms, delay: 200.ms).slideY(begin: 0.2, end: 0)
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: size.width * 0.09),
                            Container(
                              width: size.width,
                              padding: EdgeInsets.only(left: size.height * 0.02, right: size.height * 0.02),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  CountWidget(size: size, text1: "3.9", text2: "Years of", text3: "Experience"),
                                  const SizedBox(height: 20),
                                  Divider(
                                    color: AppColors.paleSlate,
                                    indent: size.width * 0.1,
                                    endIndent: size.width * 0.1,
                                  ),
                                  const SizedBox(height: 20),
                                  CountWidget(size: size, text1: "25+", text2: "Projects", text3: "Completed"),
                                  const SizedBox(height: 20),
                                  Divider(
                                    color: AppColors.paleSlate,
                                    indent: size.width * 0.1,
                                    endIndent: size.width * 0.1,
                                  ),
                                  const SizedBox(height: 20),
                                  CountWidget(size: size, text1: "50K", text2: "Happy", text3: "Customers"),
                                  const SizedBox(height: 20),
                                  Divider(
                                    color: AppColors.paleSlate,
                                    indent: size.width * 0.1,
                                    endIndent: size.width * 0.1,
                                  ),
                                  const SizedBox(height: 20),
                                  CountWidget(size: size, text1: "15k", text2: "Awesome", text3: "Reviews"),
                                ],
                              ),
                            ),
                            Container(
                              key: aboutKey,
                              child: AboutSectionMobile(),
                            ),
                            Container(
                              key: skillsKey,
                              color: Colors.transparent,
                              width: double.infinity,
                              padding: EdgeInsets.only(left: size.height * 0.02, right: size.height * 0.02),
                              child: Column(
                                children: [
                                  GradientText(
                                    "Expertise In",
                                    colors: const [
                                      Color(0xFF000000),
                                      Color(0xFF7F7F7F),
                                    ],
                                    style: GoogleFonts.b612(
                                      fontSize: size.width * 0.05,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  SizedBox(height: size.height * 0.02),
                                  Text(
                                    'Skilled in crafting high-performance Flutter apps with modern UI, API integration, and scalable architecture. Specialized in payment systems, Firebase backend, CI/CD, and state management using Riverpod and MVVM principles.',
                                    style: GoogleFonts.b612(
                                      fontSize: 10,
                                      fontWeight: FontWeight.w100,
                                      color: Colors.black87,
                                      letterSpacing: 1,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                  SizedBox(height: size.height * 0.05),
                                  MySkillsMobileWidget(size: size),
                                ],
                              ),
                            ),
                            const SizedBox(height: 20),
                            Container(
                              color: Colors.transparent,
                              key: projectsKey,
                              width: double.infinity,
                              padding: EdgeInsets.symmetric(horizontal: size.width * 0.05, vertical: 20),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  GradientText(
                                    "Featured Projects",
                                    colors: const [
                                      Color(0xFF000000),
                                      Color(0xFF7F7F7F),
                                    ],
                                    style: GoogleFonts.b612(
                                      fontSize: 24,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(height: 20),
                                  
                                  // Category 1: Mobile Apps
                                  Text(
                                    "MOBILE APPLICATIONS",
                                    style: GoogleFonts.outfit(
                                      fontSize: 13,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black87.withOpacity(0.7),
                                      letterSpacing: 1.5,
                                    ),
                                  ),
                                  const SizedBox(height: 16),
                                  Builder(
                                    builder: (context) {
                                      // Calculate dynamic tile width to guarantee at least 2 columns fit on all standard phone sizes!
                                      final double paddingWidth = size.width * 0.10;
                                      final double tileWidth = ((size.width - paddingWidth - 16) / 2).clamp(115.0, 140.0);
                                      return Wrap(
                                        alignment: WrapAlignment.center,
                                        spacing: 16,
                                        runSpacing: 16,
                                        children: portfolioProjects
                                            .where((p) => !p.isWeb)
                                            .toList()
                                            .asMap()
                                            .entries
                                            .map((entry) {
                                          return ProjectMobileTile(
                                            project: entry.value,
                                            width: tileWidth,
                                            index: entry.key,
                                          );
                                        }).toList(),
                                      );
                                    },
                                  ),
                                  const SizedBox(height: 36),

                                  // Category 2: Web & Cloud
                                  Text(
                                    "WEB & CLOUD PLATFORMS",
                                    style: GoogleFonts.outfit(
                                      fontSize: 13,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black87.withOpacity(0.7),
                                      letterSpacing: 1.5,
                                    ),
                                  ),
                                  const SizedBox(height: 16),
                                  Wrap(
                                    alignment: WrapAlignment.center,
                                    spacing: 16,
                                    runSpacing: 16,
                                    children: portfolioProjects
                                        .where((p) => p.isWeb)
                                        .toList()
                                        .asMap()
                                        .entries
                                        .map((entry) {
                                      return ProjectMobileTile(
                                        project: entry.value,
                                        width: size.width * 0.90, // Responsive monitor width
                                        index: entry.key,
                                      );
                                    }).toList(),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              key: contactKey,
                              color: AppColors.ebony,
                              child: const Center(
                                child: ContactMobileSection(),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          
          // 2. High-end blurred translucent drawer backdrop overlay
          if (isSidebarExpanded)
            Positioned.fill(
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    isSidebarExpanded = false;
                  });
                },
                child: ClipRect(
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 3, sigmaY: 3),
                    child: Container(
                      color: Colors.black.withOpacity(0.25),
                    ),
                  ),
                ),
              ).animate().fade(duration: 250.ms),
            ),
          
          // 3. Floating Sidebar Panel overlaid on top
          Positioned(
            left: 0,
            top: 0,
            bottom: 0,
            child: Row(
              children: [
                _buildSidebar(context),
                // Sleek vertical separator line
                Container(
                  width: 1,
                  height: double.infinity,
                  color: Colors.black.withOpacity(0.06),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
