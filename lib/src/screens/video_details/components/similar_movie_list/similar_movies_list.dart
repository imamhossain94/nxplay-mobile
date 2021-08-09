import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:nx_play/src/models/single_video/single_video.dart';
import 'package:nx_play/src/utils/app_color.dart';
import 'package:nx_play/src/utils/responsive.dart';
import 'package:nx_play/src/utils/themes_mode.dart';

class SimilarMovieListWidget extends StatelessWidget {
  final Function(int) onPressed;
  const SimilarMovieListWidget({
    Key key,
    @required this.video,
    @required this.onPressed,
  }) : super(key: key);

  final SingleVideo video;

  @override
  Widget build(BuildContext context) {
    ThemesMode().init(context);
    Responsive().init(context);

    double height = Responsive.screenWidth / 2;

    return Container(
      padding:EdgeInsets.only(bottom: 5),
      width: Responsive.screenWidth,
      color: ThemesMode.isDarkMode ? AppColors.textBlack : AppColors.textWhite,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(15, 20, 10, 15),
            child: Text(
                "Similar",
                style: TextStyle(
                  fontSize: 18,
                  color: ThemesMode.isDarkMode
                      ? AppColors.textWhite
                      : AppColors.textBlack,
                  fontWeight: FontWeight.bold,
                ),
            ),
          ),
          Container(
            height: height+15,
            padding: EdgeInsets.only(left: 10.0),
            child: ListView.builder(
              itemCount: video.similarVideo.length,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                return videoWidget(video.similarVideo[index]);
              }
            ),
          ),
        ],
      ),
    );
  }

  Widget videoWidget(SimilarVideo similarVideo) {
    String posterUrl = DotEnv().env['POSTER_URL'];
    double height = Responsive.screenWidth / 2;
    double width = Responsive.screenWidth;
    return Container(
      padding: EdgeInsets.only(left:7.5,top:10, bottom: 15, right: 7.5),
      child: Column(
        children: [
          Stack(
            children: [
              Container(
                  width: (width / 2) - (width / 5),
                  height: height - 32,
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
                        image: NetworkImage("$posterUrl${similarVideo.poster}")),
                  )),
              Positioned(
                bottom: 8,
                left: 8,
                child: Container(
                  height: 25,
                  width: 25,
                  decoration: BoxDecoration(
                    border: Border.all(width: 1, color: AppColors.textWhite),
                    shape: BoxShape.circle,
                    color: AppColors.backgroundDark.withOpacity(0.5),
                  ),
                  child: Center(
                    child: Text(similarVideo.imdbRating.toString(),
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 8,
                          color: AppColors.textWhite,
                        )),
                  ),
                ),
              ),
              Positioned(
                left: 35,
                bottom: 12.5,
                child: RatingBarIndicator(
                  rating: double.parse(similarVideo.imdbRating)/2,
                  itemBuilder: (context, index) => Icon(
                    Icons.star,
                    color: AppColors.textYellow,
                  ),
                  unratedColor: AppColors.textGrey,
                  itemCount: 5,
                  itemSize: 14.0,
                  direction: Axis.horizontal,
                ),
              ),
              Positioned.fill(
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    onTap: (){
                      onPressed(similarVideo.id);
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
            width: (width / 2) - (width / 5),
            padding: EdgeInsets.only(top:5),
            child: Text(
              similarVideo.title,
              textAlign: TextAlign.center,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: 14,
                fontWeight:FontWeight.bold,
                color: ThemesMode.isDarkMode
                    ? AppColors.textWhite
                    : AppColors.textBlack,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
