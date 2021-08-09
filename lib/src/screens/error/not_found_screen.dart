import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:nx_play/src/utils/app_color.dart';
import 'package:nx_play/src/utils/constant.dart';
import 'package:nx_play/src/utils/responsive.dart';
import 'package:nx_play/src/utils/themes_mode.dart';

class NotFoundScreen extends StatelessWidget {
  const NotFoundScreen({Key key,@required this.actionText, @required this.onPressed}) : super(key: key);
  final String actionText;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    Responsive().init(context);
    ThemesMode().init(context);
    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: responsiveHeight(50),
          ),
          Lottie.asset(
            ThemesMode.isDarkMode
                ? AppConstants.aNoInternetYellow
                : AppConstants.aNoInternetBlue,
            repeat: true,
            height: responsiveHeight(250),
            width: responsiveHeight(250),
          ),
          //Spacer(),
          Text("NOT FOUND",
              style: TextStyle(
                  fontSize: responsiveText(20), fontWeight: FontWeight.bold)),
          SizedBox(
            height: responsiveHeight(5),
          ),
          Text("We\'re sorry, we couldn\'t find the data.",
              style: TextStyle(
                fontSize: responsiveText(15),
              )),
          SizedBox(
            height: responsiveHeight(15),
          ),
          FlatButton(
            height: responsiveHeight(30),
            minWidth: responsiveHeight(30),
            color: ThemesMode.isDarkMode
                ? AppColors.textYellow
                : AppColors.textBlue,
            splashColor: AppColors.textWhite,
            onPressed: () {
              onPressed();
            },
            child: Text(actionText.toUpperCase(),
                style: TextStyle(
                  color: AppColors.textWhite,
                  fontSize: responsiveText(12),
                )),
          ),
          SizedBox(
            height: responsiveHeight(50),
          ),
        ],
      ),
    );
  }
}
