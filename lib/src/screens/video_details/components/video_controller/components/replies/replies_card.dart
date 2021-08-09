import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:nx_play/src/models/comments/comment_replies.dart';
import 'package:nx_play/src/models/like/like_comment_response.dart';
import 'package:nx_play/src/screens/video_details/components/video_controller/components/icon_text_button.dart';
import 'package:nx_play/src/services/pref_service/shared_pref_service.dart';
import 'package:nx_play/src/services/video_service/video_service.dart';
import 'package:nx_play/src/utils/app_color.dart';
import 'package:nx_play/src/utils/responsive.dart';
import 'package:nx_play/src/utils/themes_mode.dart';
import 'package:timeago/timeago.dart' as timeAgo;

class RepliesCard extends StatefulWidget {
  const RepliesCard({
    Key key,
    @required this.reply,
    @required this.onPressed,
    @required this.onDeletePressed,
  }) : super(key: key);

  final ReplyData reply;
  final VoidCallback onPressed, onDeletePressed;
  @override
  _RepliesCardState createState() => _RepliesCardState(reply);
}

class _RepliesCardState extends State<RepliesCard> {
  final ReplyData reply;
  _RepliesCardState(this.reply);
  int status,  likes,  dislikes;

  @override
  void initState() {
    if ((reply.commentLikes.singleWhere((it) => it.userId == getUserId(),
        orElse: () => null)) != null) {
      status = 1;
    }else if ((reply.commentDislikes.singleWhere((it) => it.userId == getUserId(),
        orElse: () => null)) != null) {
      status = 0;
    }
    likes = reply.commentLikes.length;
    dislikes = reply.commentDislikes.length;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    ThemesMode().init(context);
    Responsive().init(context);

    DateTime time = DateTime.parse(reply.createdAt);

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
        color: ThemesMode.isDarkMode?AppColors.backgroundDark:AppColors.backgroundLight,
        width: Responsive.screenWidth,
        child: Stack(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Padding(
                //   padding: const EdgeInsets.only(left: 15, right: 15),
                //   child: Divider(thickness: 0.5, height: 0.5,),
                // ),
                Container(
                  //width: Responsive.screenWidth-30,
                  padding: EdgeInsets.fromLTRB(30, 15, 15, 7),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        height: 35,
                        width: 35,
                        decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                                color: Colors.grey.withOpacity(0.5),
                                blurRadius: 2,
                                spreadRadius: 2,
                                offset: Offset.zero
                            )
                          ],
                          borderRadius: BorderRadius.circular(5.0),
                          image: DecorationImage(
                            image: NetworkImage(reply.user.avatar),
                          ),
                        ),
                      ),
                      SizedBox(width: 15,),
                      Container(
                        width: Responsive.screenWidth-110,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                                reply.user.name,
                                style:TextStyle(fontSize: 17, fontWeight: FontWeight.bold)
                            ),
                            Text(timeAgo.format(time),
                                style:TextStyle(fontSize: 15)
                            ),
                            SizedBox(height: 8,),
                            Text(
                                reply.commentText,
                                style:TextStyle(fontSize: 15)
                            ),
                            Divider(thickness: 0.5,),
                            Container(
                              padding: EdgeInsets.only(top: 0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  IconTextButtonWidget(icon: likeIcon, iconSize: 14, title: '$likes', onPressed: (){
                                    if(status == null){
                                      setState(() {
                                        likes++;
                                        status = 1;
                                      });
                                      setReplyLike(status);
                                    }else{
                                      if (status == 0) {
                                        setState(() {
                                          dislikes--;
                                          likes++;
                                          status = 1;
                                        });
                                        setReplyLike(status);
                                      } else if (status == 1) {
                                        setState(() {
                                          likes--;
                                          status = null;
                                        });
                                        setReplyLike(1);
                                      }
                                    }
                                  }),
                                  IconTextButtonWidget(icon: dislikeIcon, iconSize: 14, title: '$dislikes', onPressed: (){
                                    if(status == null){
                                      setState(() {
                                        dislikes++;
                                        status = 0;
                                      });
                                      setReplyLike(status);
                                    }else{
                                      if (status == 0) {
                                        setState(() {
                                          dislikes--;
                                          status = null;
                                        });
                                        setReplyLike(0);
                                      } else if (status == 1) {
                                        setState(() {
                                          likes--;
                                          dislikes++;
                                          status = 0;
                                        });
                                        setReplyLike(status);
                                      }
                                    }
                                  }),
                                  Spacer(),
                                  IconTextButtonWidget(icon: FontAwesomeIcons.reply, iconSize: 14, title: 'Reply', onPressed: (){

                                    widget.onPressed();

                                    print('Hello world ----------------------------------------');
                                  }),
                                  reply.user.id == getUserId()?SizedBox(width: 15,):SizedBox(width: 0,),
                                  reply.user.id == getUserId()?IconTextButtonWidget(icon: FontAwesomeIcons.solidTrashAlt, iconSize: 14, title: 'Delete', onPressed: (){
                                    widget.onDeletePressed();
                                  }):SizedBox(width: 0,),
                                ],
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 25, right: 15),
                  child: Divider(thickness: 0.5, height: 0.5,),
                ),
              ],
            ),
            Positioned(
              top: 0,
              left: 14,
              bottom: 0,
              child: VerticalDivider(
                thickness: 3,
                width: 5,
              ),
            ),
          ],
        )
    );
  }

  void setReplyLike(var statusValue) async{
    var requestBody =jsonEncode({'comment_id': reply.id,'status': '$statusValue'});
    debugPrint("Request Data : $requestBody");
    try{
      LikeCommentResponse likeCommentResponse = await VideoServices().postCommentLike(requestBody);
      if(likeCommentResponse != null){
        debugPrint("Returned Status: ${likeCommentResponse.likeData.status}");
      }else{
        debugPrint("Error $likeCommentResponse");
      }
    }catch (e){
      debugPrint("Error $e");
    }
  }

}
