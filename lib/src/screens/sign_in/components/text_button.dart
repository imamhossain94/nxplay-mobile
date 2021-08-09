import 'package:flutter/material.dart';
import 'package:nx_play/src/utils/app_color.dart';
import 'package:nx_play/src/utils/responsive.dart';
import 'package:nx_play/src/utils/themes_mode.dart';

class RoundedTextButton extends StatelessWidget {
  const RoundedTextButton(
      {Key key,
      @required this.buttonName,
      @required this.onPressed})
      : super(key: key);

  final String buttonName;
  final VoidCallback onPressed;

  String getName() => this.buttonName;

  @override
  Widget build(BuildContext context) {
    ThemesMode().init(context);
    Responsive().init(context);
    return Container(
      height: responsiveHeight(55),
      width: responsiveWidth(95),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: ThemesMode.isDarkMode?AppColors.secondaryDark:AppColors.textBlue,
      ),
      child: FlatButton(
        onPressed: () {
          onPressed();
        },
        child: Text(
          buttonName,
          style: TextStyle(
              fontSize: responsiveText(16), fontWeight: FontWeight.bold,
              color: Colors.white),
        ),
      ),
    );
  }
}
