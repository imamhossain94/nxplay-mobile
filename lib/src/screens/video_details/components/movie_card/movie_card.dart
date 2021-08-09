import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:nx_play/src/models/single_video/single_video.dart';
import 'package:nx_play/src/utils/app_color.dart';
import 'package:nx_play/src/utils/responsive.dart';
import 'package:nx_play/src/utils/themes_mode.dart';

class MovieCardWidget extends StatelessWidget {
  const MovieCardWidget({
    Key key,
    @required this.video,
  }) : super(key: key);

  final SingleVideo video;

  @override
  Widget build(BuildContext context) {
    ThemesMode().init(context);
    Responsive().init(context);
    String posterUrl = DotEnv().env['POSTER_URL'];

    return Container(
        padding: EdgeInsets.fromLTRB(15, 15, 10, 15),
        // height: 300,
        color: ThemesMode.isDarkMode ? AppColors.textBlack : AppColors.textWhite,
        child: Column(
          //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                    width: 90.0,
                    height: 130.0,
                    decoration: new BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black,
                          offset: Offset(0.0, 1.0), //(x,y)
                          blurRadius: 6.0,
                        ),
                      ],
                      borderRadius: BorderRadius.all(Radius.circular(5.0)),
                      shape: BoxShape.rectangle,
                      image: new DecorationImage(
                          fit: BoxFit.cover,
                          image: NetworkImage("$posterUrl${video.poster}")),
                    )),
                SizedBox(
                  width: 15,
                ),
                movieDetails(),
              ],
            ),
            SizedBox(
              height: responsiveHeight(20),
            ),
            Text(
              "Description",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: ThemesMode.isDarkMode
                    ? AppColors.textWhite
                    : AppColors.textBlack,
                //fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              height: responsiveHeight(5),
            ),
            Text(
              video.description,
              style: TextStyle(
                fontSize: 14,
                color: ThemesMode.isDarkMode
                    ? AppColors.textWhite
                    : AppColors.textBlack,
              ),
            ),
          ],
        ));
  }

  Widget movieDetails() {
    return Container(
      height: 130,
      width: Responsive.screenWidth - 130,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Flexible(
            child: Text(
              '${video.title} [${video.year}]',
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
              style: TextStyle(
                fontSize: responsiveText(22),
                fontWeight: FontWeight.bold,
                color: ThemesMode.isDarkMode
                    ? AppColors.textWhite
                    : AppColors.textBlack,
              )),
          ),

          _iconText(FontAwesomeIcons.solidEye, '${video.views} views'),
          _iconText(FontAwesomeIcons.solidClock, '${video.runtime}'),
          _iconText(FontAwesomeIcons.coins,
              '${video.boxOffice == 'N/A' || video.boxOffice == null? '0 \$' : ('${video.boxOffice} ${video.boxOffice[0]}'.substring(1))}'),
          _iconText(FontAwesomeIcons.solidStar, '${video.imdbRating}/10'),


        ],
      ),
    );
  }

  Widget _iconText(IconData icon, String title) {
    return Row(
      children: [
        Container(
            height: responsiveText(20),
            width: responsiveText(20),
            child: Center(child: FaIcon(icon, size: 16))),
        SizedBox(
          width: 5,
        ),
        Text(title,
            style: TextStyle(
              fontSize: responsiveText(13),
              color:
                  ThemesMode.isDarkMode ? Colors.grey[600] : Colors.grey[800],
            )),
      ],
    );
  }
}
