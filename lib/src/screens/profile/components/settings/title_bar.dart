import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:nx_play/src/utils/app_color.dart';
import 'package:nx_play/src/utils/responsive.dart';
import 'package:nx_play/src/utils/themes_mode.dart';

class TitleBarWidget extends StatelessWidget {
  const TitleBarWidget({Key key, @required this.title, @required this.icon, @required this.onPressed})
      : super(key: key);
  final String title;
  final IconData icon;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    ThemesMode().init(context);
    Responsive().init(context);
    return Container(
      color:ThemesMode.isDarkMode?AppColors.textBlack:AppColors.textWhite,
      padding: EdgeInsets.fromLTRB(15, 15, 15, 15),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            title.toUpperCase(),
            style: TextStyle(
              fontSize: 16,
              color: ThemesMode.isDarkMode
                  ? AppColors.textWhite
                  : AppColors.textBlack,
              fontWeight: FontWeight.bold,
            ),
          ),
          Spacer(),
          Stack(
            children: [
              Container(
                height: 35,
                width: 35,
                decoration: BoxDecoration(
                  color:
                      ThemesMode.isDarkMode ? Colors.black : Colors.grey[300],
                  shape: BoxShape.circle,
                  border: Border.all(
                    width: 1.5,
                    color:
                        ThemesMode.isDarkMode ? Colors.black12 : Colors.grey[300],
                  ),
                ),
                child: Center(
                  child: FaIcon(
                    icon,
                    color: ThemesMode.isDarkMode
                        ? AppColors.textWhite
                        : AppColors.textBlack,
                    size: 14,
                  ),
                ),
              ),
              Positioned.fill(
                child: Material(
                    color: Colors.transparent,
                    child: new InkWell(
                      highlightColor: ThemesMode.isDarkMode
                          ? Colors.black45.withOpacity(.5)
                          : Colors.grey[300].withOpacity(.5),
                      borderRadius: BorderRadius.circular(17.5),
                      onTap: () {
                        onPressed();
                      },
                    )),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
