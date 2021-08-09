import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:nx_play/src/models/like/like_video_response.dart';
import 'package:nx_play/src/models/single_video/single_video.dart';
import 'package:nx_play/src/screens/video_details/components/video_controller/comments_sheet.dart';
import 'package:nx_play/src/screens/video_details/components/video_controller/components/icon_button.dart';
import 'package:nx_play/src/screens/video_details/components/video_controller/components/icon_text_button.dart';
import 'package:nx_play/src/screens/video_details/components/video_controller/components/reviews/review_section.dart';
import 'package:nx_play/src/services/downloader_service/downloader_service.dart';
import 'package:nx_play/src/services/pref_service/shared_pref_service.dart';
import 'package:nx_play/src/services/video_service/video_service.dart';
import 'package:nx_play/src/utils/app_color.dart';
import 'package:nx_play/src/utils/constant.dart';
import 'package:nx_play/src/utils/responsive.dart';
import 'package:nx_play/src/utils/themes_mode.dart';

class VideoControlListWidget extends StatefulWidget {
  const VideoControlListWidget({
    Key key,
    @required this.video,
  }) : super(key: key);

  final SingleVideo video;
  @override
  _VideoControlListWidgetState createState() => _VideoControlListWidgetState(video);
}

class _VideoControlListWidgetState extends State<VideoControlListWidget> {
  final SingleVideo video;
  _VideoControlListWidgetState(this.video);
  int status, likes, dislikes;

  @override
  void initState() {
    if(video.likeStatus != null){
      status = video.likeStatus;
    }
    likes = video.likes;
    dislikes = video.dislikes;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ThemesMode().init(context);
    Responsive().init(context);

    IconData likeIcon, dislikeIcon;

    if(status == null){
      likeIcon = FontAwesomeIcons.thumbsUp;
      dislikeIcon = FontAwesomeIcons.thumbsDown;
    }else{
      if (status == 0) {
        likeIcon = FontAwesomeIcons.thumbsUp;
        dislikeIcon = FontAwesomeIcons.solidThumbsDown;
      } else if (status == 1) {
        likeIcon = FontAwesomeIcons.solidThumbsUp;
        dislikeIcon = FontAwesomeIcons.thumbsDown;
      }
    }

    return Container(
        color: ThemesMode.isDarkMode
            ? AppColors.primaryDark
            : AppColors.backgroundLight,
        height: 40,
        child: Row(
          //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              width: 8,
            ),
            IconTextButtonWidget(icon: likeIcon, iconSize: 16, title: AppConstants.numberFormatter('$likes'), onPressed:() {
              //(status == 1)?setLike(null):setLike(1);
              if(status == null){
                setState(() {
                  likes++;
                  status = 1;
                });
                setLike(status);
              }else{
                if (status == 0) {
                  setState(() {
                    dislikes--;
                    likes++;
                    status = 1;
                  });
                  setLike(status);
                } else if (status == 1) {
                  setState(() {
                    likes--;
                    status = null;
                  });
                  setLike(1);
                }
              }
            }),
            IconTextButtonWidget(icon: dislikeIcon, iconSize: 16, title: AppConstants.numberFormatter('$dislikes'), onPressed: () {
              //(status == 0)?setLike(null):setLike(0);
              if(status == null){
                setState(() {
                  dislikes++;
                  status = 0;
                });
                setLike(status);
              }else{
                if (status == 0) {
                  setState(() {
                    dislikes--;
                    status = null;
                  });
                  setLike(0);
                } else if (status == 1) {
                  setState(() {
                    likes--;
                    dislikes++;
                    status = 0;
                  });
                  setLike(status);
                }
              }
            }),
            Spacer(),
            IconButtonWidget(icon: FontAwesomeIcons.solidCommentDots, iconSize: 16, onPressed: () {
              Scaffold.of(context).showBottomSheet<void>(
                (BuildContext context) {
                  return CommentBottomSheet(video: video,);
                },
              );
            }),
            IconButtonWidget(icon: FontAwesomeIcons.solidStar, iconSize: 16, onPressed: () {
              Scaffold.of(context).showBottomSheet<void>(
                    (BuildContext context) {
                  return ReviewsSection(video: video,);
                },
              );
            }),
            IconButtonWidget(icon: FontAwesomeIcons.download, iconSize: 16, onPressed: () {
              DownloaderService().downloadVideo(video.video, video.title);
            }),
            SizedBox(
              width: 8,
            ),
          ],
        ));
  }

  void setLike(var statusValue) async{
    var requestBody =jsonEncode({'video_id': video.id, 'user_id': getUserId(), 'status': statusValue});
    debugPrint("Request Data : $requestBody");
    try{
      LikeVideoResponse likeVideoResponse = await VideoServices().postVideoLike(requestBody);
      if(likeVideoResponse != null){
        debugPrint("Returned Status: ${likeVideoResponse.likeData.status}");
        // setState(() {
        //   status = likeVideoResponse.likeData.status;
        //   likes = likeVideoResponse.likeData.likes;
        //   dislikes = likeVideoResponse.likeData.dislikes;
        // });
      }else{
        debugPrint("Error $likeVideoResponse");
      }
    }catch (e){
      debugPrint("Error $e");
    }
  }

}
