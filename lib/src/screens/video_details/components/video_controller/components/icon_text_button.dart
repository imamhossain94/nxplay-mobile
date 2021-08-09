import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:nx_play/src/utils/app_color.dart';
import 'package:nx_play/src/utils/responsive.dart';
import 'package:nx_play/src/utils/themes_mode.dart';

class IconTextButtonWidget extends StatelessWidget {
  const IconTextButtonWidget({
    Key key,
    @required this.icon,
    @required this.iconSize,
    @required this.title,
    @required this.onPressed,
  }) : super(key: key);
  final IconData icon;
  final String title;
  final VoidCallback onPressed;
  final double iconSize;
  @override
  Widget build(BuildContext context) {
    ThemesMode().init(context);
    Responsive().init(context);
    return Stack(
      children: <Widget>[
        Container(
            padding: EdgeInsets.fromLTRB(8, 5, 8, 5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                FaIcon(icon,
                    size: responsiveText(iconSize), //16
                    color: ThemesMode.isDarkMode
                        ? AppColors.textYellow
                        : AppColors.textBlue),
                SizedBox(
                  width: 5,
                ),
                Text(title, style: TextStyle(fontSize: responsiveText(12)))
              ],
            )),
        Positioned.fill(
            child: new Material(
                color: Colors.transparent,
                child: new InkWell(
                  borderRadius: BorderRadius.circular(5),
                  onTap: () {
                    onPressed();
                  },
                ))),
      ],
    );
  }
}
