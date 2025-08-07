import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';


class MySkillsMobileWidget extends StatelessWidget {
  final Size size;

  MySkillsMobileWidget({super.key, required this.size});

  final List<Map<String, dynamic>> skills = [
    const {
      "title": "Flutter & Dart",
      "description": "3.3+ years building cross-platform mobile apps with scalable architecture.",
      "icon": FontAwesomeIcons.mobileScreen,
    },
    const {
      "title": "Android",
      "description": "Experience building and deploying Android apps with platform-specific integrations.",
      "icon": FontAwesomeIcons.android,
    },
    const {
      "title": "iOS",
      "description": "Expertise in developing iOS apps using Flutter with smooth performance and native feel.",
      "icon": FontAwesomeIcons.apple,
    },
    const {
      "title": "Website",
      "description": "Developed responsive, interactive websites using Flutter Web and modern web practices.",
      "icon": FontAwesomeIcons.globe,
    },
    const {
      "title": "Firebase Suite",
      "description": "Realtime DB, Auth, Firestore, Crashlytics, FCM for complete app backend.",
      "icon": FontAwesomeIcons.fire,
    },
    {
      "title": "State Management",
      "description": "Riverpod, Provider – Clean architecture with MVVM patterns.",
      "icon": FontAwesomeIcons.diagramProject,
    },
    const {
      "title": "API Integration",
      "description": "Dio, http, REST APIs – robust backend communication.",
      "icon": FontAwesomeIcons.networkWired,
    },
    const {
      "title": "Database & Storage",
      "description": "Hive, SharedPreferences, SQLite for local persistence.",
      "icon": FontAwesomeIcons.database,
    },
    const {
      "title": "CI/CD & Deployment",
      "description": "GitHub Actions, Codemagic for automated deployment pipelines.",
      "icon": FontAwesomeIcons.codeBranch,
    },
    const {
      "title": "Payments & POS",
      "description": "Integrated Razorpay, UPI, Card, Plutus APIs & POS devices.",
      "icon": FontAwesomeIcons.creditCard,
    },
    const {
      "title": "UI/UX & Tools",
      "description": "Pixel-perfect Flutter UIs with Figma, HTML/CSS understanding.",
      "icon": FontAwesomeIcons.palette,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        int crossAxisCount = 1;

        if (constraints.maxWidth > 1250) {
          crossAxisCount = 6;
        } else if (constraints.maxWidth > 1150) {
          crossAxisCount = 5;
        } else if (constraints.maxWidth > 900) {
          crossAxisCount = 4;
        }else if (constraints.maxWidth > 700) {
          crossAxisCount = 3;
        }else if (constraints.maxWidth > 500) {
          crossAxisCount = 2;
        }else{
          crossAxisCount = 2;
        }


        return Container(
          // color: Colors.white,
          child: GridView.count(
            padding: EdgeInsets.zero,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            crossAxisCount: crossAxisCount,
            mainAxisSpacing: 10,
            crossAxisSpacing: 10,
            childAspectRatio: 1.3,

            children: skills.map((skill) {
              return _SkillMobileCard(
                title: skill['title'],
                description: skill['description'],
                icon: skill['icon'],
                size: size,
              );
            }).toList(),
          ),
        );
      },
    );
  }
}

class _SkillMobileCard extends StatefulWidget {
  final String title;
  final String description;
  final IconData icon;
  final Size size;

  const _SkillMobileCard({
    required this.title,
    required this.description,
    required this.icon,
    required this.size,
  });

  @override
  State<_SkillMobileCard> createState() => _SkillCardState();
}

class _SkillCardState extends State<_SkillMobileCard> {
  bool isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => isHovered = true),
      onExit: (_) => setState(() => isHovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        width: widget.size.width > 800 ? widget.size.width * 0.1 : widget.size.width * 0.8,
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          gradient: isHovered
              ? LinearGradient(colors: [Color(0XFF45D1FC),Colors.white],
            begin: Alignment.bottomCenter,
            end: Alignment.topCenter,
            stops: [0.0, 0.3],
          )
              : LinearGradient(colors: [Colors.white, Colors.white],
            begin: Alignment.bottomCenter,
            end: Alignment.topCenter,
            stops: [0.0, 0.1],
          ),
          borderRadius: BorderRadius.circular(100),
          border: Border.all(color: Color(0XFF01529A).withOpacity(0.5),width: 0.5),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            FaIcon(widget.icon, size: 20, color: isHovered ? Color(0XFF45D1FC) : Color(0XFF01529A),),
            const SizedBox(height: 10),
            Text(
              textAlign: TextAlign.center,
              widget.title,
              style: GoogleFonts.b612(
                fontSize: 12,
                fontWeight: FontWeight.w500,
                color: isHovered ? Colors.black : Colors.black,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              textAlign: TextAlign.center,
              widget.description,
              style: GoogleFonts.b612(
                fontSize: 8,
                fontWeight: FontWeight.normal,
                color: isHovered ? Colors.black54 : Colors.black54,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
