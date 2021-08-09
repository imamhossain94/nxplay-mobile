import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:nx_play/src/models/reviews/video_reviews.dart';
import 'package:nx_play/src/screens/video_details/components/video_controller/components/icon_text_button.dart';
import 'package:nx_play/src/services/pref_service/shared_pref_service.dart';
import 'package:nx_play/src/utils/app_color.dart';
import 'package:nx_play/src/utils/responsive.dart';
import 'package:nx_play/src/utils/themes_mode.dart';
import 'package:timeago/timeago.dart' as timeAgo;

class ReviewCard extends StatefulWidget {
  const ReviewCard({
    Key key,
    @required this.review,
    @required this.onDeletePressed,
  }) : super(key: key);

  final ReviewData review;
  final VoidCallback onDeletePressed;
  @override
  _ReviewCardState createState() => _ReviewCardState(review);
}

class _ReviewCardState extends State<ReviewCard> {
  final ReviewData review;
  _ReviewCardState(this.review);

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ThemesMode().init(context);
    Responsive().init(context);
    DateTime time = DateTime.parse(review.createdAt);

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
                        image: NetworkImage(review.user.avatar),
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
                            review.title,
                            style:TextStyle(fontSize: 18, fontWeight: FontWeight.bold)
                        ),
                        Text('${timeAgo.format(time)} . ${review.user.name}',
                            style:TextStyle(fontSize: 16)
                        ),
                        SizedBox(height: 10,),
                        Text(
                            review.body,
                            style:TextStyle(fontSize: 16)
                        ),
                        Divider(thickness: 0.5,),
                        Container(
                          padding: EdgeInsets.only(top: 5),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                  review.rating,
                                  style:TextStyle(fontSize: 24, fontWeight: FontWeight.bold)
                              ),
                              SizedBox(width: 10,),
                              RatingBarIndicator(
                                rating: double.parse(review.rating)/2,
                                itemBuilder: (context, index) => Icon(
                                  Icons.star,
                                  color: ThemesMode.isDarkMode?AppColors.textYellow:AppColors.textBlue,
                                ),
                                unratedColor: AppColors.textGrey,
                                itemCount: 5,
                                itemSize: 18.0,
                                direction: Axis.horizontal,
                              ),
                              Spacer(),
                              review.user.id == getUserId()?IconTextButtonWidget(icon: FontAwesomeIcons.solidTrashAlt, iconSize: 16, title: 'Delete', onPressed: (){
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
}
