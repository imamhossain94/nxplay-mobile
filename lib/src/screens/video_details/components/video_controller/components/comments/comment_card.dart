import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:nx_play/src/models/comments/video_comment.dart';
import 'package:nx_play/src/models/like/like_comment_response.dart';
import 'package:nx_play/src/screens/video_details/components/video_controller/components/icon_text_button.dart';
import 'package:nx_play/src/services/pref_service/shared_pref_service.dart';
import 'package:nx_play/src/services/video_service/video_service.dart';
import 'package:nx_play/src/utils/app_color.dart';
import 'package:nx_play/src/utils/responsive.dart';
import 'package:nx_play/src/utils/themes_mode.dart';
import 'package:timeago/timeago.dart' as timeAgo;

class CommentCard extends StatefulWidget {
  const CommentCard({
    Key key,
    @required this.comment,
    @required this.onPressed,
    @required this.onDeletePressed,
  }) : super(key: key);

  final CommentsData comment;
  final VoidCallback onPressed, onDeletePressed;
  @override
  _CommentCardState createState() => _CommentCardState(comment);
}

class _CommentCardState extends State<CommentCard> {
  final CommentsData comment;
  _CommentCardState(this.comment);
  int status,  likes,  dislikes, replies;

  @override
  void initState() {

    if ((comment.commentLikes.singleWhere((it) => it.userId == getUserId(),
        orElse: () => null)) != null) {
      status = 1;
    }else if ((comment.commentDislikes.singleWhere((it) => it.userId == getUserId(),
        orElse: () => null)) != null) {
      status = 0;
    }
    likes = comment.commentLikesCount;
    dislikes = comment.commentDislikesCount;
    replies = comment.repliesCount;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    ThemesMode().init(context);
    Responsive().init(context);

    DateTime time = DateTime.parse(comment.createdAt);

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
        width: Responsive.screenWidth,
        color: ThemesMode.isDarkMode?AppColors.textBlack:AppColors.textWhite,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              margin: EdgeInsets.fromLTRB(15, 15, 15, 0),
              //width: Responsive.screenWidth-30,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: 40,
                    width: 40,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5.0),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          blurRadius: 2,
                          spreadRadius: 2,
                          offset: Offset.zero
                        )
                      ],
                      image: DecorationImage(
                        image: NetworkImage(comment.user.avatar),
                      ),
                    ),
                  ),
                  SizedBox(width: 15,),
                  Container(
                    width: Responsive.screenWidth-95,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                            comment.user.name,
                            style:TextStyle(fontSize: 18, fontWeight: FontWeight.bold)
                        ),
                        Text(timeAgo.format(time),
                            style:TextStyle(fontSize: 16)
                        ),
                        SizedBox(height: 10,),
                        Text(
                            comment.commentText,
                            style:TextStyle(fontSize: 16)
                        ),
                        Divider(thickness: 0.5,),
                        Container(
                          padding: EdgeInsets.only(top: 5),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              IconTextButtonWidget(icon: likeIcon, iconSize: 16, title: '$likes', onPressed: (){
                                if(status == null){
                                  setState(() {
                                    likes++;
                                    status = 1;
                                  });
                                  setCommentsLike(status);
                                }else{
                                  if (status == 0) {
                                    setState(() {
                                      dislikes--;
                                      likes++;
                                      status = 1;
                                    });
                                    setCommentsLike(status);
                                  } else if (status == 1) {
                                    setState(() {
                                      likes--;
                                      status = null;
                                    });
                                    setCommentsLike(1);
                                  }
                                }
                              }),
                              IconTextButtonWidget(icon: dislikeIcon, iconSize: 16, title: '$dislikes', onPressed: (){
                                if(status == null){
                                  setState(() {
                                    dislikes++;
                                    status = 0;
                                  });
                                  setCommentsLike(status);
                                }else{
                                  if (status == 0) {
                                    setState(() {
                                      dislikes--;
                                      status = null;
                                    });
                                    setCommentsLike(0);
                                  } else if (status == 1) {
                                    setState(() {
                                      likes--;
                                      dislikes++;
                                      status = 0;
                                    });
                                    setCommentsLike(status);
                                  }
                                }
                              }),
                              Spacer(),
                              IconTextButtonWidget(icon: FontAwesomeIcons.reply, iconSize: 16, title: '$replies Reply', onPressed: (){
                                widget.onPressed();
                                print('Comment Card reply -----');
                              }),
                              comment.user.id == getUserId()?SizedBox(width: 15,):SizedBox(width: 0,),
                              comment.user.id == getUserId()?IconTextButtonWidget(icon: FontAwesomeIcons.solidTrashAlt, iconSize: 16, title: 'Delete', onPressed: (){
                                widget.onDeletePressed();
                                print('Comment Card delete -----');
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
              padding: const EdgeInsets.only(top: 15),
              child: Divider(thickness: 5, height: 5,),
            ),
          ],
        )
    );
  }



  void setCommentsLike(var statusValue) async{
    var requestBody =jsonEncode({'comment_id': comment.id,'status': '$statusValue'});
    debugPrint("Request Data : $requestBody");
    try{
      LikeCommentResponse likeCommentResponse = await VideoServices().postCommentLike(requestBody);
      if(likeCommentResponse != null){
        debugPrint("Returned Status: ${likeCommentResponse.likeData.status}");
        // setState(() {
        //   status = likeCommentResponse.likeData.status;
        //   likes = likeCommentResponse.likeData.likes;
        //   dislikes = likeCommentResponse.likeData.dislikes;
        // });
      }else{
        debugPrint("Error $likeCommentResponse");
      }
    }catch (e){
      debugPrint("Error $e");
    }
  }


}
