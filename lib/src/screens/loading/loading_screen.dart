import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:nx_play/src/utils/app_color.dart';
import 'package:nx_play/src/utils/themes_mode.dart';

class LoadingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    ThemesMode().init(context);
    return Center(
      child: SpinKitFadingCircle(
        color:
            ThemesMode.isDarkMode ? AppColors.textWhite : AppColors.textBlack,
        size: 50.0,
      ),
    );
  }
}
