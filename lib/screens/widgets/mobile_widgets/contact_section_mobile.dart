import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactMobileSection extends StatelessWidget {
  const ContactMobileSection({super.key});

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(
          vertical: 14, horizontal: 24), // Super-reduced vertical padding
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Color(0xFF000000), // Pure Obsidian Black
            Color(0xFF1E1E1E), // Rich Carbon Grey
            Color(0xFF000000), // Pure Obsidian Black
          ],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // 2. Main Heading
          Text(
            "Let's Connect",
            style: GoogleFonts.outfit(
              color: Colors.white,
              fontSize: 26,
              fontWeight: FontWeight.bold,
              letterSpacing: 0.6,
            ),
          ),
          const SizedBox(height: 4),

          // 3. Subtitle Description
          Text(
            "I'm always open to discussing new opportunities, collaborations, or innovative app ideas. Let's build something epic!",
            style: GoogleFonts.outfit(
              color: Colors.white.withOpacity(0.7),
              fontSize: 13,
              height: 1.45,
              fontWeight: FontWeight.w300,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 10), // Reduced spacer

          // 4. Primary Interactive Direct Email Card
          GestureDetector(
            onTap: () => _launch("mailto:amalchithradev@gmail.com"),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.05),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: Colors.white.withOpacity(0.15),
                  width: 1.2,
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 8,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.12),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.mail_outline_rounded,
                      color: Colors.white,
                      size: 18,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        "DIRECT EMAIL",
                        style: GoogleFonts.outfit(
                          color: Colors.white70,
                          fontSize: 9,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1.0,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        "amalchithradev@gmail.com",
                        style: GoogleFonts.outfit(
                          color: Colors.white,
                          fontSize: 13.5,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 0.3,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(width: 10),
                  Icon(
                    Icons.arrow_forward_ios_rounded,
                    color: Colors.white.withOpacity(0.4),
                    size: 12,
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 10), // Reduced spacer

          // 5. Beautiful Hover Pill Social Channels Wrap
          Wrap(
            spacing: 12,
            runSpacing: 12,
            alignment: WrapAlignment.center,
            children: [
              _HoverSocialButton(
                icon: FontAwesomeIcons.phone,
                label: "+91 90373 51180",
                onTap: () => _launch("tel:+919037351180"),
              ),
              _HoverSocialButton(
                icon: FontAwesomeIcons.linkedinIn,
                label: "LinkedIn",
                onTap: () => _openExternalUrl(
                    'https://www.linkedin.com/in/amalchithradev/'),
              ),
              _HoverSocialButton(
                icon: FontAwesomeIcons.github,
                label: "GitHub",
                onTap: () =>
                    _openExternalUrl('https://github.com/amalchithradev1'),
              ),
              _HoverSocialButton(
                icon: FontAwesomeIcons.instagram,
                label: "Instagram",
                onTap: () => _openExternalUrl(
                    'https://www.instagram.com/_amal_abi_?utm_source=qr&igsh=aDd3ZGo0bTYwdm11'),
              ),
            ],
          ),

          const SizedBox(height: 16), // Reduced spacer

          // 6. Clean, Styled Premium Footer
          Divider(
            color: Colors.white.withOpacity(0.08),
            thickness: 1,
          ),
          const SizedBox(height: 8),
          Column(
            children: [
              Text(
                "© 2026 Amal | All rights reserved",
                style: GoogleFonts.outfit(
                  color: Colors.white.withOpacity(0.35),
                  fontSize: 11,
                  fontWeight: FontWeight.w400,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                "Built with Flutter",
                style: GoogleFonts.outfit(
                  color: Colors.white.withOpacity(0.35),
                  fontSize: 11,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _launch(String command) async {
    final Uri uri = Uri.parse(command);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }

  Future<void> _openExternalUrl(String urlString) async {
    final Uri url = Uri.parse(urlString);
    if (await canLaunchUrl(url)) {
      await launchUrl(url, mode: LaunchMode.externalApplication);
    }
  }
}

// Stateful hover button scaled for Mobile
class _HoverSocialButton extends StatefulWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;

  const _HoverSocialButton({
    required this.icon,
    required this.label,
    required this.onTap,
  });

  @override
  State<_HoverSocialButton> createState() => _HoverSocialButtonState();
}

class _HoverSocialButtonState extends State<_HoverSocialButton> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 250),
          curve: Curves.easeOutCubic,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          decoration: BoxDecoration(
            color: _isHovered
                ? Colors.white.withOpacity(0.12)
                : Colors.white.withOpacity(0.04),
            borderRadius: BorderRadius.circular(30),
            border: Border.all(
              color: _isHovered
                  ? Colors.white.withOpacity(0.9)
                  : Colors.white.withOpacity(0.12),
              width: 1.0,
            ),
            boxShadow: _isHovered
                ? [
                    BoxShadow(
                      color: Colors.white.withOpacity(0.15),
                      blurRadius: 10,
                      offset: const Offset(0, 3),
                    )
                  ]
                : [],
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              FaIcon(
                widget.icon,
                color: Colors.white,
                size: 13,
              ),
              const SizedBox(width: 8),
              Text(
                widget.label,
                style: GoogleFonts.outfit(
                  color: Colors.white,
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 0.3,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
