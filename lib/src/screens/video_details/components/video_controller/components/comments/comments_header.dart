import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:nx_play/src/screens/video_details/components/video_controller/components/icon_button.dart';
import 'package:nx_play/src/utils/responsive.dart';
import 'package:nx_play/src/utils/themes_mode.dart';
import 'package:nx_play/src/utils/app_color.dart';

class CommentsHeader extends StatelessWidget {
  final title;
  const CommentsHeader({Key key, @required this.title}):super(key: key);

  @override
  Widget build(BuildContext context) {
    ThemesMode().init(context);
    Responsive().init(context);

    return Container(
      padding: EdgeInsets.fromLTRB(15, 8, 15, 8),
      decoration: BoxDecoration(
          color: ThemesMode.isDarkMode?AppColors.textBlack:AppColors.textWhite,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 3,
              blurRadius: 3,
              offset: Offset(0, 0.5), // changes position of shadow
            ),
          ]
      ),
      child: Row(
        children: [
          Text(
              title,
              style:TextStyle(color: ThemesMode.isDarkMode?AppColors.textYellow:AppColors.textBlue, fontSize: 18, fontWeight: FontWeight.bold)
          ),
          Spacer(),
          Container(
              decoration: BoxDecoration(
                  color: ThemesMode.isDarkMode?AppColors.backgroundDark:AppColors.backgroundLight,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 0.1,
                      blurRadius: 0.1,
                      offset: Offset(0, 0.1), // changes position of shadow
                    ),
                  ]
              ),
              child: IconButtonWidget(onPressed: () { Navigator.pop(context); }, icon: FontAwesomeIcons.times, iconSize: 16,)
          ),
        ],
      ),
    );
  }
}
