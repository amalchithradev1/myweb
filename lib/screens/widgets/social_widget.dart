import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:porfolio/constants/colors.dart';
import 'package:url_launcher/url_launcher.dart';


class SocialWidget extends StatelessWidget {
  final Size size;
  const SocialWidget({super.key, required this.size});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: size.width > 760
          ? CrossAxisAlignment.center
          : CrossAxisAlignment.center,
      mainAxisAlignment: size.width > 760
          ? MainAxisAlignment.center
          : MainAxisAlignment.center,
      children: [

      Container(

        height: 40,
        width: 40,
        decoration: BoxDecoration(
          color: Colors.transparent,
          shape: BoxShape.circle,
          border: Border.all(color: Color(0XFF01529A).withOpacity(0.5),)
        ),
        child: Center(
          child: IconButton(
            hoverColor: AppColors.paleSlate,
            onPressed: () async {
              final Uri url = Uri.parse('https://www.linkedin.com/in/amalchithradev/');
              if (await canLaunchUrl(url)) {
                await launchUrl(url, mode: LaunchMode.externalApplication);
              } else {
                throw 'Could not launch $url';
              }
            },
            icon: FaIcon(
              FontAwesomeIcons.linkedinIn,
              color: Color(0XFF01529A),
              size: 15,
            ),
          ),
        ),
      ),
        const SizedBox(width: 10,),
      Container(

        height: 40,
        width: 40,
        decoration: BoxDecoration(
          color: Colors.transparent,
          shape: BoxShape.circle, border: Border.all(color: Color(0XFF01529A).withOpacity(0.5),)
        ),
        child: Center(
          child: IconButton(
            hoverColor: AppColors.paleSlate,
            onPressed: (){},
            icon: FaIcon(
              FontAwesomeIcons.dribbble,
              color: Color(0XFF01529A),
              size: 15,
            ),
          ),
        ),
      ),
        const SizedBox(width: 10,),
        Container(

          height: 40,
          width: 40,
          decoration: BoxDecoration(
              color: Colors.transparent,
              shape: BoxShape.circle,
              border: Border.all(color: Color(0XFF01529A).withOpacity(0.5),)
          ),
          child: Center(
            child: IconButton(
              hoverColor: AppColors.paleSlate,
              onPressed: (){},
              icon: FaIcon(
                FontAwesomeIcons.upwork,
                color: Color(0XFF01529A),
                size: 15,
              ),
            ),
          ),
        ),
        const SizedBox(width: 10,),
        Container(

          height: 40,
          width: 40,
          decoration: BoxDecoration(
              color: Colors.transparent,
              shape: BoxShape.circle,
              border: Border.all(color: Color(0XFF01529A).withOpacity(0.5),)
          ),
          child: Center(
            child: IconButton(
              hoverColor: AppColors.paleSlate,
              onPressed: (){},
              icon: FaIcon(
                FontAwesomeIcons.github,
                color: Color(0XFF01529A),
                size: 15,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
