import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:nx_play/src/utils/app_color.dart';

class AppTheme {
  ThemeData darkTheme() {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark);
    return ThemeData(
      scaffoldBackgroundColor: AppColors.backgroundDark,
      //backgroundColor: AppColors.backgroundDark,
      primarySwatch: Colors.grey,
      primaryColor: AppColors.backgroundDark,
      inputDecorationTheme: InputDecorationTheme(
        hintStyle: TextStyle(color: AppColors.textGrey),
        labelStyle: TextStyle(color: AppColors.textWhite),
      ),
      brightness: Brightness.dark,
      canvasColor: AppColors.textBlack,
      accentColor: AppColors.introGrey,
      accentIconTheme: IconThemeData(color: Colors.white),
    );
  }

  ThemeData lightTheme() {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);
    return ThemeData(
      scaffoldBackgroundColor: AppColors.backgroundLight,
      //backgroundColor: AppColors.backgroundLight,
      primarySwatch: Colors.grey,
      primaryColor: AppColors.backgroundLight,
      inputDecorationTheme: InputDecorationTheme(
        hintStyle: TextStyle(color: AppColors.textGrey),
        labelStyle: TextStyle(color: AppColors.textBlack),
      ),
      canvasColor: AppColors.textWhite,
      brightness: Brightness.light,
      accentColor: AppColors.introGrey,
      accentIconTheme: IconThemeData(color: Colors.black),
    );
  }

}
