import 'package:flutter/material.dart';
import 'package:nx_play/src/utils/app_color.dart';
import 'package:nx_play/src/utils/responsive.dart';
import 'package:nx_play/src/utils/themes_mode.dart';

class RoundedIconButton extends StatelessWidget {
  const RoundedIconButton({
    Key key,
    @required this.onPressed,
    @required this.icon,
    @required this.color,
  }) : super(key: key);

  final VoidCallback onPressed;
  final IconData icon;
  final Color color;

  @override
  Widget build(BuildContext context) {
    ThemesMode().init(context);
    Responsive().init(context);
    return Stack(
      children: <Widget>[
        Container(
          height: responsiveHeight(55),
          width: responsiveWidth(52),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: ThemesMode.isDarkMode
                ? AppColors.secondaryDark
                : AppColors.textBlue,
          ),
          child: Icon(
            icon,
            color: color,
            size: responsiveHeight(20),
          ),
        ),
        Positioned.fill(
          child: new Material(
              color: Colors.transparent,
              child: new InkWell(
                borderRadius: BorderRadius.circular(15),
                onTap: () {
                  onPressed();
                },
              )
            )
        ),
      ],
    );
  }
}
