import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:nx_play/src/services/pref_service/shared_pref_service.dart';
import 'package:nx_play/src/utils/app_color.dart';
import 'package:nx_play/src/utils/constant.dart';
import 'package:nx_play/src/utils/responsive.dart';
import 'package:nx_play/src/utils/themes_mode.dart';

class HomeAppBar extends StatelessWidget implements PreferredSizeWidget {
  @override
  Size get preferredSize => const Size.fromHeight(80);

  @override
  Widget build(BuildContext context) {
    Responsive().init(context);
    ThemesMode().init(context);

    return Container(
      padding: EdgeInsets.fromLTRB(15, 8, 15, 8),
      //height: responsiveHeight(80),
      decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(.5),
              offset: Offset(0.0, 0.5), //(x,y)
              blurRadius: 0.5,
            ),
          ],
          //color: Color(0xff000000),
          borderRadius: BorderRadius.vertical(bottom: Radius.circular(15)),
          gradient: ThemesMode.isDarkMode
              ? AppColors.navBackgroundColorDark
              : AppColors.navBackgroundColorLight),
      child: Row(children: [
        Row(children: [
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
              color: ThemesMode.isDarkMode
                  ? Colors.yellow[800]
                  : AppColors.textBlue,
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
        Spacer(),
        Stack(
          children: [
            Container(
              height: 35,
              width: 35,
              decoration: BoxDecoration(
                color:
                    ThemesMode.isDarkMode ? Colors.black45 : Colors.grey[300],
                shape: BoxShape.circle,
                border: Border.all(
                  width: 1.5,
                  color:
                      ThemesMode.isDarkMode ? Colors.black45 : Colors.grey[300],
                ),
              ),
              child: Center(
                child: FaIcon(
                  FontAwesomeIcons.search,
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
                      if (getAccessToken() == null) {
                        Navigator.pushNamed(
                            context, AppConstants.rSignInScreen);
                      } else {
                        Navigator.pushReplacementNamed(
                            context, AppConstants.rSearchScreen);
                      }
                    },
                  )),
            ),
          ],
        ),
        loadAvater(context),
      ]),
    );
  }

  Widget loadAvater(BuildContext context) {
    if (getAccessToken() != null) {
      return Row(
        children: [
          SizedBox(
            width: 10,
          ),
          Stack(
            children: [
              Container(
                height: 35,
                width: 35,
                decoration: BoxDecoration(
                  color:ThemesMode.isDarkMode ? Colors.black45 : Colors.grey[300],
                  shape: BoxShape.circle,
                  border: Border.all(
                    width: 1.5,
                    color: ThemesMode.isDarkMode
                        ? Colors.black45
                        : Colors.grey[300],
                  ),
                ),
                child: avatarImage(),
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
                        Navigator.pushReplacementNamed(
                            context, AppConstants.rProfileScreen);
                      },
                    )),
              ),
            ],
          )
        ],
      );
    } else {
      return SizedBox(
        width: 0,
      );
    }
  }

  Widget avatarImage() {

    if (getUserAvatar() != null) {
      return CircleAvatar(
        radius: 15.0,
        backgroundImage: NetworkImage(getUserAvatar()),
        backgroundColor: Colors.white,
      );
    } else {
      return Center(
        child: Text(
          AppConstants.textAvatar(),
          style: TextStyle(
            color:
                ThemesMode.isDarkMode ? AppColors.textWhite : AppColors.textBlack,
            fontSize: 14,
            fontWeight: FontWeight.bold,
          ),
        ),
      );
    }
  }

}
