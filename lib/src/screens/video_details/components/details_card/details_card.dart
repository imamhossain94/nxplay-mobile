import 'package:flutter/material.dart';
import 'package:nx_play/src/models/single_video/single_video.dart';
import 'package:nx_play/src/utils/app_color.dart';
import 'package:nx_play/src/utils/responsive.dart';
import 'package:nx_play/src/utils/themes_mode.dart';

class DetailsCardWidget extends StatelessWidget {
  const DetailsCardWidget({
    Key key,
    @required this.video,
  }) : super(key: key);

  final SingleVideo video;

  @override
  Widget build(BuildContext context) {
    ThemesMode().init(context);
    Responsive().init(context);
    return Container(
      color:
          ThemesMode.isDarkMode ? AppColors.primaryDark : AppColors.textWhite,
      padding: EdgeInsets.fromLTRB(15, 15, 15, 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          items('Actors:  ', video.actors.toString().replaceAll('\[', '').replaceAll('\]', '')),
          items('Directors: ', video.directors.toString().replaceAll('\[', '').replaceAll('\]', '')),
          items('Country: ', video.country.toString().replaceAll('\[', '').replaceAll('\]', '')),
          items('Release Year:  ', video.year.toString().replaceAll('\[', '').replaceAll('\]', '')),
        ],
      ),
    );
  }

  Widget items(String title, String data) {
    return Container(
      padding:EdgeInsets.fromLTRB(0, 5, 0, 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 130,
            child: Text(
              title,
              style: TextStyle(
                fontSize: 18,
                color: ThemesMode.isDarkMode
                    ? AppColors.textWhite
                    : AppColors.textBlack,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Flexible(
            child: Padding(
              padding: const EdgeInsets.only(top:4),
              child: Text(
                '$data.',
                style: TextStyle(
                  fontSize: 14,
                  color: ThemesMode.isDarkMode
                      ? AppColors.textWhite
                      : AppColors.textBlack,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
