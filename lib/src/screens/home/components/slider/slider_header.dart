import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:nx_play/src/utils/app_color.dart';
import 'package:nx_play/src/utils/themes_mode.dart';

class SliderHeader extends StatelessWidget {
  SliderHeader({
    Key key,
    @required this.length,
    @required this.selectedIndex,
  }) : super(key: key);
  final int length, selectedIndex;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(10, 35, 10, 10),
        child: Row(
          children: [
            Text(
              "LATEST VIDEOS",
              style: TextStyle(
                fontSize: 16,
                color: ThemesMode.isDarkMode
                    ? AppColors.textWhite
                    : AppColors.textBlack,
                fontWeight: FontWeight.bold,
              ),
            ),
            Spacer(),
            FaIcon(
              FontAwesomeIcons.angleLeft, size:18,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8, right:3, top:1),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                  length,(index) => buildDot(index: index),
                ),
              ),
            ),
            FaIcon(
              FontAwesomeIcons.angleRight, size:18,
            ),
          ],
        ),
      ),
    );
  }

  AnimatedContainer buildDot({int index}) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 200),
      margin: EdgeInsets.only(right: 5),
      height: 5,
      width: selectedIndex == index ? 16 : 8,
      decoration: BoxDecoration(
        // boxShadow: [
        //   BoxShadow(
        //     color: AppColors.textBlack.withOpacity(0.5),
        //     offset: Offset(0, 0),
        //     blurRadius: 5,
        //   ),
        // ],
        color: ThemesMode.isDarkMode?selectedIndex == index ? AppColors.textWhite : Colors.grey: selectedIndex == index ? AppColors.textBlack : Colors.black45,
        borderRadius: BorderRadius.circular(3),
      ),
    );
  }
}
