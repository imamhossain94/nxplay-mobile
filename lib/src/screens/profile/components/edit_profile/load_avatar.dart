import 'package:flutter/material.dart';
import 'package:nx_play/src/services/pref_service/shared_pref_service.dart';
import 'package:nx_play/src/utils/app_color.dart';
import 'package:nx_play/src/utils/themes_mode.dart';

class LoadAvatarWidget extends StatelessWidget {
  final String avatar;
  const LoadAvatarWidget({Key key, @required this.avatar}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    ThemesMode().init(context);
    return avatarImage();
  }

  Widget avatarImage() {
    if (avatar != null) {
      return Container(
          width: 80.0,
          height: 80.0,
          decoration: new BoxDecoration(
            // boxShadow: [
            //   BoxShadow(
            //     //color: Colors.black,
            //     offset: Offset(0.0, 1.0), //(x,y)
            //     blurRadius: 6.0,
            //   ),
            // ],
            borderRadius: BorderRadius.all(Radius.circular(6.0)),
            shape: BoxShape.rectangle,
            image: new DecorationImage(
                fit: BoxFit.cover, image: NetworkImage(getUserAvatar())),
          ));
    } else {
      return Container(
        width: 80.0,
        height: 80.0,
        decoration: new BoxDecoration(
          color:
          ThemesMode.isDarkMode ? Colors.black45 : Colors.grey[300],
          // boxShadow: [
          //   BoxShadow(
          //     color: Colors.black,
          //     offset: Offset(0.0, 1.0), //(x,y)
          //     blurRadius: 0.0,
          //   ),
          // ],
          borderRadius: BorderRadius.all(Radius.circular(6.0)),
          shape: BoxShape.rectangle,
        ),
        child: Center(
          child: Text(
            textAvater(getUserName()),
            style: TextStyle(
              color: ThemesMode.isDarkMode
                  ? AppColors.textWhite
                  : AppColors.textBlack,
              fontSize: 36,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      );
    }
  }

  String textAvater(String text) {
    String name = text != null ? text : "↻";
    var part = name.trim().split(' ');
    return part.length > 1 ? part[0].trim()[0] + part[1].trim()[0] : name;
  }
}
