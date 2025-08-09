import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactSection extends StatelessWidget {
  const ContactSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 30),
      color: Color(0XFF01529A),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            "Let's Connect",
            style: GoogleFonts.b612(
              color: Colors.white,
              fontSize: 28,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          Text(
            "Feel free to reach out for opportunities, collaborations, or just to say hi!",
            style: GoogleFonts.b612(color: Colors.white70, fontSize: 16),
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
                onPressed: () => _launch("mailto:amalchithradev@gmail.com"),
                tooltip: 'Email',
              ),
              IconButton(
                icon: const Icon(Icons.phone, color: Colors.white),
                onPressed: () => _launch("tel:+919037351180"),
                tooltip: 'Phone',
              ),
              IconButton(
                icon: const FaIcon(FontAwesomeIcons.linkedin, color: Colors.white),
                onPressed: () => _openExternalUrl('https://www.linkedin.com/in/amalchithradev/'),
                tooltip: 'LinkedIn',
              ),
              IconButton(
                icon: const FaIcon(FontAwesomeIcons.github, color: Colors.white),
                onPressed: () => _openExternalUrl('https://github.com/amalchithradev1'),
                tooltip: 'GitHub',
              ),
              IconButton(
                icon: const FaIcon(FontAwesomeIcons.instagram, color: Colors.white),
                onPressed: () => _openExternalUrl('https://www.instagram.com/_amal_abi_?utm_source=qr&igsh=aDd3ZGo0bTYwdm11'),
                tooltip: 'Instagram',
              ),
            ],
          ),

          const SizedBox(height: 20),
          Text(
            "© 2025 Amal | Built with Flutter",
            style: GoogleFonts.b612(color: Colors.white38, fontSize: 12),
          )
        ],
      ),
    );
  }
  void _launch(String command) async {
    final Uri uri = Uri.parse(command);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } else {
      throw 'Could not launch $command';
    }
  }

  Future<void> _openExternalUrl(String urlString) async {
    final Uri url = Uri.parse(urlString);
    if (await canLaunchUrl(url)) {
      await launchUrl(url, mode: LaunchMode.externalApplication);
    } else {
      throw 'Could not launch $urlString';
    }
  }


}
