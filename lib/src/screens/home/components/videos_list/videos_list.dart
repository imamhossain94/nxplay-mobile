import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:nx_play/src/models/video/videos.dart';
import 'package:nx_play/src/screens/explore_videos/more_videos.dart';
import 'package:nx_play/src/screens/home/components/videos_list/video.dart';
import 'package:nx_play/src/services/pref_service/shared_pref_service.dart';
import 'package:nx_play/src/utils/app_color.dart';
import 'package:nx_play/src/utils/constant.dart';
import 'package:nx_play/src/utils/themes_mode.dart';
import 'package:page_transition/page_transition.dart';

class VideosList extends StatefulWidget {
  VideosList({Key key, @required this.videos, this.title}) : super(key: key);

  final List<Videos> videos;
  final String title;
  @override
  _VideosListState createState() => _VideosListState(videos, title);
}

class _VideosListState extends State<VideosList> {
  final List<Videos> videos;
  final String title;
  _VideosListState(this.videos, this.title);

  @override
  Widget build(BuildContext context) {
    GestureBinding.instance.resamplingEnabled = true; 
    return Column(
      children: [
        SizedBox(
          height: 20,
        ),
        Row(
          children: [
            SizedBox(
              width: 10,
            ),
            Text(
              title,
              style: TextStyle(
                fontSize: 16,
                color: ThemesMode.isDarkMode
                    ? AppColors.textWhite
                    : AppColors.textBlack,
                fontWeight: FontWeight.bold,
              ),
            ),
            Spacer(),
            FlatButton(
                height: 20,
                onPressed: () {
                  if (getAccessToken() == null) {
                    Navigator.pushNamed(context, AppConstants.rSignInScreen);
                  } else {
                    Navigator.push(
                      context,
                      PageTransition(
                          type: PageTransitionType.rightToLeft,
                          child: MoreVideos(title: title,),
                          inheritTheme: true,
                          ctx: context),
                    );
                  }
                },
                child: Text(
                  "VIEW ALL",
                  textAlign: TextAlign.end,
                  style: TextStyle(
                    fontSize: 12,
                    color: ThemesMode.isDarkMode
                        ? AppColors.textWhite
                        : AppColors.textBlack,
                  ),
                )),
            //SizedBox(width: 8,)
          ],
        ),
        Container(
          height: 280.0,
          padding: EdgeInsets.only(left: 0.0),
          child: ListView.builder(
            itemCount: videos.length,
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              return Padding(
                padding: EdgeInsets.fromLTRB(10, 10, 15, 5),
                child: VideoWidget(video: videos[index], onPressed: (){
                  if (getAccessToken() == null) {
                    Navigator.pushNamed(
                        context, AppConstants.rSignInScreen);
                  } else {

                    Navigator.pushNamed(context, AppConstants.rVideoDetailsScreen, arguments: {'videoId': videos[index].id});

                  }
                }),
              );
            }
          ),
        )
      ],
    );
  }
}
