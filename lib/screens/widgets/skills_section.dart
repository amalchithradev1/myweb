import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

class MySkillsWidget extends StatelessWidget {
  final Size size;

  MySkillsWidget({super.key, required this.size});

  // Re-added all 12 original skills with custom percentages above 80%
  final List<Map<String, dynamic>> skills = [
    {
      "title": "Languages",
      "description": "Dart, Kotlin, Java, HTML",
      "icon": FontAwesomeIcons.code,
      "percentage": 92,
    },
    {
      "title": "Frameworks",
      "description": "Flutter, Android Development",
      "icon": FontAwesomeIcons.mobileScreen,
      "percentage": 95,
    },
    {
      "title": "State Management",
      "description": "Riverpod, Provider, GetX",
      "icon": FontAwesomeIcons.diagramProject,
      "percentage": 90,
    },
    {
      "title": "Architecture",
      "description": "MVVM, MVC Clean Architecture",
      "icon": FontAwesomeIcons.layerGroup,
      "percentage": 88,
    },
    {
      "title": "Networking & APIs",
      "description": "RESTful APIs, Dio, HTTP",
      "icon": FontAwesomeIcons.networkWired,
      "percentage": 91,
    },
    {
      "title": "Database & Storage",
      "description": "SharedPreferences, Hive, SQLite",
      "icon": FontAwesomeIcons.database,
      "percentage": 86,
    },
    {
      "title": "Firebase & Cloud",
      "description":
          "Authentication, Firestore, FCM, Crashlytics, Cloud Hosting",
      "icon": FontAwesomeIcons.fire,
      "percentage": 94,
    },
    {
      "title": "Payment Integration",
      "description":
          "Razorpay, Paytm, Stripe, Paytrace, HDFC Gateway, Plutus By pinelabs",
      "icon": FontAwesomeIcons.creditCard,
      "percentage": 90,
    },
    {
      "title": "DevOps & CI/CD",
      "description": "Git, GitHub Actions, Codemagic",
      "icon": FontAwesomeIcons.codeBranch,
      "percentage": 85,
    },
    {
      "title": "AI Tools",
      "description": "Cursor, Antigravity",
      "icon": FontAwesomeIcons.robot,
      "percentage": 89,
    },
    {
      "title": "App Features",
      "description": "In-App Purchases, Deep Linking",
      "icon": FontAwesomeIcons.link,
      "percentage": 87,
    },
    {
      "title": "Performance",
      "description": "Optimization, Crash Analysis, Debugging",
      "icon": FontAwesomeIcons.gaugeHigh,
      "percentage": 88,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        int crossAxisCount = 6;
        double childAspectRatio = 0.80;

        // Breakpoints
        if (constraints.maxWidth > 1000) {
          crossAxisCount = 6;
          childAspectRatio = 0.80; // Perfect tall aspect ratio to fit the description text!
        } else if (constraints.maxWidth > 750) {
          crossAxisCount = 4;
          childAspectRatio = 0.85;
        } else {
          crossAxisCount = 3; // Show 3 items per row on Mobile & small Tablet!
          childAspectRatio = 0.65; // Much taller ratio to give robust vertical breathing room!
        }

        return Container(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: GridView.count(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            crossAxisCount: crossAxisCount,
            mainAxisSpacing: 10,
            crossAxisSpacing: 10,
            childAspectRatio: childAspectRatio,
            children: skills.map((skill) {
              return _SkillCard(
                title: skill['title'],
                description: skill['description'],
                icon: skill['icon'],
                percentage: skill['percentage'],
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
  final int percentage;
  final Size size;

  const _SkillCard({
    required this.title,
    required this.description,
    required this.icon,
    required this.percentage,
    required this.size,
  });

  @override
  State<_SkillCard> createState() => _SkillCardState();
}

class _SkillCardState extends State<_SkillCard> {
  bool isHovered = false;

  @override
  Widget build(BuildContext context) {
    final bool isMobile = MediaQuery.of(context).size.width < 600;
    final double circleSize = isMobile ? 40.0 : 54.0;
    final double strokeWidth = isMobile ? 3.2 : 4.5;
    final double percentageFontSize = isMobile ? 10.5 : 13.0;
    final double percentSignFontSize = isMobile ? 6.5 : 7.5;
    final double descFontSize = isMobile ? 8.5 : 9.5;
    final double titleFontSize = isMobile ? 8.0 : 9.0;
    final double iconSize = isMobile ? 8.5 : 10.0;

    return MouseRegion(
      onEnter: (_) => setState(() => isHovered = true),
      onExit: (_) => setState(() => isHovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOutCubic,
        transform: Matrix4.identity()
          ..translate(0.0, isHovered ? -4.0 : 0.0), // Subtle hover lift
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 6),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(isHovered ? 0.08 : 0.02),
              blurRadius: isHovered ? 12 : 6,
              offset: Offset(0, isHovered ? 5 : 2),
            ),
          ],
          border: Border.all(
            color: Colors.black.withOpacity(0.03),
            width: 1,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // 1. Compact Title & Icon inline row
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                FaIcon(
                  widget.icon,
                  size: iconSize,
                  color: isHovered ? Colors.black : Colors.black54, // Premium charcoal black on hover
                ),
                const SizedBox(width: 4),
                Flexible(
                  child: Text(
                    widget.title.toUpperCase(),
                    textAlign: TextAlign.center,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: GoogleFonts.outfit(
                      fontSize: titleFontSize,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                      letterSpacing: 0.4,
                    ),
                  ),
                ),
              ],
            ),
 
            // 2. High-density scaled circular indicator (40px or 54px diameter)
            Stack(
              alignment: Alignment.center,
              children: [
                SizedBox(
                  width: circleSize,
                  height: circleSize,
                  child: CircularProgressIndicator(
                    value: 1.0,
                    strokeWidth: strokeWidth,
                    valueColor: AlwaysStoppedAnimation<Color>(
                        Colors.black.withOpacity(0.04)),
                  ),
                ),
                SizedBox(
                  width: circleSize,
                  height: circleSize,
                  child: CircularProgressIndicator(
                    value: widget.percentage / 100,
                    strokeWidth: strokeWidth,
                    valueColor:
                        const AlwaysStoppedAnimation<Color>(Colors.black), // Premium carbon black
                  ),
                ),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${widget.percentage}",
                      style: GoogleFonts.outfit(
                        fontSize: percentageFontSize,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 1.0),
                      child: Text(
                        "%",
                        style: GoogleFonts.outfit(
                          fontSize: percentSignFontSize,
                          fontWeight: FontWeight.bold,
                          color: Colors.black54,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),

            // 3. Compact description
            Text(
              widget.description,
              textAlign: TextAlign.center,
              maxLines: 3, // Support 3 full lines for long details!
              overflow: TextOverflow.ellipsis,
              style: GoogleFonts.b612(
                fontSize: descFontSize,
                color: Colors.black54,
                height: 1.25,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
