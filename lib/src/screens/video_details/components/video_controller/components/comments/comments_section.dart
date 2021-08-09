
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:nx_play/src/models/comments/video_comment.dart';
import 'package:nx_play/src/models/single_video/single_video.dart';
import 'package:nx_play/src/screens/video_details/components/video_controller/components/comments/comment_card.dart';
import 'package:nx_play/src/screens/video_details/components/video_controller/components/comments/comments_header.dart';
import 'package:nx_play/src/screens/video_details/components/video_controller/components/sheet_text_field.dart';
import 'package:nx_play/src/services/video_service/video_service.dart';
import 'package:nx_play/src/utils/app_color.dart';
import 'package:nx_play/src/utils/app_plugin.dart';
import 'package:nx_play/src/utils/responsive.dart';
import 'package:nx_play/src/utils/themes_mode.dart';

class CommentsSection extends StatefulWidget {
  final SingleVideo video;
  final ValueChanged<CommentsData> onValueChanged;
  const CommentsSection({
    Key key,
    @required this.video,
    @required this.onValueChanged
  }) : super(key: key);
  @override
  _CommentsSectionState createState() => _CommentsSectionState(video);
}

class _CommentsSectionState extends State<CommentsSection> {
  SingleVideo video;
  VideoComments videoComments;
  List<CommentsData> commentData = [];
  _CommentsSectionState(this.video);

  int page =1 , totalComments = 0;
  bool initialLoading = true, loadOtherComment = false;

  TextEditingController textController;
  ScrollController _controller;

  @override
  void initState() {
    getComment(1);
    textController  = TextEditingController();
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
    double height = Responsive.screenHeight -
        ((width / 3.55) + (width / 3.55)) -
        (MediaQuery
            .of(context)
            .padding
            .bottom + 32) - MediaQuery
        .of(context)
        .viewInsets
        .bottom;

    return Stack(
      children: [
        Container(
          color: ThemesMode.isDarkMode ? AppColors.textBlack : AppColors
              .textWhite,
          width: width,
          height: height,
        ),
        Positioned(
          top: 1,
          left: 0,
          right: 0,
          child: CommentsHeader(
            title: 'Comments  ... ${totalComments != 0 ? totalComments : ''}',),
        ),
        Positioned.fill(
          top: 50,
          left: 0,
          right: 0,
          bottom: 48,
          child: _paginationView(),
        ),
        Positioned(
          left: 0,
          right: 0,
          bottom: 0,
          child: SheetTextField(hint: 'Type your comment...', autoFocus: false, controller: textController, onPressed: () {
            String commentMessage = textController.text;
            print(commentMessage);
            if(commentMessage.isNotEmpty){
              setState(() {
                loadOtherComment = true;
              });
              postComment(commentMessage);
            }else{
              AppPlugin().flushInfo(context, 'Comment may not empty');
            }
          }),
        ),
        loadOtherComment == true?linerProgressTextField():Text(''),
      ],
    );
  }

  Widget _paginationView(){
    return initialLoading == false? NotificationListener<ScrollNotification>(
      onNotification: (scrollState) {
        if (!loadOtherComment && scrollState.metrics.pixels == scrollState.metrics.maxScrollExtent) {
          if(videoComments.lastPage > page){
            page++;
            setState(() {
              loadOtherComment = true;
            });
            getComment(page);
          }
        }
        return false;
      },
      child: ListView.builder(
        itemCount: commentData.length,
        controller: _controller,
        itemBuilder: (context, index) {
        return CommentCard(
          key: Key(UniqueKey().toString()),
          comment: commentData[index],
          onPressed: () {
            widget.onValueChanged(commentData[index]);
          print('Comments Section');
          }, onDeletePressed: (){
            setState(() {
              loadOtherComment = true;
            });
            deleteComment(commentData[index].id, index);
            print('Comments Section delete');
          }
          );
        },
      ),
    ) :
    Center(
      child: SpinKitFadingCircle(
        color: ThemesMode.isDarkMode ? Colors.yellow[800] : AppColors.textBlue,
        size: 30.0,
      ),
    );
  }

  void getComment(int page) async{
    var response = await VideoServices().getVideoComments(video.id, page);
    if(response != null){
      setState(() {
        videoComments = response.videoComments;
        commentData.addAll(response.videoComments.commentsData);
        totalComments += response.videoComments.commentsData.length;
        loadOtherComment = initialLoading = false;
      });
      if(page == 1){
        Future.delayed(Duration(seconds: 1), () {
          _controller.animateTo(0, curve: Curves.linear,
              duration: Duration(milliseconds: 500));
        });
      }
    }else{
      setState(() {
        loadOtherComment = initialLoading = false;
      });
    }
  }

  void postComment(String commentText) async {
    var response = await VideoServices().postVideoComments(video.id, commentText);
    if (response != null) {
      commentData.clear();
      textController.clear();
      totalComments = 0;
      page = 1;
      getComment(page);
    }else{
      setState(() {
        loadOtherComment = false;
      });
    }
  }

  void deleteComment(int commentId, int index) async{
    setState(() {
      commentData.removeAt(index);
    });
    var response = await VideoServices().removeVideoComments(commentId);
    if(response != null){
      commentData.clear();
      totalComments = 0;
      page = 1;
      getComment(page);
    }else{
      setState(() {
        loadOtherComment = false;
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