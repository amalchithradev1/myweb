import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:porfolio/constants/colors.dart';
import 'package:porfolio/screens/widgets/text_widet.dart';

class MyServicesWidget extends StatefulWidget {
  final Size size;
  const MyServicesWidget({super.key, required this.size});

  @override
  State<MyServicesWidget> createState() => _MyServicesWidgetState();
}

class _MyServicesWidgetState extends State<MyServicesWidget> {
  final List<Map<String, String>> services = [
    {
      "title": "Flutter App Development",
      "description":
      "High-performance Android/iOS apps using Flutter & Dart with clean architecture.",
    },
    {
      "title": "POS & Payment Integration",
      "description":
      "Integrated UPI, Razorpay, Paytm, and card systems into apps and POS devices.",
    },
    {
      "title": "Firebase & Backend Setup",
      "description":
      "Auth, Firestore, FCM, Crashlytics integration for secure and scalable apps.",
    },
    {
      "title": "API & Third-party Integration",
      "description":
      "Connected RESTful APIs with Dio/http, enabled real-time features & ERP integration.",
    },
    {
      "title": "UI/UX Implementation",
      "description":
      "Designed pixel-perfect UIs with Figma and built responsive Flutter widgets.",
    },
    {
      "title": "CI/CD & Deployment",
      "description":
      "Automated delivery pipelines using GitHub Actions & Codemagic.",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: EdgeInsets.all(0.0),
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: services.length,
      itemBuilder: (context, index) {
        final isHovered = ValueNotifier(false);
        final service = services[index];

        return ValueListenableBuilder(
          valueListenable: isHovered,
          builder: (_, bool hovered, __) {
            return MouseRegion(
              onEnter: (_) => isHovered.value = true,
              onExit: (_) => isHovered.value = false,
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                margin: EdgeInsets.symmetric(vertical: 10),
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: hovered ? Color(0XFF01529A).withOpacity(0.5) : Colors.transparent,
                  ),
                  gradient: hovered
                      ? LinearGradient(colors: [Colors.white, Colors.white])
                      : null,
                  color: hovered ? null : Colors.transparent,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: widget.size.width > 600
                    ? Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    FaIcon(
                      hovered
                          ? FontAwesomeIcons.arrowTrendUp
                          : FontAwesomeIcons.arrowTrendDown,
                      color: hovered ?  Color(0XFF45D1FC) : AppColors.studio ,
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          TextWidget(
                            sSize: widget.size,
                            text: service['title']!,
                            size: 20,
                            color: Colors.black,
                          ),
                          const SizedBox(height: 10),
                          TextWidget(
                            sSize: widget.size,
                            text: service['description']!,
                            size: 14,
                            color: Colors.black,
                          ),
                        ],
                      ),
                    )
                  ],
                )
                    : Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextWidget(
                      sSize: widget.size,
                      text: service['title']!,
                      size: 18,
                      color: Colors.white,
                    ),
                    const SizedBox(height: 10),
                    TextWidget(
                      sSize: widget.size,
                      text: service['description']!,
                      size: 14,
                      color: Colors.white70,
                    ),
                    const SizedBox(height: 10),
                    Align(
                      alignment: Alignment.centerRight,
                      child: FaIcon(
                        hovered
                            ? FontAwesomeIcons.arrowTrendUp
                            : FontAwesomeIcons.arrowTrendDown,
                        color: hovered ? Colors.white : AppColors.studio,
                      ),
                    )
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
}
