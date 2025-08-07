import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactSection extends StatelessWidget {
  const ContactSection({super.key});

  void _launch(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 30),
      color: Color(0XFF01529A),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Text(
            "Let's Connect",
            style: TextStyle(
              color: Colors.white,
              fontSize: 28,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          const Text(
            "Feel free to reach out for opportunities, collaborations, or just to say hi!",
            style: TextStyle(color: Colors.white70, fontSize: 16),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 30),

          // Contact icons row
          Wrap(
            spacing: 20,
            alignment: WrapAlignment.center,
            children: [
              IconButton(
                icon: const Icon(Icons.email, color: Colors.white),
                onPressed: () => _launch("mailto:your_email@example.com"),
                tooltip: 'Email',
              ),
              IconButton(
                icon: const Icon(Icons.phone, color: Colors.white),
                onPressed: () => _launch("tel:+919999999999"),
                tooltip: 'Phone',
              ),
              IconButton(
                icon: const FaIcon(FontAwesomeIcons.linkedin, color: Colors.white),
                onPressed: () => _launch("https://www.linkedin.com/in/yourprofile"),
                tooltip: 'LinkedIn',
              ),
              IconButton(
                icon: const FaIcon(FontAwesomeIcons.github, color: Colors.white),
                onPressed: () => _launch("https://github.com/yourusername"),
                tooltip: 'GitHub',
              ),
              IconButton(
                icon: const FaIcon(FontAwesomeIcons.globe, color: Colors.white),
                onPressed: () => _launch("https://yourportfolio.com"),
                tooltip: 'Portfolio',
              ),
            ],
          ),

          const SizedBox(height: 20),
          const Text(
            "© 2025 Amal | Built with Flutter",
            style: TextStyle(color: Colors.white38, fontSize: 12),
          )
        ],
      ),
    );
  }
}
