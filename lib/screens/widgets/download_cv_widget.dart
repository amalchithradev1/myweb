import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:porfolio/constants/colors.dart';

class DownloadCVButton extends StatelessWidget {
  const DownloadCVButton({super.key});

  void _launchCV() async {
    final Uri url = Uri.parse('assets/AmalResume_A4.pdf');

    // On web, just try to launch it directly without checking
    try {
      await launchUrl(
        url,
        webOnlyWindowName: '_blank', // open in new tab
      );
    } catch (e) {
      print("Could not launch CV URL: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _launchCV,
      child: Container(
        height: 50,
        width: 250,
        decoration: BoxDecoration(
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: const Color(0XFF01529A).withOpacity(0.5)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Download CV",
              style: GoogleFonts.b612(color: AppColors.ebony),
            ),
            const SizedBox.square(dimension: 12),
            FaIcon(FontAwesomeIcons.download, color: Colors.black.withOpacity(0.6), size: 18),
          ],
        ),
      ),
    );
  }
}
