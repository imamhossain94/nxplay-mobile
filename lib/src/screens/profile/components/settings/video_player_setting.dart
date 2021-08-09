import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:nx_play/src/services/pref_service/shared_pref_service.dart';
import 'package:nx_play/src/utils/app_color.dart';
import 'package:nx_play/src/utils/responsive.dart';
import 'package:nx_play/src/utils/themes_mode.dart';

class VideoPlayerSettingWidget extends StatefulWidget {
  const VideoPlayerSettingWidget({
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
  _VideoPlayerSettingWidgetState createState() =>
      new _VideoPlayerSettingWidgetState(
        title,
        icon,
        pos,
        onValueChanged,
      );
}

class _VideoPlayerSettingWidgetState extends State<VideoPlayerSettingWidget> {
  final String title;
  final IconData icon;
  int pos;
  ValueChanged<int> onValueChanged;
  _VideoPlayerSettingWidgetState(
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
        onChanged: (bool value) {
          setState(() {
            onValueChanged(pos);
            savVideoConfig(value);
          });
        },
        checkColor: AppColors.textWhite,
        activeColor:
            ThemesMode.isDarkMode ? Colors.yellow[800] : AppColors.textBlue,
        value: isSelected(),
        secondary: FaIcon(
          icon,
          size: 18,
          color:
              ThemesMode.isDarkMode ? AppColors.textWhite : AppColors.textBlack,
        ),
      ),
    );
  }

  bool isSelected() {
    if (pos == 0) {
      return getVideoAutoPlay();
    } else if (pos == 1) {
      return getVideoPictureInPicture();
    } else if (pos == 2) {
      return getVideoLooping();
    } else {
      return false;
    }
  }

  void savVideoConfig(bool value) {
    if (pos == 0) {
      setVideoAutoPlay(value);
    } else if (pos == 1) {
      setVideoPictureInPicture(value);
    } else if (pos == 2) {
      setVideoLooping(value);
    }
  }
}
