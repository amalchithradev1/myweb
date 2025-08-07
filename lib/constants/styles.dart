import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:porfolio/constants/colors.dart';

class Styles {

  static const BoxDecoration gradientDecoration = BoxDecoration(
    gradient: LinearGradient(
      colors: [
        // AppColors.ebony,
        // AppColors.ebony,
        // AppColors.studio,
        Colors.white,
        Colors.white,
      ],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      // stops: [0.6, 0.1], // Make the first color cover more
    ),
  );

  // static const BoxDecoration gradientDecoration =  BoxDecoration(
  //     gradient: LinearGradient(
  //         colors: [
  //           AppColors.ebony,
  //           AppColors.studio,
  //
  //         ]
  //     )
  // );
}

