import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:nx_play/src/models/comments/comment_replies.dart';
import 'package:nx_play/src/models/comments/video_comment.dart';
import 'package:nx_play/src/models/single_video/single_video.dart';
import 'package:nx_play/src/screens/video_details/components/video_controller/components/comments/comment_card.dart';
import 'package:nx_play/src/screens/video_details/components/video_controller/components/replies/replies_card.dart';
import 'package:nx_play/src/screens/video_details/components/video_controller/components/replies/replies_header.dart';
import 'package:nx_play/src/screens/video_details/components/video_controller/components/sheet_text_field.dart';
import 'package:nx_play/src/services/video_service/video_service.dart';
import 'package:nx_play/src/utils/app_color.dart';
import 'package:nx_play/src/utils/app_plugin.dart';
import 'package:nx_play/src/utils/responsive.dart';
import 'package:nx_play/src/utils/themes_mode.dart';

class RepliesSection extends StatefulWidget {
  final SingleVideo video;
  final VoidCallback onPressed;
  final CommentsData comment;
  const RepliesSection({
    Key key,
    @required this.video,
    @required this.onPressed,
    @required this.comment
  }) : super(key: key);
  @override
  _RepliesSectionState createState() => _RepliesSectionState(video, comment);
}

class _RepliesSectionState extends State<RepliesSection> {
  CommentsData commentsData;
  SingleVideo video;
  CommentReplies commentReplies;
  List<ReplyData> repliesData = [];
  _RepliesSectionState(this.video, this.commentsData);

  int page =1 , totalReplies = 0, repliedToId;
  bool initialLoading = true, loadOtherReplies = false;

  TextEditingController textController;
  ScrollController _controller;

  @override
  void initState() {
    getReplies(1);
    textController  = TextEditingController();
    textController.text = '@${commentsData.user.name} ';
    _controller = ScrollController();
    super.initState();
  }

  @override
  void dispose() {
    textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ThemesMode().init(context);
    Responsive().init(context);
    double width = Responsive.screenWidth;
    double height = Responsive.screenHeight -((width / 3.55) + (width / 3.55)) -
        (MediaQuery.of(context).padding.bottom + 32)-MediaQuery.of(context).viewInsets.bottom;

    return Stack(
      children: [
        Container(
          color: ThemesMode.isDarkMode ? AppColors.textBlack : AppColors.textWhite,
          width: width,
          height: height,
        ),
        Positioned(
          top:1,
          left: 0,
          right: 0,
          child: RepliesHeader(title: 'Replies  ... ${totalReplies!=0?totalReplies:''}', onPressed: (){ widget.onPressed(); },),
        ),
        Positioned.fill(
          top:50,
          left: 0,
          right: 0,
          bottom: 48,
          child: _paginationView(),
        ),
        Positioned(
          left: 0,
          right: 0,
          bottom: 0,
          child: SheetTextField(hint: '@${commentsData.user.name}', autoFocus: false, controller: textController, onPressed: () {
            String replyMessage = textController.text;
            print(replyMessage);
            if(replyMessage.isNotEmpty){
              setState(() {
                loadOtherReplies = true;
              });
              postReply(replyMessage);
            }else{
              AppPlugin().flushInfo(context, 'Comment may not empty');
            }
          }),
        ),
        loadOtherReplies == true?linerProgressTextField():Text(''),
      ],
    );
  }

  Widget _paginationView(){
    return initialLoading == false? NotificationListener<ScrollNotification>(
      onNotification: (scrollState) {
        if (!loadOtherReplies && scrollState.metrics.pixels == scrollState.metrics.maxScrollExtent) {
          if(commentReplies.lastPage > page){
            page++;
            setState(() {
              loadOtherReplies = true;
            });
            getReplies(page);
          }
        }
        return false;
      },
      child: ListView.builder(
        itemCount: repliesData.length+1,
        controller: _controller,
        itemBuilder: (context, index) {
          if(index == 0){
            return CommentCard(
              key: Key(UniqueKey().toString()),
              comment: commentsData,
              onPressed: (){
                textController.text = '@${repliesData[index].user.name} ';

                FocusNode().requestFocus();
              }, onDeletePressed:  (){
              setState(() {
                loadOtherReplies = true;
              });
              deleteComment(commentsData.id, -1);
            },);
          }
          index-=1;
          return RepliesCard(
              key: Key(UniqueKey().toString()),
              reply: repliesData[index],
              onPressed: (){
                textController.text = '@${repliesData[index].user.name}';
                repliedToId = repliesData[index].id;
                FocusNode().requestFocus();
              },
              onDeletePressed: (){
                setState(() {
                  loadOtherReplies = true;
                });
                deleteComment(repliesData[index].id, index);
                print('Comments Section delete');
              }
          );
        },
      )
    ):
    Center(
      child: SpinKitFadingCircle(
        color: ThemesMode.isDarkMode ? Colors.yellow[800] : AppColors.textBlue,
        size: 30.0,
      ),
    );
  }

  void getReplies(int page) async{
    var response = await VideoServices().getCommentReply(commentsData.id, page);
    if(response != null){
      setState(() {
        commentReplies = response.commentReplies;
        repliesData.addAll(response.commentReplies.replyData);
        totalReplies += response.commentReplies.replyData.length;
        loadOtherReplies = initialLoading = false;
      });
      if(page == 1){
        Future.delayed(Duration(seconds: 1), () {
          _controller.animateTo(0, curve: Curves.linear,
              duration: Duration(milliseconds: 500));
        });
      }
    }else{
      setState(() {
        loadOtherReplies = initialLoading = false;
      });
    }
  }

  void postReply(String commentText) async {
    if(repliedToId == null){
      repliedToId = commentsData.id;
    }
    var response = await VideoServices().postCommentReply(video.id , commentsData.id, repliedToId, commentText);
    if (response != null) {
      repliesData.clear();
      textController.clear();
      totalReplies = 0;
      page = 1;
      getReplies(page);
    }else{
      setState(() {
        loadOtherReplies = false;
      });
    }
  }

  void deleteComment(int commentId, int index) async{
    if(index!=-1){
      setState(() {
        repliesData.removeAt(index);
      });
    }

    var response = await VideoServices().removeVideoComments(commentId);
    if(response != null){
      repliesData.clear();
      totalReplies = 0;
      page = 1;
      getReplies(page);
    }else{
      setState(() {
        loadOtherReplies = false;
      });
    }
  }

  Widget linerProgressTextField() {
    return Positioned(
      left:0,
      right: 0,
      bottom: 48,
      child: LinearProgressIndicator(
        minHeight: 2,
        backgroundColor: ThemesMode.isDarkMode
            ? AppColors.textYellow
            : AppColors.textBlue,
        valueColor: AlwaysStoppedAnimation<Color>(Colors.white,),
      ),
    );
  }

}
