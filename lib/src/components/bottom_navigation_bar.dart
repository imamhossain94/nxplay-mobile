import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:nx_play/src/services/pref_service/shared_pref_service.dart';
import 'package:nx_play/src/utils/constant.dart';
import 'package:nx_play/src/utils/app_color.dart';
import 'package:nx_play/src/utils/responsive.dart';
import 'package:nx_play/src/utils/themes_mode.dart';

class BottomNavBar extends StatelessWidget {
  const BottomNavBar({
    Key key,
    @required this.selectedMenu,
  }) : super(key: key);

  final String selectedMenu;

  @override
  Widget build(BuildContext context) {
    Responsive().init(context);
    ThemesMode().init(context);

    double height = responsiveHeight(isPotrait() ? 40 : 55);
    double iconSize = responsiveText(isPotrait() ? 22 : 33);

    List<IconData> _iconList = [
      FontAwesomeIcons.home,
      FontAwesomeIcons.search,
      FontAwesomeIcons.cloudDownloadAlt,
      FontAwesomeIcons.userAlt,
    ];

    List<String> _routeList = [
      AppConstants.rHomeScreen,
      AppConstants.rSearchScreen,
      AppConstants.rBrowseScreen,
      AppConstants.rProfileScreen,
    ];

    List<Widget> items = [];

    for (int i = 0; i < _iconList.length; i++) {
      items.add(navItem(_iconList[i], _routeList[i], context, height, iconSize,
          _iconList.length));
    }

    return Container(
      decoration: BoxDecoration(
        color:ThemesMode.isDarkMode?AppColors.backgroundDark:AppColors.backgroundLight,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(.5),
            offset: Offset(0.0, 0.0), //(x,y)
            blurRadius: 1,
          ),
        ],
        borderRadius: BorderRadius.vertical(top: Radius.circular(15)),
        gradient: ThemesMode.isDarkMode
            ? AppColors.navBackgroundColorDark
            : AppColors.navBackgroundColorLight,
      ),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: items,
        ),
      ),
    );
  }

  Widget navItem(
    IconData icon,
    String route,
    BuildContext context,
    double height,
    double iconSize,
    int length,
  ) {
    return Container(
        child: IconButton(
          icon: FaIcon(icon),
          iconSize: iconSize,
          splashRadius: 25,
          color: route == selectedMenu ? AppColors.textWhite : Colors.grey,
          onPressed: () {
            if(route != AppConstants.rHomeScreen &&  getAccessToken() == null){
              Navigator.pushNamed(context, AppConstants.rSignInScreen);
            }else{
              Navigator.pushReplacementNamed(context, route);
            }
          },
        ),
        height: height,
        width: (MediaQuery.of(context).size.width - 24) / length,
        decoration: route == selectedMenu
            ? BoxDecoration(
                borderRadius: BorderRadius.circular(50),
                gradient: ThemesMode.isDarkMode
                    ? AppColors.navItemColorYellow
                    : AppColors.navItemColorBlue,
              )
            : BoxDecoration());
  }
}
