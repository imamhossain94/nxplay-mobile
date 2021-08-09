import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:nx_play/src/utils/app_color.dart';
import 'package:nx_play/src/utils/responsive.dart';
import 'package:nx_play/src/utils/themes_mode.dart';

class BottomIconTextButton extends StatelessWidget {
  final String title;
  final VoidCallback onPressed;
  const BottomIconTextButton({Key key, @required this.title, @required this.onPressed, }):super(key: key);

  @override
  Widget build(BuildContext context) {
    ThemesMode().init(context);
    Responsive().init(context);

    return Container(
      width: Responsive.screenWidth,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(topLeft: Radius.circular(3), topRight: Radius.circular(3)),
        color: ThemesMode.isDarkMode?Colors.grey[900].withOpacity(0.9):Colors.grey[300].withOpacity(0.5),
      ),
      child: Stack(
        children: [
          Container(
            padding: EdgeInsets.only(left: 20),
            alignment: Alignment.centerLeft,
            width: Responsive.screenWidth,
            height: 48,
            child: Text(title),
          ),
          Positioned(
            top: 0,
            right: 0,
            bottom: 0,
            child:Container(
                padding: EdgeInsets.fromLTRB(22, 5, 22, 5),
                alignment: Alignment.center,
                child: FaIcon(Icons.add,
                    size: responsiveText(18),
                    color: ThemesMode.isDarkMode
                        ? AppColors.textYellow
                        : AppColors.textBlue)),
          ),
          Positioned.fill(
            child: new Material(
                color: Colors.transparent,
                child: new InkWell(
                  borderRadius: BorderRadius.circular(5),
                  onTap: () {
                    FocusScope.of(context).unfocus();
                    onPressed();
                  },
                ))),
        ],
      ),
    );
  }
}
