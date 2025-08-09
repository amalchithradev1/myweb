import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';


class MySkillsMobileWidget extends StatelessWidget {
  final Size size;

  MySkillsMobileWidget({super.key, required this.size});

  final List<Map<String, dynamic>> skills = [
    {
      "title": "Flutter & Dart",
      "description": "3.3+ years building cross-platform mobile apps with scalable architecture.",
      "icon": FontAwesomeIcons.mobileScreen,
      "iconColor": const Color(0xFF02569B), // Flutter Blue
      "align": "left"
    },
    {
      "title": "Android",
      "description": "Experience building and deploying Android apps with platform-specific integrations.",
      "icon": FontAwesomeIcons.android,
      "iconColor": const Color(0xFF3DDC84), // Android Green
      "align": "right"
    },
    {
      "title": "iOS",
      "description": "Expertise in developing iOS apps using Flutter with smooth performance and native feel.",
      "icon": FontAwesomeIcons.apple,
      "iconColor": Colors.black, // Apple Black
      "align": "left"
    },
    {
      "title": "Website",
      "description": "Developed responsive, interactive websites using Flutter Web and modern web practices.",
      "icon": FontAwesomeIcons.globe,
      "iconColor": const Color(0xFF4285F4), // Google Blue
      "align": "right"
    },
    {
      "title": "Firebase Suite",
      "description": "Realtime DB, Auth, Firestore, Crashlytics, FCM for complete app backend.",
      "icon": FontAwesomeIcons.fire,
      "iconColor": const Color(0xFFFFCA28), // Firebase Yellow
      "align": "left",
    },
    {
      "title": "State Management",
      "description": "Riverpod, Provider – Clean architecture with MVVM patterns.",
      "icon": FontAwesomeIcons.diagramProject,
      "iconColor": const Color(0xFF4CAF50), // Green
      "align": "right"
    },
    {
      "title": "API Integration",
      "description": "Dio, http, REST APIs – robust backend communication.",
      "icon": FontAwesomeIcons.networkWired,
      "iconColor": const Color(0xFF01529A), // Navy Blue
      "align": "left"
    },
    {
      "title": "Database & Storage",
      "description": "Hive, SharedPreferences, SQLite for local persistence.",
      "icon": FontAwesomeIcons.database,
      "iconColor": const Color(0xFF616161), // Grey
      "align": "right"
    },
    {
      "title": "CI/CD & Deployment",
      "description": "GitHub Actions, Codemagic for automated deployment pipelines.",
      "icon": FontAwesomeIcons.codeBranch,
      "iconColor": const Color(0xFF4078C0), // GitHub Blue
      "align": "left"
    },
    {
      "title": "Payments & POS",
      "description": "Integrated Razorpay, UPI, Card, Plutus APIs & POS devices.",
      "icon": FontAwesomeIcons.creditCard,
      "iconColor": const Color(0xFF003087), // Card Blue
      "align": "right"
    },
    {
      "title": "UI/UX & Tools",
      "description": "Pixel-perfect Flutter UIs with Figma, HTML/CSS understanding.",
      "icon": FontAwesomeIcons.palette,
      "iconColor": const Color(0xFF9C27B0), // Purple
      "align": "left"
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
          crossAxisCount = 1;
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
            childAspectRatio: 3.4,

            children: skills.map((skill) {
              return _SkillMobileCard(
                title: skill['title'],
                description: skill['description'],
                icon: skill['icon'],
                size: size,
                align: skill['align'],
                color: skill['iconColor'],
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
  final String align;
  final Color color;

  const _SkillMobileCard({
    required this.title,
    required this.description,
    required this.icon,
    required this.size,
    required this.align,
    required this.color,
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
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100),
          border: Border.all(color: Colors.black.withOpacity(0.08),width: 0.5),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            if(widget.align == "left")Flexible(
              flex: 6,
              child: Text(
                textAlign: TextAlign.center,
                widget.description,
                style: GoogleFonts.b612(
                  fontSize: 10,
                  fontWeight: FontWeight.normal,
                  color: isHovered ? Colors.black54 : Colors.black54,
                ),
              ),
            ),
            Flexible(
              flex: 4,
              child: Container(
                width: 110,
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(300),
                  border: Border.all(color: Color(0XFF01529A).withOpacity(0.2),width: 0.5),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    FaIcon(widget.icon, size: 25, color: widget.color.withOpacity(0.6)),
                    const SizedBox(height: 5),
                    Text(
                      textAlign: TextAlign.center,
                      widget.title,
                      style: GoogleFonts.b612(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        color: isHovered ? Colors.black : Colors.black,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            if(widget.align == "right")Flexible(
              flex: 6,
              child: Text(
                textAlign: TextAlign.center,
                widget.description,
                style: GoogleFonts.b612(
                  fontSize: 10,
                  fontWeight: FontWeight.normal,
                  color: isHovered ? Colors.black54 : Colors.black54,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
