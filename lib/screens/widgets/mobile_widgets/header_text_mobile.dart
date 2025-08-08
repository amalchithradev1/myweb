import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:porfolio/constants/colors.dart';
import 'package:porfolio/screens/widgets/download_cv_widget.dart';
import 'package:porfolio/screens/widgets/social_widget.dart';
import 'package:porfolio/screens/widgets/text_widet.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';
import 'package:visibility_detector/visibility_detector.dart';

import '../rotating_image_widget.dart';

class HeaderTextMobileWidget extends StatelessWidget {
  final Size size;
  const HeaderTextMobileWidget({super.key, required this.size});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: size.width > 760
            ? CrossAxisAlignment.center
            : CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
              child: TextWidget(
                sSize: size,
                text: "amalchithradev",
                // color: AppColors.paleSlate,
                color: Colors.black.withOpacity(0.6),
                size: 15,
                fw: FontWeight.bold,
                alignment: TextAlign.center,
              )),
          GradientTextWidget(
            size: size,
            alignment: TextAlign.center,
            text1: "Flutter Developer",
            text2: "UX Designer",
          ),
          RotatingImageContainer(),
          TextWidget(
              sSize: size,
              alignment: TextAlign.center,
              text:
              "I break down complex user experinece problems to create integritiy focussed solutions that connect billions of people",
              size: 10,
              // color:AppColors.paleSlate,
              color: AppColors.ebony,
              fw: FontWeight.normal),
        ],
      ),
    );
  }
}

class GradientTextWidget extends StatelessWidget {
  final TextAlign? alignment;
  final String? text1;
  final String? text2;
  final Color? color1;
  final Color? color2;
  final double? fsize;
  final FontWeight? fw;
  const GradientTextWidget(
      {super.key,
        required this.size,
        this.alignment,
        this.fw,
        this.color1,
        this.text1,
        this.text2,
        this.color2,
        this.fsize});

  final Size size;

  @override
  Widget build(BuildContext context) {
    return GradientText(
      textAlign: size.width < 600 && alignment != null ? alignment : null,
      "${text1}\n${text2??""}",
      colors: [
        Color(0XFF01529A),
        Color(0XFF45D1FC),
        // AppColors.studio,
        // AppColors.paleSlate,
      ],
      style: GoogleFonts.b612(
          fontSize: size.width * 0.070,
          fontWeight: FontWeight.bold),
    );
  }
}

class Social_large extends StatelessWidget {
  const Social_large({
    super.key,
    required this.size,
  });

  final Size size;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size.width * 0.5,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          DownloadCVButton(),
          SizedBox(
            height: 20,
          ),
          SocialWidget(size: size,position: 1,)
        ],
      ),
    );
  }
}
