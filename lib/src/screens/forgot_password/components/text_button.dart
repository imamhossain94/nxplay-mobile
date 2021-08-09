import 'package:flutter/material.dart';
import 'package:nx_play/src/utils/app_color.dart';
import 'package:nx_play/src/utils/themes_mode.dart';

class RoundedButton extends StatelessWidget {
  const RoundedButton(
      {Key key,
      @required this.buttonName,
      @required this.onPressed})
      : super(key: key);

  final String buttonName;
  final VoidCallback onPressed;

  String getName() => this.buttonName;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      height: size.width * 0.14 < 60?size.width * 0.14:60,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: ThemesMode.isDarkMode?AppColors.secondaryDark:AppColors.textBlue,
      ),
      child: FlatButton(
        onPressed: () {
          onPressed();
        },
        child: Text(
          buttonName,
          style: TextStyle(
              fontSize: size.width *  0.05 < 16?size.width *  0.05:16, fontWeight: FontWeight.bold,
              color: Colors.white),
        ),
      ),
    );
  }
}
