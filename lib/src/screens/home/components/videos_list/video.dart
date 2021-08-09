import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:nx_play/src/models/video/videos.dart';
import 'package:nx_play/src/utils/app_color.dart';
import 'package:nx_play/src/utils/responsive.dart';
import 'package:nx_play/src/utils/themes_mode.dart';

class VideoWidget extends StatelessWidget {
  const VideoWidget({Key key, @required this.video, this.onPressed})
      : super(key: key);

  final Videos video;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    ThemesMode().init(context);
    Responsive().init(context);
    String posterUrl = DotEnv().env['POSTER_URL'];

    return Column(
      children: [
        Stack(
          children: [
            Container(
                width: 160.0,
                height: 220.0,
                decoration: new BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black,
                      offset: Offset(0.0, 1.0), //(x,y)
                      blurRadius: 6.0,
                    ),
                  ],
                  borderRadius: BorderRadius.all(Radius.circular(6.0)),
                  shape: BoxShape.rectangle,
                  image: new DecorationImage(
                      fit: BoxFit.cover,
                      image: NetworkImage("$posterUrl${video.poster}")),
                )),
            Positioned(
              bottom: 10,
              left: 10,
              child: Container(
                height: 30,
                width: 30,
                decoration: BoxDecoration(
                  border: Border.all(width: 1, color: AppColors.textWhite),
                  shape: BoxShape.circle,
                  color: AppColors.backgroundDark.withOpacity(0.5),
                ),
                child: Center(
                  child: Text(video.imdbRating.toString(),
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 10,
                        color: AppColors.textWhite,
                      )),
                ),
              ),
            ),
            Positioned(
              left: 47,
              bottom: 17,
              child: RatingBarIndicator(
                rating: double.parse(video.imdbRating)/2,
                itemBuilder: (context, index) => Icon(
                  Icons.star,
                  color: AppColors.textYellow,
                ),
                unratedColor: AppColors.textGrey,
                itemCount: 5,
                itemSize: 15.0,
                direction: Axis.horizontal,
              ),
            ),
            Positioned.fill(
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  onTap: (){
                    onPressed();
                  },
                  highlightColor: Colors.black.withOpacity(0.5),
                  splashColor: Colors.black.withOpacity(0.1),
                  borderRadius: BorderRadius.all(Radius.circular(6.0)),
                ),
              ),
            ),
          ],
        ),
        Container(
          width:160,
          padding: EdgeInsets.only(top:10),
          child: Text(
            video.title,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontSize: 15,
              color: ThemesMode.isDarkMode
                  ? AppColors.textWhite
                  : AppColors.textBlack,
            ),
          ),
        ),
      ],
    );
  }
}
