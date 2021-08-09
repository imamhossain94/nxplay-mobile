import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nx_play/src/models/comments/video_comment.dart';
import 'package:nx_play/src/models/single_video/single_video.dart';
import 'package:nx_play/src/screens/video_details/components/video_controller/components/comments/comments_section.dart';
import 'package:nx_play/src/screens/video_details/components/video_controller/components/replies/replies_section.dart';
import 'package:nx_play/src/utils/responsive.dart';
import 'package:nx_play/src/utils/themes_mode.dart';

class CommentBottomSheet extends StatefulWidget {
  CommentBottomSheet({
    Key key,
    @required this.video,
  }) : super(key: key);
  final SingleVideo video;
  @override
  _CommentBottomSheetState createState() => _CommentBottomSheetState(video);
}

class _CommentBottomSheetState extends State<CommentBottomSheet> {
  SingleVideo video;
  CommentsData commentsData;
  bool isComment;
  _CommentBottomSheetState(this.video);

  @override
  void initState() {
    isComment = true;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ThemesMode().init(context);
    Responsive().init(context);
    // double width = Responsive.screenWidth;
    // double height = Responsive.screenHeight -((width / 3.55) + (width / 3.55)) -
    //     (MediaQuery.of(context).padding.bottom + 32)-MediaQuery.of(context).viewInsets.bottom;

    return isComment==true?CommentsSection(video: video, onValueChanged: (value) {
        setState(() {
          isComment = false;
          commentsData = value;
        });
        print('Comments Sheets $isComment');
      },): RepliesSection(comment: commentsData, video: video, onPressed: (){
        setState(() {
          isComment = true;
        });
        print('Comments Sheets return $isComment');
      },
    );
  }

}


