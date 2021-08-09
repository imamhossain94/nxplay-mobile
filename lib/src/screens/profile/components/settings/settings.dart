import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:nx_play/src/screens/profile/components/settings/notification_setting.dart';
import 'package:nx_play/src/screens/profile/components/settings/themes_setting.dart';
import 'package:nx_play/src/screens/profile/components/settings/video_player_setting.dart';
import 'package:nx_play/src/utils/app_color.dart';
import 'package:nx_play/src/utils/responsive.dart';
import 'package:nx_play/src/utils/themes_mode.dart';

class SettingWidget extends StatefulWidget {
  @override
  _SettingWidgetState createState() => new _SettingWidgetState();
}

class _SettingWidgetState extends State<SettingWidget> {
  int selectedTheme, selectedNotification, selectedVideo;
  bool isThemesTileExpanded = false;
  bool isNotificationTileExpanded = false;
  bool isVideoTileExpanded = false;

  @override
  Widget build(BuildContext context) {
    Responsive().init(context);
    ThemesMode().init(context);
    List<Widget> themesItemList = [
      ThemesSettingWidget(
        onValueChanged: (v) {
          setState(() {
            selectedTheme = v;
          });
        },
        title: 'System Defalut',
        icon: FontAwesomeIcons.cog,
        pos: 0,
      ),
      ThemesSettingWidget(
        onValueChanged: (v) {
          setState(() {
            selectedTheme = v;
          });
        },
        title: 'Light Theme',
        icon: FontAwesomeIcons.solidSun,
        pos: 1,
      ),
      ThemesSettingWidget(
        onValueChanged: (v) {
          setState(() {
            selectedTheme = v;
          });
        },
        title: 'Dark Theme',
        icon: FontAwesomeIcons.solidMoon,
        pos: 2,
      ),
    ];

    List<Widget> notificationItemList = [
      NotificationSettingWidget(
        onValueChanged: (v) {
          setState(() {
            selectedNotification = v;
          });
        },
        title: 'Receive Notification',
        icon: FontAwesomeIcons.exclamationTriangle,
        pos: 0,
      ),
      NotificationSettingWidget(
        onValueChanged: (v) {
          setState(() {
            selectedNotification = v;
          });
        },
        title: 'Videos Notification',
        icon: FontAwesomeIcons.bullhorn,
        pos: 1,
      ),
    ];

    List<Widget> videoItemList = [
      VideoPlayerSettingWidget(
        onValueChanged: (v) {
          setState(() {
            selectedVideo = v;
          });
        },
        title: 'Auto Play',
        icon: FontAwesomeIcons.forward,
        pos: 0,
      ),
      VideoPlayerSettingWidget(
        onValueChanged: (v) {
          setState(() {
            selectedVideo = v;
          });
        },
        title: 'Picture In Picture',
        icon: FontAwesomeIcons.photoVideo,
        pos: 1,
      ),
      VideoPlayerSettingWidget(
        onValueChanged: (v) {
          setState(() {
            selectedVideo = v;
          });
        },
        title: 'Video Looping',
        icon: FontAwesomeIcons.infinity,
        pos: 2,
      ),
    ];

   return Container(
        child: Column(
        children: [
          settingsTile(0,'Themes', FontAwesomeIcons.palette,
              isThemesTileExpanded,
              themesItemList),
          settingsTile(1,'Notification', FontAwesomeIcons.solidBell,
              isNotificationTileExpanded,
              notificationItemList),
          settingsTile(2, 'Video Player', FontAwesomeIcons.video,
              isVideoTileExpanded,
              videoItemList),
        ],
      ));
   }

  Widget settingsTile(int position,
      String title, IconData icon, bool isExpanded, List<Widget> item) {
    return Container(
        child: ExpansionTile(
      key: GlobalKey(),
      title: Text(
        title,
        style: TextStyle(
          color:
              ThemesMode.isDarkMode ? AppColors.textWhite : AppColors.textBlack,
          fontSize: 20.0,
          fontWeight: FontWeight.bold,
        ),
      ),
      backgroundColor:
          ThemesMode.isDarkMode ? AppColors.textBlack : AppColors.textWhite,
      leading: FaIcon(
        icon,
        size: 24,
        color:
            ThemesMode.isDarkMode ? AppColors.textWhite : AppColors.textBlack,
      ),
      initiallyExpanded: isExpanded,
      onExpansionChanged: (value) {
        if(position==0){
          isThemesTileExpanded = value;
        }else if(position==1){
          isNotificationTileExpanded = value;
        }else if(position==2){
          isVideoTileExpanded = value;
        }
        
      },
      children: <Widget>[
        Column(
          children: item,
        )
      ],
    ));
  }

  //--------------------------------

}
