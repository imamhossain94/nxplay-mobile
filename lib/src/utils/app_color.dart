import 'package:flutter/material.dart';

class AppColors {
  
  static const backgroundLight = Color(0xffFAFAFA);
  //static const backgroundLight = Color(0xffF9F9F9);
  static Color backgroundDark = Color(0xff141617);
  //static Color backgroundDark = Color(0xff212028);

  static const textGrey = Colors.grey;
  static const textWhite = Colors.white;
  static const textBlack = Colors.black;
  static const textBlue = Color(0xff2962FF);
  static const textYellow = Color(0xFFFFCF18);
  static const textGreen = Color(0xFF2EC4B6);

  static Color primary = Color(0xff1a191f);
  static const primaryDark = Color(0xff141617);

  static Color secondary = Color(0xff18203d);
  static Color secondaryDark = Color(0xff30363B);

  static const textRed = Colors.red;

  static const cardWhite = Color(0xffF2F2F2);

  static const introGrey = Color(0xffE8E8E8);

  static const white = Colors.white;

  //Nav Colors

  static Gradient navBackgroundColorDark = LinearGradient(colors: [
    AppColors.backgroundDark,
    AppColors.backgroundDark,
  ], begin: Alignment.topCenter, end: Alignment.bottomCenter);

  static Gradient navItemColorYellow = LinearGradient(colors: [
    Colors.yellow[800],Colors.yellow[800],
    //Colors.yellow[800],
  ], begin: Alignment.topCenter, end: Alignment.bottomCenter);


  static Gradient navBackgroundColorLight = LinearGradient(colors: [
    AppColors.backgroundLight,
    AppColors.backgroundLight,
  ], begin: Alignment.topCenter, end: Alignment.bottomCenter);

  static Gradient navItemColorBlue = LinearGradient(colors: [
    AppColors.textBlue,
    AppColors.textBlue,
  ], begin: Alignment.topCenter, end: Alignment.bottomCenter);

}
