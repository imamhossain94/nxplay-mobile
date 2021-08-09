import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:nx_play/src/utils/app_color.dart';

class ThemesMode {
  static bool isDarkMode;

  void init(BuildContext context) {
    isDarkMode = Theme.of(context).brightness == Brightness.dark;
    SystemChrome.setSystemUIOverlayStyle(ThemesMode.isDarkMode
        ? SystemUiOverlayStyle(
            statusBarBrightness: Brightness.light,
            systemNavigationBarColor: AppColors.backgroundDark,
            systemNavigationBarIconBrightness: Brightness.light,
            statusBarColor: AppColors.backgroundDark,
            statusBarIconBrightness: Brightness.light,
          )
        : SystemUiOverlayStyle(
            systemNavigationBarColor: AppColors.backgroundLight,
            systemNavigationBarIconBrightness: Brightness.dark,
            statusBarColor: AppColors.white,
            statusBarBrightness: Brightness.dark,
            statusBarIconBrightness: Brightness.dark,
          ));
  }
}

