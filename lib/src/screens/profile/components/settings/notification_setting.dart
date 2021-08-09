import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:nx_play/src/services/pref_service/shared_pref_service.dart';
import 'package:nx_play/src/utils/app_color.dart';
import 'package:nx_play/src/utils/responsive.dart';
import 'package:nx_play/src/utils/themes_mode.dart';

class NotificationSettingWidget extends StatefulWidget {
  const NotificationSettingWidget({
    Key key,
    @required this.title,
    @required this.icon,
    @required this.pos,
    this.onValueChanged,
  }) : super(key: key);

  final String title;
  final IconData icon;
  final int pos;
  final ValueChanged<int> onValueChanged;

  @override
  _NotificationSettingWidgetState createState() =>
      new _NotificationSettingWidgetState(
        title,
        icon,
        pos,
        onValueChanged,
      );
}

class _NotificationSettingWidgetState extends State<NotificationSettingWidget> {
  final String title;
  final IconData icon;
  int pos;
  ValueChanged<int> onValueChanged;
  _NotificationSettingWidgetState(
    this.title,
    this.icon,
    this.pos,
    this.onValueChanged,
  );

  @override
  Widget build(BuildContext context) {
    Responsive().init(context);
    ThemesMode().init(context);

    return Container(
      padding: EdgeInsets.only(left: 3, right: 0),
      child: CheckboxListTile(
        title: new Text(
          title,
          style: new TextStyle(fontSize: 18.0),
        ),
        onChanged: pos == 0 || getReceivedNotification() == true
            ? (bool value) {
                setState(() {
                  onValueChanged(pos);
                  if (pos == 0) {
                    if (value == true) {
                      setReceivedNotification(value);
                      setVideosNotification(false);
                    } else {
                      setReceivedNotification(value);
                      setVideosNotification(value);
                    }
                  } else if (pos == 1) {
                    if (value == true && getReceivedNotification() == true) {
                      setVideosNotification(value);
                    } else {
                      setVideosNotification(value);
                    }
                  }
                });
              }
            : null,
        checkColor: AppColors.textWhite,
        activeColor:
            ThemesMode.isDarkMode ? Colors.yellow[800] : AppColors.textBlue,
        value: pos == 0
            ? getReceivedNotification()
            : getReceivedNotification() == true
                ? getVideosNotification()
                : false,
        secondary: FaIcon(
          icon,
          size: 18,
          color: pos == 0 || getReceivedNotification() == true
              ? ThemesMode.isDarkMode
                  ? AppColors.textWhite
                  : AppColors.textBlack
              : ThemesMode.isDarkMode
                  ? Colors.grey[500]
                  : Colors.grey[400],
        ),
      ),
    );
  }
}
