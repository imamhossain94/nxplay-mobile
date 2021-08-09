import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:nx_play/src/models/video/get_more_videos.dart';
import 'package:nx_play/src/utils/app_color.dart';
import 'package:nx_play/src/utils/responsive.dart';
import 'package:nx_play/src/utils/themes_mode.dart';

class VideoTileWidget extends StatelessWidget {
  const VideoTileWidget({Key key, @required this.videosData, this.onPressed})
      : super(key: key);

  final VideosData videosData;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    ThemesMode().init(context);
    Responsive().init(context);
    String posterUrl = DotEnv().env['POSTER_URL'];
    double height = Responsive.screenWidth / 5.5 + Responsive.screenWidth / 6;
    double width = Responsive.screenWidth;

    return Stack(
      children: [
        Card(
          color: ThemesMode.isDarkMode?AppColors.textBlack:AppColors.textWhite,
          elevation: 5,
          child: Container(
            height: height,
            width: Responsive.screenWidth,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: (width / 3) - (width / 10),
                  height: height,
                  margin: EdgeInsets.fromLTRB(8, 8, 15, 8),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(5.0)),
                    shape: BoxShape.rectangle,
                    image: new DecorationImage(
                        fit: BoxFit.cover, image: NetworkImage('$posterUrl${videosData.poster}')),
                  ),
                ),
                Container(
                  width: Responsive.screenWidth-155,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(videosData.title, maxLines:1, overflow: TextOverflow.ellipsis, style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),),
                      Flexible(flex:1,child: Text(videosData.description, maxLines:3, overflow: TextOverflow.ellipsis, style: TextStyle(fontSize: 16.5, ))),
                      Container(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                                videosData.imdbRating,
                                style:TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: ThemesMode.isDarkMode?AppColors.textYellow:AppColors.textBlue,)
                            ),
                            SizedBox(width: 10,),
                            RatingBarIndicator(
                              rating: double.parse(videosData.imdbRating)/2,
                              itemBuilder: (context, index) => Icon(
                                Icons.star,
                                color: ThemesMode.isDarkMode?AppColors.textYellow:AppColors.textBlue,
                              ),
                              unratedColor: AppColors.textGrey,
                              itemCount: 5,
                              itemSize: 16.5,
                              direction: Axis.horizontal,
                            ),
                            Spacer(),
                            FaIcon(
                              FontAwesomeIcons.eye,
                              size: 16.5,
                            ),
                            SizedBox(width: 5,),
                            Text(videosData.views.toString())
                          ],
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
        Positioned.fill(
            child: Material(
            color: Colors.transparent,
              child: InkWell(
                onTap: (){
                onPressed();
                },
                highlightColor: Colors.grey.withOpacity(0.1),
                splashColor: Colors.grey.withOpacity(0.1),
                borderRadius: BorderRadius.all(Radius.circular(6.0)),
              )
          )
        )
      ],
    );
  }
}
