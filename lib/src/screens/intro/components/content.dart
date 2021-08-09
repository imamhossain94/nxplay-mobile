import 'package:flutter/material.dart';
import 'package:nx_play/src/utils/responsive.dart';
import 'package:nx_play/src/utils/app_color.dart';
import 'package:nx_play/src/utils/themes_mode.dart';

class SplashContent extends StatelessWidget {
  const SplashContent({
    Key key,
    this.title,
    this.message,
    this.image,
  }) : super(key: key);
  final String title, message, image;

  @override
  Widget build(BuildContext context) {
    Responsive().init(context);
    ThemesMode().init(context);
    //var _isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: <Widget>[
          Spacer(),
          Image.asset(
            image,
            height: responsiveHeight(180),
            width: responsiveHeight(180),
          ),
          Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: responsiveText(18),
              color: ThemesMode.isDarkMode? AppColors.textWhite: AppColors.textBlue,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: responsiveHeight(10),),
          Text(
            message,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: responsiveText(14),
              color: ThemesMode.isDarkMode? AppColors.textWhite: AppColors.textBlue,
            ),
          ),
          Spacer(),
        ],
      ),
    );
  }
}
