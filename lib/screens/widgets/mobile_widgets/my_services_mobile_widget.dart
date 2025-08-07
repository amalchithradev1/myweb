import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:porfolio/constants/colors.dart';
import 'package:porfolio/screens/widgets/text_widet.dart';

class MyServicesMobileWidget extends StatefulWidget {
  final Size size;
  const MyServicesMobileWidget({super.key, required this.size});

  @override
  State<MyServicesMobileWidget> createState() => _MyServicesMobileWidgetState();
}

class _MyServicesMobileWidgetState extends State<MyServicesMobileWidget> {
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

  double itemHeight = 120; // Approximate height of each service item
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
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: Column(
        children: List.generate(services.length, (index) {
          final service = services[index];
          double startOffset = index * itemHeight;
          double endOffset = startOffset + itemHeight * 2;

          double visibility = (scrollOffset - startOffset) / (endOffset - startOffset);
          visibility = visibility.clamp(0.0, 1.0);

          return AnimatedOpacity(
            opacity: visibility,
            duration: const Duration(milliseconds: 400),
            child: AnimatedSlide(
              offset: Offset(0, 1 - visibility),
              duration: const Duration(milliseconds: 400),
              child: Container(
                margin: const EdgeInsets.only(bottom: 10),
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 30),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: const Color(0XFF01529A).withOpacity(0.3),
                    width: 0.5
                  ),
                  color: Colors.transparent,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    const FaIcon(
                      FontAwesomeIcons.arrowTrendUp,
                      color: Color(0XFF01529A),
                    ),
                    const SizedBox(width: 16),
                    SizedBox(
                      width: widget.size.width * 0.7,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          TextWidget(
                            sSize: widget.size,
                            text: service['title']!,
                            size: 12,
                            color: Colors.black,
                          ),
                          const SizedBox(height: 10),
                          TextWidget(
                            sSize: widget.size,
                            text: service['description']!,
                            size: 10,
                            color: Colors.black,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        }),
      ),
    );
  }
}