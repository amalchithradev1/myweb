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

class MobileLayout extends StatefulWidget {
  const MobileLayout({super.key});

  @override
  State<MobileLayout> createState() => _MobileLayoutState();
}

class _MobileLayoutState extends State<MobileLayout> {
  bool isImageVisible = false;
  bool isScrolledPastHome = false;


  final homeKey = GlobalKey();
  final aboutKey = GlobalKey();
  final skillsKey = GlobalKey();
  // final services = GlobalKey();
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
      backgroundColor: Colors.white,
      appBar: AppBar(
        toolbarHeight: 0.0,
        backgroundColor: Colors.white,
      ),
      body: Column(
        children: [
          Container(
            color: Colors.white,
            padding: EdgeInsets.only(left: size.height * 0.02,top: size.height * 0.03, right: size.height * 0.02, bottom: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                TextButton(
                  onPressed: () => scrollToSection(homeKey),
                  style: TextButton.styleFrom(
                    padding: EdgeInsets.zero,
                    minimumSize: Size.zero,
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  ),
                  child: Text("Home", style: GoogleFonts.b612(color: Colors.black, fontWeight: FontWeight.w500, fontSize: 12)),
                ),
                SizedBox(width: 15),
                TextButton(
                  onPressed: () => scrollToSection(aboutKey),
                  style: TextButton.styleFrom(
                    padding: EdgeInsets.zero,
                    minimumSize: Size.zero,
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  ),
                  child: Text("About", style: GoogleFonts.b612(color: Colors.black, fontWeight: FontWeight.w500, fontSize: 12)),
                ),
                SizedBox(width: 15),
                TextButton(
                  onPressed: () => scrollToSection(skillsKey),
                  style: TextButton.styleFrom(
                    padding: EdgeInsets.zero,
                    minimumSize: Size.zero,
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  ),
                  child: Text("Skills", style: GoogleFonts.b612(color: Colors.black, fontWeight: FontWeight.w500, fontSize: 12)),
                ),
                // SizedBox(width: 15),
                // TextButton(
                //   onPressed: () => scrollToSection(services),
                //   style: TextButton.styleFrom(
                //     padding: EdgeInsets.zero,
                //     minimumSize: Size.zero,
                //     tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                //   ),
                //   child: Text("Services", style: GoogleFonts.b612(color: Colors.black, fontWeight: FontWeight.w500, fontSize: 12)),
                // ),
                SizedBox(width: 15),
                TextButton(
                  onPressed: () => scrollToSection(projectsKey),
                  style: TextButton.styleFrom(
                    padding: EdgeInsets.zero,
                    minimumSize: Size.zero,
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  ),
                  child: Text("Projects", style: GoogleFonts.b612(color: Colors.black, fontWeight: FontWeight.w500, fontSize: 12)),
                ),
                SizedBox(width: 15),
                TextButton(
                  onPressed: () => scrollToSection(contactKey),
                  style: TextButton.styleFrom(
                    padding: EdgeInsets.zero,
                    minimumSize: Size.zero,
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  ),
                  child: Text("Contact", style: GoogleFonts.b612(color: Colors.black, fontWeight: FontWeight.w500, fontSize: 12)),
                ),
              ],
            ),
          ),
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
                  child: Container(
                    child: Column(
                      children: [
                        SizedBox(
                          height: 20,
                        ),
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
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  Social_Tab(size: size)
                                ],
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: size.width * 0.09,
                        ),
                        Container(
                          width: size.width,
                          padding: EdgeInsets.only(left: size.height * 0.02, right: size.height * 0.02),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              CountWidget(size: size,text1: "3.9",text2: "Years of",text3: "Experience",),
                              const SizedBox(height: 20,),
                              Divider(
                                color: AppColors.paleSlate,
                                indent: size.width*0.1,
                                endIndent: size.width*0.1,

                              ),

                              const SizedBox(height: 20,),
                              CountWidget(size: size,text1: "25+",text2: "Projects",text3: "Completed",),
                              const SizedBox(height: 20,),
                              Divider(
                                color: AppColors.paleSlate,
                                indent: size.width*0.1,
                                endIndent: size.width*0.1,

                              ),

                              const SizedBox(height: 20,),
                              CountWidget(size: size,text1: "50K",text2: "Happy",text3: "Customers",),
                              const SizedBox(height: 20,),
                              Divider(
                                color: AppColors.paleSlate,
                                indent: size.width*0.1,
                                endIndent: size.width*0.1,

                              ),

                              const SizedBox(height: 20,),
                              CountWidget(size: size,text1: "15k",text2: "Awesome",text3: "Reviews",),

                            ],
                          ),
                        ),
                        Container(
                            key: aboutKey,
                            child: AboutSectionMobile()),
                        Container(
                          key: skillsKey,
                          color: Colors.white,
                          width: double.infinity,
                          padding: EdgeInsets.only(left: size.height * 0.02, right: size.height * 0.02),
                          child: Column(
                            children: [
                              GradientText(
                                "Expertise In",
                                colors: [
                                  Color(0XFF01529A),
                                  Color(0XFF45D1FC),
                                ],
                                style: GoogleFonts.b612(
                                    fontSize: size.width * 0.05,
                                    fontWeight: FontWeight.bold),
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
                              MySkillsMobileWidget(size: size)
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        // Container(
                        //   key: services,
                        //   // color: AppColors.ebony,
                        //   color: Colors.transparent,
                        //   padding: EdgeInsets.only(left: size.height * 0.02, right: size.height * 0.02),
                        //   child: Stack(
                        //     children: [
                        //       const AnimatedParticleMobileServiceBackground(),
                        //       Column(
                        //         children: [
                        //           GradientText(
                        //             "My Quality Services",
                        //             colors: [
                        //               Color(0XFF01529A),
                        //               Color(0XFF45D1FC),
                        //             ],
                        //             style: GoogleFonts.b612(
                        //                 fontSize: size.width * 0.05,
                        //                 fontWeight: FontWeight.bold),
                        //           ),
                        //           SizedBox(height: size.height * 0.02),
                        //           Text(
                        //             'Services crafted from real-world experience in mobile apps, payment integration, Firebase, APIs, and CI/CD.',
                        //             style: GoogleFonts.b612(
                        //               fontSize: 10,
                        //               fontWeight: FontWeight.w100,
                        //               color: Colors.black87,
                        //               letterSpacing: 1,
                        //             ),
                        //           ),
                        //           SizedBox(height: 20),
                        //           MyServicesMobileWidget(size: size),
                        //         ],
                        //       ),
                        //     ],
                        //   ),
                        // ),
                        Container(
                          color: Colors.white,
                          // color: Colors.transparent,
                          key: projectsKey,
                          width: double.infinity,
                          padding: EdgeInsets.only(left: size.height * 0.02, right: size.height * 0.02),
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
                                  fontSize: size.width * 0.05,
                                  fontWeight: FontWeight.bold
                                  ),
                                ),
                                SizedBox(height: size.height * 0.05),
                                Container(
                                  width: double.infinity,
                                  padding: EdgeInsets.zero,
                                  child: ListView.builder(
                                    padding: EdgeInsets.zero,
                                    physics: NeverScrollableScrollPhysics(),
                                    itemCount: projects.length,
                                    shrinkWrap: true,
                                    itemBuilder: (context, index) {
                                      final project = projects[index];
                                      return Column(
                                        children: [
                                          ProjectMobileTile(
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
                              child: ContactMobileSection()
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          )
        ],
      )
    );
  }

  final List<Project> projects = [
    Project(
      title: "TNA",
      description: "The New American App – Developed a Flutter-based news application delivering in-depth articles, political analysis, and investigative journalism. Built a clean, user-friendly interface with efficient content loading, secure access, and seamless reading experience for staying updated on national and global issues.",
      videoPath: "assets/videos/tna.mp4",
      playStoreLink: "https://play.google.com/store/apps/details?id=com.tnanews.ateam&pcampaignid=web_share",
      appStoreLink: "https://apps.apple.com/in/app/the-new-american-tna/id6748341602",
      isWeb: false,
    ),
    Project(
      title: "JBS",
      description: "JBS Mobile App – Developed a Flutter-based application providing access to articles, publications, and an integrated e-commerce store with donation support. Implemented secure user authentication, content management, payment processing, and donation features.",
      videoPath: "assets/videos/jbs.mp4",
      playStoreLink: "",
      appStoreLink: "",
      isWeb: false,
    ),
    Project(
      title: "WorryFree",
      description: "WorryFree App – Developed a Flutter-based healthcare mobile application to streamline doctor–patient interactions, including appointment booking, secure messaging, and patient record access. Integrated AI-assisted features for medical insights and ensured seamless real-time communication using Firebase.",
      videoPath: "assets/videos/worryfree.mp4",
      playStoreLink: "",
      appStoreLink: "",
      isWeb: false,
    ),
    Project(
      title: "OLOPO",
      description: "Olopo is a super app incorporating a range of mini apps and services designed to meet different parts of users' lives. Within the app, users have the ability to shop, accumulate loyalty points, and make use of these points across various platforms.",
      videoPath: "assets/videos/olopo-mob.mp4",
      playStoreLink: "https://play.google.com/store/apps/details?id=com.wac.olopouser&pcampaignid=web_share",
      appStoreLink: "https://apps.apple.com/in/app/olopo/id6651817861",
      isWeb: false,
    ),
    Project(
      title: "Ekasys ERP",
      description: "Ekasys ERP is a Cloud ERP Solution that Aims in Providing an integrated Inventory Management and Accounting Software to small and medium-sized Businesses.",
      videoPath: "assets/videos/ekasys.mp4",
      playStoreLink: "",
      appStoreLink: "",
      isWeb: true,
    ),
    Project(
      title: "WAW",
      description: "You can potentially earn money by watching advertisements through certain apps, which reward users for engaging with ads",
      videoPath: "assets/videos/waw_ad.mp4",
      playStoreLink: "",
      appStoreLink: "",
    ),
    Project(
        title: "Medoc HMS",
        description: "Medoc HMS provides operations management software to manage the day-to-day activities of your hospital, clinic, lab or pharmacy.",
        videoPath: "assets/videos/medoc.mp4", // Add actual video path later
        playStoreLink: "",
        appStoreLink: "",
        isWeb: true
    ),
    Project(
      title: "Al-aysh",
      description: "E-commerce platform for customers in Kuwait and Gulf countries.",
      videoPath: "assets/videos/alaysh.mp4",
      playStoreLink: "https://play.google.com/store/apps/details?id=com.smartsolns.alaysh&pcampaignid=web_share",
      appStoreLink: "https://apps.apple.com/in/app/al-aysh-supermarket-shopping/id6449591948",
    ),
    Project(
      title: "Fragranzia",
      description: "Perfume E-commerce App – A mobile shopping app for exploring and purchasing premium perfumes.",
      videoPath: "assets/videos/fragranzia.mp4",
      playStoreLink: "",
      appStoreLink: "",
    ),
    Project(
      title: "Smart - Ecommerce",
      description: "Provide all its capabilities to serve our valued customers in the local range in Kuwait and Gulf countries, by providing all our products with the best quality and the best prices that suit our customers",
      videoPath: "assets/videos/alsanafer_ad.mp4",
      playStoreLink: "https://play.google.com/store/apps/details?id=com.smartsolns.alaysh&pcampaignid=web_share",
      appStoreLink: '',
    ),
    Project(
        title: "OlloBillz",
        description: "Contributed to revolutionizing the retail industry by developing an in-house marketplace and reward system, streamlining operations, and enhancing customer experiences.",
        videoPath: "assets/videos/olobillz_ad.mp4",
        playStoreLink: "",
        appStoreLink: "",
        isWeb: true
    ),
    Project(
      title: "SpotFeed",
      description: "SpotFeed is envisaged as an app that can help crowds/group of people within a particular geo - location to coordinate among each other, all without the need of exchanging phone numbers.",
      videoPath: "assets/videos/spotfeed.mp4",
      playStoreLink: "",
      appStoreLink: "",
    ),
    Project(
      title: "Deepus EC",
      description: "This application streamlines the process of obtaining an encumbrance certificate in Kerala, allowing users to easily download the document online.",
      videoPath: "assets/videos/deepus_ec_ad.mp4",
      playStoreLink: "",
      appStoreLink: "",
    ),
    Project(
      title: "Devasthanam",
      description: "Official Mobile App Of Peringottukara Devasthanam Sree Vishnumaya Swami Temple, ultimate destination for spiritual experiences and divine connection.",
      videoPath: "assets/videos/devasthanam-ad.mp4",
      playStoreLink: "https://play.google.com/store/apps/details?id=com.devasthanam.app&pcampaignid=web_share",
      appStoreLink: "",
    ),
  ];

}
