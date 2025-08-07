
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';

import '../../constants/colors.dart';


class CountWidget extends StatelessWidget {

  final Size size;
  final String text1;
  final String text2;
  final String text3;
  const CountWidget({super.key,required this.size,required this.text2, required this.text3, required this.text1});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [

        GradientText(
          "${text1}",
          colors: [
            Color(0XFF01529A),
            Color(0XFF45D1FC),
            // AppColors.studio,
            // AppColors.paleSlate,
          ],
          style: GoogleFonts.b612(
              fontSize: size.width * 0.040,
              fontWeight: FontWeight.bold),
        ),

        // Text("${text1}",style: GoogleFonts.gabarito(
        //   color: AppColors.paleSlate,
        //   fontWeight: FontWeight.bold,
        //   fontSize: size.width*0.05
        // ),),

        SizedBox(width: 10,),

        Text("${text2}\n${text3}",style: GoogleFonts.b612(color: Colors.black),)
      ],
    );
  }
}
