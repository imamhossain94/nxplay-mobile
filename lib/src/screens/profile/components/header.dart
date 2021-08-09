import 'package:flutter/material.dart';
import 'package:nx_play/src/utils/app_color.dart';
import 'package:nx_play/src/utils/responsive.dart';
import 'package:nx_play/src/utils/themes_mode.dart';

class HeaderWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    ThemesMode().init(context);
    Responsive().init(context);
    return Container(
      height: responsiveHeight(200),
      color: ThemesMode.isDarkMode?Colors.black:Colors.white,
      child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
        Container(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(8, 2, 8, 2),
            child: Text('NX',
                style: TextStyle(
                  fontFamily: 'Audiowide',
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  color: AppColors.textWhite,
                )),
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            color:
                ThemesMode.isDarkMode ? Colors.yellow[800] : AppColors.textBlue,
          ),
        ),
        SizedBox(
          width: 10,
        ),
        Text('PLAY',
            style: TextStyle(
              fontFamily: 'Audiowide',
              fontWeight: FontWeight.bold,
              fontSize: 18,
              color: ThemesMode.isDarkMode
                  ? AppColors.textWhite
                  : AppColors.textBlack,
            )),
      ]),
    );
  }
}