/*
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:nx_play/src/models/comments/video_comment.dart';
import 'package:nx_play/src/models/comments/video_comment_response.dart';
import 'package:nx_play/src/models/single_video/single_video.dart';
import 'package:nx_play/src/screens/video_details/components/video_controller/components/comment_card.dart';
import 'package:nx_play/src/screens/video_details/components/video_controller/components/icon_button.dart';
import 'package:nx_play/src/services/video_service/video_service.dart';
import 'package:nx_play/src/utils/app_color.dart';
import 'package:nx_play/src/utils/responsive.dart';
import 'package:nx_play/src/utils/themes_mode.dart';

class CommentBottomSheet extends StatefulWidget {
  CommentBottomSheet({
    Key key,
    @required this.video,
  }) : super(key: key);
  final SingleVideo video;
  @override
  _CommentBottomSheetState createState() => _CommentBottomSheetState(video);
}

class _CommentBottomSheetState extends State<CommentBottomSheet> {
  SingleVideo video;
  VideoCommentsResponse commentsResponse;
  bool isComment, isLoaded, isAddComment;
  _CommentBottomSheetState(this.video);

  @override
  void initState() {
    isComment = true;
    isLoaded = false;
    isAddComment = true;
    getComments();
    super.initState();
  }

  void refresh(){
    setState(() {
      isComment = false;
    });
  }


  @override
  Widget build(BuildContext context) {
    ThemesMode().init(context);
    Responsive().init(context);
    return isAddComment == true? allComments():editText(FontAwesomeIcons.paperPlane, (){
      setState(() {
        isAddComment = true;
      });
    });
  }

  Widget allComments(){
    double width = Responsive.screenWidth;
    double height = Responsive.screenHeight -((width / 3.55) + (width / 3.55)) -
        (MediaQuery.of(context).padding.bottom + 32);
    //MediaQuery.of(context).viewInsets.bottom;
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
          child: sheetHeader((){Navigator.pop(context);}),
        ),
        isLoaded == true?
        Positioned.fill(
          top:60,
          left: 0,
          right: 0,
          bottom: 45,
          child: ListView.builder(
            itemCount: commentsResponse.comments != null? commentsResponse.comments.length: 0,
            itemBuilder: (context, i) {
              return CommentCard(comment: commentsResponse.comments != null?commentsResponse.comments[i]:VideoComments(),
                onPressed: refresh,
              );
            },
          ),
        ): Positioned.fill(
          child: SpinKitFadingCircle(
            color: ThemesMode.isDarkMode?Colors.yellow[800]:AppColors.textBlue,
            size: 30.0,
          ),
        ),
        Positioned(
          left: 0,
          right: 0,
          bottom: 0,
          child: bottomButton('Add Comment...', (){

            setState(() {
              isAddComment = false;
            });

          }),
        )
      ],
    );
  }

  Widget sheetHeader(VoidCallback onPressed){
    return isComment == true?Container(
      padding: EdgeInsets.fromLTRB(15, 8, 15, 8),
      decoration: BoxDecoration(
          color: ThemesMode.isDarkMode?AppColors.textBlack:AppColors.textWhite,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 0.5,
              blurRadius: 0.5,
              offset: Offset(0, 0.5), // changes position of shadow
            ),
          ]
      ),
      child: Row(
        children: [
          Text(
              'Comments ... ${isLoaded == true? commentsResponse.comments != null? '${commentsResponse.comments.length}': '0': ''}'.toUpperCase(),
              style:TextStyle(color: ThemesMode.isDarkMode?AppColors.textYellow:AppColors.textBlue, fontSize: 18, fontWeight: FontWeight.bold)
          ),
          Spacer(),
          Container(
              decoration: BoxDecoration(
                color: ThemesMode.isDarkMode?AppColors.backgroundDark:AppColors.backgroundLight,
                shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 0.1,
                      blurRadius: 0.1,
                      offset: Offset(0, 0.1), // changes position of shadow
                    ),
                  ]
              ),
              child: IconButtonWidget(onPressed: () { onPressed(); }, icon: FontAwesomeIcons.times,)
          ),
        ],
      ),
    ):Container(
      padding: EdgeInsets.fromLTRB(15, 8, 15, 8),
      decoration: BoxDecoration(
        color: ThemesMode.isDarkMode?AppColors.backgroundDark:AppColors.textWhite,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 0.5,
            blurRadius: 0.5,
            offset: Offset(0, 0.5), // changes position of shadow
          ),
        ]
      ),
      child: Row(
        children: [
          Container(
              decoration: BoxDecoration(
                  color: ThemesMode.isDarkMode?AppColors.backgroundDark:AppColors.backgroundLight,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 0.1,
                      blurRadius: 0.1,
                      offset: Offset(0, 0.1), // changes position of shadow
                    ),
                  ]
              ),
              child: IconButtonWidget(onPressed: () { setState(() {
                isComment = true;
              }); }, icon: FontAwesomeIcons.caretLeft,)
          ),
          SizedBox(width: 10,),
          Text(
              'Replies',
              style:TextStyle(color: ThemesMode.isDarkMode?AppColors.textYellow:AppColors.textBlue, fontSize: 18, fontWeight: FontWeight.bold)
          ),
          Spacer(),
        ],
      ),
    );
  }

  Widget bottomButton(String text, VoidCallback onPressed){
    return Stack(
      children: [
        Container(
          height: 45,
          width: Responsive.screenWidth,
          padding: EdgeInsets.only(left: 15, right: 15),
          decoration: BoxDecoration(
            color: ThemesMode.isDarkMode?AppColors.backgroundDark:AppColors.backgroundLight,
          ),
          child: Column(
            children: [
              Expanded(flex:1, child: Center(child: Text(text,))),
              Divider(thickness: 1, height: 1,)
            ],
          ),
        ),
        Positioned.fill(
          child: new Material(
            color: Colors.transparent,
            child: new InkWell(
              //borderRadius: BorderRadius.circular(5),
              onTap: () {
                onPressed();
              },
            )
          )
        ),
      ]
    );
  }

  Widget editText(IconData icon, VoidCallback onPressed){
    return Container(
      width: Responsive.screenWidth,
      decoration: BoxDecoration(
          color: ThemesMode.isDarkMode?AppColors.textBlack:AppColors.textWhite,
      ),
      child: Stack(
        children: [
          Container(
            width: Responsive.screenWidth,
            child: TextField(
              minLines: 1,
              maxLines: 10,
              autofocus: true,
              autocorrect: false,
              decoration: InputDecoration(
                hintText: 'Type your comment..',
                contentPadding: EdgeInsets.only(left: 20, right: 75),
                filled: true,
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.transparent),
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.transparent),
                ),
                border: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.transparent),
                ),
              ),
            ),
          ),
          Positioned(
            top: 0,
            right: 15,
            bottom: 0,
            child: Stack(
              children: <Widget>[
                Container(
                  padding: EdgeInsets.fromLTRB(22, 5, 22, 5),
                  alignment: Alignment.center,
                  child: FaIcon(icon,
                      size: responsiveText(16),
                      color: ThemesMode.isDarkMode
                          ? AppColors.textYellow
                          : AppColors.textBlue)),
                Positioned.fill(
                    child: new Material(
                        color: Colors.transparent,
                        child: new InkWell(
                          borderRadius: BorderRadius.circular(5),
                          onTap: () {

                            onPressed();

                          },
                        ))),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void getComments() async{
    try{
      var responseData = await VideoServices().getVideoComments(video.id);
      if(responseData != null){
        debugPrint("Comments Loaded $responseData");

        setState(() {
          commentsResponse = responseData;
          isLoaded = true;
        });

      }else{
        debugPrint("Failed $responseData");
      }
    }catch (e){
      debugPrint("Error $e");
    }
  }
}

 */