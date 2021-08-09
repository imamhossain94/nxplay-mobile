import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:nx_play/src/utils/app_color.dart';
import 'package:nx_play/src/utils/constant.dart';
import 'package:nx_play/src/utils/responsive.dart';
import 'package:nx_play/src/utils/themes_mode.dart';

class Body extends StatelessWidget {
  const Body({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Responsive().init(context);
    ThemesMode().init(context);
    return Container(
      color: ThemesMode.isDarkMode?AppColors.backgroundDark:AppColors.backgroundLight,
      child: Column(
        crossAxisAlignment : CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          // Lottie.asset(
          //   ThemesMode.isDarkMode? AppConstants.aSplashWhite : AppConstants.aSplashBlue,
          //   repeat: true,
          //   height: responsiveHeight(200),
          //   width: responsiveHeight(200),
          // ),

          Image.asset(AppConstants.aSplashLogo, height: responsiveHeight(100), width: responsiveHeight(100),),
          // SizedBox(height: responsiveHeight(100),),
          // Text(
          //   AppConstants.appName.toUpperCase(),
          //   textAlign: TextAlign.center,
          //   style: TextStyle(
          //     fontFamily: 'Audiowide',
          //     fontSize: responsiveText(36),
          //     color: ThemesMode.isDarkMode ? AppColors.textWhite : AppColors.textBlue,
          //   ),
          // ),
        ],
      ),
    );
    
  }
}