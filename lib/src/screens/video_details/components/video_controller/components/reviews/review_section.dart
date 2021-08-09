import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:nx_play/src/models/reviews/video_reviews.dart';
import 'package:nx_play/src/models/single_video/single_video.dart';
import 'package:nx_play/src/screens/video_details/components/video_controller/components/bottom_icon_text_button.dart';
import 'package:nx_play/src/screens/video_details/components/video_controller/components/comments/comments_header.dart';
import 'package:nx_play/src/screens/video_details/components/video_controller/components/reviews/review_card.dart';
import 'package:nx_play/src/screens/video_details/components/video_controller/components/reviews/review_form.dart';
import 'package:nx_play/src/services/video_service/video_service.dart';
import 'package:nx_play/src/utils/app_color.dart';
import 'package:nx_play/src/utils/app_plugin.dart';
import 'package:nx_play/src/utils/responsive.dart';
import 'package:nx_play/src/utils/themes_mode.dart';

class ReviewsSection extends StatefulWidget {
  final SingleVideo video;
  const ReviewsSection({
    Key key,
    @required this.video,
  }) : super(key: key);
  @override
  _ReviewsSectionState createState() => _ReviewsSectionState(video);
}

class _ReviewsSectionState extends State<ReviewsSection> {
  SingleVideo video;
  VideoReviews videoReviews;
  List<ReviewData> reviewData = [];
  _ReviewsSectionState(this.video);

  int page =1 , totalReviews = 0;
  bool initialLoading = true, loadOtherReviews = false, isPostingReview = false;

  ScrollController _controller;

  @override
  void initState() {
    getReview(1);
    _controller = ScrollController();
    super.initState();
  }

  @override
  void dispose() {
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
            title: 'Reviews  ... ${totalReviews != 0 ? totalReviews : ''}',),
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
          child: BottomIconTextButton(title: 'Click to add review...', onPressed: () {
            setState(() {
              isPostingReview = true;
            });
          }),
        ),
        Positioned(
          left: 0,
          right: 0,
          bottom: 0,
          child:isPostingReview == true? ReviewForm(
            onCancelPressed: (){
              setState(() {
                isPostingReview = false;
              });
            },
            onSendPressed: (value){
              print('Posting');
              setState(() {
                loadOtherReviews = true;
                isPostingReview = false;
              });
              postReview(context, value.title, value.body, value.rating);
            },
          ): SizedBox(height: 0,),
        ),
        loadOtherReviews == true?linerProgressTextField():SizedBox(height: 0,),
      ],
    );
  }

  Widget _paginationView(){
    return initialLoading == false? NotificationListener<ScrollNotification>(
      onNotification: (scrollState) {
        if (!loadOtherReviews && scrollState.metrics.pixels == scrollState.metrics.maxScrollExtent) {
          if(videoReviews.lastPage > page){
            page++;
            setState(() {
              loadOtherReviews = true;
            });
            getReview(page);
          }
        }
        return false;
      },
      child: ListView.builder(
        itemCount: reviewData.length,
        controller: _controller,
        itemBuilder: (context, index) {
          return ReviewCard(
            key: Key(UniqueKey().toString()),
            review: reviewData[index],
            onDeletePressed: (){
              setState(() {
                loadOtherReviews = true;
              });
              deleteReview(reviewData[index].id, index);
            },
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

  void getReview(int page) async{
    var response = await VideoServices().getVideoReview(video.id, page);
    if(response != null){
      setState(() {
        videoReviews = response.videoReviews;
        reviewData.addAll(response.videoReviews.reviewData);
        totalReviews += response.videoReviews.reviewData.length;
        loadOtherReviews = initialLoading = false;
      });
      if(page == 1){
        Future.delayed(Duration(seconds: 1), () {
          _controller.animateTo(0, curve: Curves.linear,
              duration: Duration(milliseconds: 500));
        });
      }
    }else{
      setState(() {
        loadOtherReviews = initialLoading = false;
      });
    }
  }

  void postReview(BuildContext context, String title, String body, String rating) async {
    try{
      var response = await VideoServices().postVideoReviews(video.id, title, body, rating);
      if (response != null) {
        reviewData.clear();
        totalReviews = 0;
        page = 1;
        isPostingReview = false;
        getReview(page);
      }else{
        setState(() {
          loadOtherReviews = false;
        });
      }
    }catch (e){
      AppPlugin().flushInfo(context, '${e.toString()}');
      setState(() {
        loadOtherReviews = false;
      });
    }
  }

  void deleteReview(int reviewId, int index) async{
    setState(() {
      reviewData.removeAt(index);
    });
    var response = await VideoServices().removeVideoReviews(reviewId);
    if(response != null){
      reviewData.clear();
      totalReviews = 0;
      page = 1;
      getReview(page);
    }else{
      setState(() {
        loadOtherReviews = false;
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