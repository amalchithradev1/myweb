import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../constants/colors.dart';

class MySkillsWidget extends StatelessWidget {
  final Size size;

  MySkillsWidget({super.key, required this.size});

  final List<Map<String, dynamic>> skills = [
    const {
      "title": "Languages",
      "description": "Dart, Kotlin, Java, HTML",
      "icon": FontAwesomeIcons.code,
    },
    const {
      "title": "Frameworks & Development",
      "description": "Flutter, Android Development",
      "icon": FontAwesomeIcons.mobileScreen,
    },
    const {
      "title": "State Management",
      "description": "Riverpod, Provider, GetX",
      "icon": FontAwesomeIcons.diagramProject,
    },
    const {
      "title": "Architecture",
      "description": "MVVM, Clean Architecture",
      "icon": FontAwesomeIcons.layerGroup,
    },
    const {
      "title": "Networking & APIs",
      "description": "RESTful APIs, Dio, HTTP",
      "icon": FontAwesomeIcons.networkWired,
    },
    const {
      "title": "Database & Storage",
      "description": "SharedPreferences, Hive, SQLite",
      "icon": FontAwesomeIcons.database,
    },
    const {
      "title": "Firebase & Cloud",
      "description": "Authentication, Firestore, FCM, Crashlytics, Cloud Hosting",
      "icon": FontAwesomeIcons.fire,
    },
    const {
      "title": "Payment Integration",
      "description": "Razorpay, Paytm, Stripe, Paytrave, HDFC Gateway",
      "icon": FontAwesomeIcons.creditCard,
    },
    const {
      "title": "DevOps & CI/CD",
      "description": "Git, GitHub Actions, Codemagic",
      "icon": FontAwesomeIcons.codeBranch,
    },
    const {
      "title": "AI Tools",
      "description": "Cursor, Antigravity",
      "icon": FontAwesomeIcons.robot,
    },
    const {
      "title": "App Features",
      "description": "In-App Purchases, Deep Linking",
      "icon": FontAwesomeIcons.link,
    },
    const {
      "title": "Performance & Debugging",
      "description": "Optimization, Crash Analysis, Debugging",
      "icon": FontAwesomeIcons.gaugeHigh,
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
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            crossAxisCount: crossAxisCount,
            mainAxisSpacing: 30,
            crossAxisSpacing: 30,
            childAspectRatio: 1.1 ,

            children: skills.map((skill) {
              return _SkillCard(
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

class _SkillCard extends StatefulWidget {
  final String title;
  final String description;
  final IconData icon;
  final Size size;

  const _SkillCard({
    required this.title,
    required this.description,
    required this.icon,
    required this.size,
  });

  @override
  State<_SkillCard> createState() => _SkillCardState();
}

class _SkillCardState extends State<_SkillCard> {
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
            FaIcon(widget.icon, size: 30, color: isHovered ? Color(0XFF45D1FC) : Color(0XFF01529A),),
            const SizedBox(height: 10),
            Text(
              textAlign: TextAlign.center,
              widget.title,
              style: GoogleFonts.b612(
                fontSize: 18,
                fontWeight: FontWeight.w500,
                color: isHovered ? Colors.black : Colors.black,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              textAlign: TextAlign.center,
              widget.description,
              style: GoogleFonts.b612(
                fontSize: 10,
                color: isHovered ? Colors.black : Colors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
