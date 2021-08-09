import 'package:flutter/material.dart';
import 'package:flutter_score_slider/flutter_score_slider.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:nx_play/src/models/reviews/video_reviews.dart';
import 'package:nx_play/src/screens/video_details/components/video_controller/components/icon_button.dart';
import 'package:nx_play/src/screens/video_details/components/video_controller/components/review_sheet_text_field.dart';
import 'package:nx_play/src/utils/app_color.dart';
import 'package:nx_play/src/utils/app_plugin.dart';
import 'package:nx_play/src/utils/responsive.dart';
import 'package:nx_play/src/utils/themes_mode.dart';

class ReviewForm extends StatefulWidget {
  const ReviewForm({Key key, this.onSendPressed, this.onCancelPressed}):super(key:key);
  final VoidCallback onCancelPressed;
  final Function(ReviewData) onSendPressed;
  @override
  _ReviewFormState createState() => _ReviewFormState();
}

class _ReviewFormState extends State<ReviewForm> {
  TextEditingController titleController = TextEditingController();
  TextEditingController bodyController = TextEditingController();
  int _ratingScore=0;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    titleController.clear();
    bodyController.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ThemesMode().init(context);
    Responsive().init(context);
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.only(topLeft: Radius.circular(15), topRight: Radius.circular(15)),
          color: ThemesMode.isDarkMode?AppColors.backgroundDark:AppColors.backgroundLight,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 3,
              blurRadius: 3,
              offset: Offset(-0.5, -0.5), // changes position of shadow
            ),
          ]
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(15, 7.5, 15, 7.5),
            child: Row(
              children: [
                Text('Add Review..', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: ThemesMode.isDarkMode?AppColors.textYellow:AppColors.textBlue),),
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
                    child: IconButtonWidget(onPressed: () {

                      String title = titleController.text;
                      String body = bodyController.text;

                      if(title.isEmpty){
                        AppPlugin().flushInfo(context, 'Title may not be empty');
                      }else if(body.isEmpty){
                        AppPlugin().flushInfo(context, 'Description may not be empty');
                      }else{
                        widget.onSendPressed(ReviewData(title: title, body: body, rating: _ratingScore.toString()));
                      }
                    }, icon: FontAwesomeIcons.solidPaperPlane, iconSize: 16,)
                ),
                SizedBox(width: 15,),
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
                    child: IconButtonWidget(onPressed: () { widget.onCancelPressed(); }, icon: FontAwesomeIcons.times, iconSize: 16,)
                ),
              ],
            ),
          ),
          ReviewSheetTextField(hint: 'Title', controller: titleController, maxLine:1, isPassword:false),
          ReviewSheetTextField(hint: 'Description...', controller: bodyController, maxLine:4, isPassword:false),
          Padding(
            padding: const EdgeInsets.fromLTRB(15, 7.5, 15, 7.5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  width: 80,
                  height: 35,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: ThemesMode.isDarkMode?Colors.grey[900].withOpacity(0.9):Colors.grey[300].withOpacity(0.5),
                  ),
                  child: Text(
                      _ratingScore.toString(),
                      style:TextStyle(fontSize: 24, fontWeight: FontWeight.bold,
                          color: Colors.grey)),
                ),
                Spacer(),
                Container(
                  width: Responsive.screenWidth-120,
                  child: ScoreSlider(
                    minScore: 0,
                    maxScore: 10,
                    score: 0,
                    height: 35,
                    backgroundColor: ThemesMode.isDarkMode?Colors.grey[900].withOpacity(0.9):Colors.grey[300].withOpacity(0.5),
                    thumbColor: ThemesMode.isDarkMode?AppColors.textYellow:AppColors.textBlue,
                    scoreDotColor: AppColors.textBlue.withOpacity(0.5),
                    onScoreChanged: (newScore) {
                      setState(() {
                        _ratingScore = newScore;
                      });
                    },
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
