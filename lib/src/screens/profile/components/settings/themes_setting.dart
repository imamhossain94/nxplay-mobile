import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:nx_play/src/services/pref_service/shared_pref_service.dart';
import 'package:nx_play/src/utils/app_color.dart';
import 'package:nx_play/src/utils/constant.dart';
import 'package:nx_play/src/utils/provider.dart';
import 'package:nx_play/src/utils/responsive.dart';
import 'package:nx_play/src/utils/themes_mode.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemesSettingWidget extends StatefulWidget {
  const ThemesSettingWidget({
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
  _ThemesSettingWidgetState createState() => new _ThemesSettingWidgetState(
        title,
        icon,
        pos,
        onValueChanged,
      );
}

class _ThemesSettingWidgetState extends State<ThemesSettingWidget> {
  final String title;
  final IconData icon;
  int pos;
  ValueChanged<int> onValueChanged;
  _ThemesSettingWidgetState(
    this.title,
    this.icon,
    this.pos,
    this.onValueChanged,
  );
  List themes = AppConstants.themes;
  ThemeNotifier themeNotifier;

  @override
  Widget build(BuildContext context) {
    Responsive().init(context);
    ThemesMode().init(context);
    themeNotifier = Provider.of<ThemeNotifier>(context);

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
            if (value == true) {
              onThemeChanged(themes[pos]);
            }
          });
        },
        checkColor: AppColors.textWhite,
        activeColor:
            ThemesMode.isDarkMode ? Colors.yellow[800] : AppColors.textBlue,
        value: getSavedTheme() == pos?true:false,
        secondary: FaIcon(
          icon,
          size: 18,
          color:
              ThemesMode.isDarkMode ? AppColors.textWhite : AppColors.textBlack,
        ),
      ),
    );
  }

  void onThemeChanged(String value) async {
    var prefs = await SharedPreferences.getInstance();
    if (value == AppConstants.systemDefault) {
      themeNotifier.setThemeMode(ThemeMode.system);
    } else if (value == AppConstants.dark) {
      themeNotifier.setThemeMode(ThemeMode.dark);
    } else {
      themeNotifier.setThemeMode(ThemeMode.light);
    }
    prefs.setString(AppConstants.appTheme, value);
  }
}
