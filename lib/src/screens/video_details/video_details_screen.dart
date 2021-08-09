import 'package:flutter/material.dart';
import 'package:nx_play/src/models/single_video/single_video.dart';
import 'package:nx_play/src/models/single_video/single_video_response.dart';
import 'package:nx_play/src/bloc/get_single_video_response_bloc.dart';
import 'package:nx_play/src/screens/error/no_internet_screen.dart';
import 'package:nx_play/src/screens/error/not_found_screen.dart';
import 'package:nx_play/src/screens/loading/loading_screen.dart';
import 'package:nx_play/src/screens/video_details/components/details_card/details_card.dart';
import 'package:nx_play/src/screens/video_details/components/genres_list/genras_list.dart';
import 'package:nx_play/src/screens/video_details/components/movie_card/movie_card.dart';
import 'package:nx_play/src/screens/video_details/components/photo_card/photos_card.dart';
import 'package:nx_play/src/screens/video_details/components/similar_movie_list/similar_movies_list.dart';
import 'package:nx_play/src/screens/video_details/components/video_controller/video_control_list.dart';
import 'package:nx_play/src/screens/video_details/components/video_player/video_player.dart';
import 'package:nx_play/src/utils/app_color.dart';
import 'package:nx_play/src/utils/constant.dart';
import 'package:nx_play/src/utils/responsive.dart';
import 'package:nx_play/src/utils/themes_mode.dart';

class VideoDetailsScreen extends StatefulWidget {
  VideoDetailsScreen({Key key}) : super(key: key);
  @override
  _VideoDetailsScreenState createState() => _VideoDetailsScreenState();
}

class _VideoDetailsScreenState extends State<VideoDetailsScreen> {

  Map data = {};
  int videoId = 0;


  // @override
  // void initState() {
  //   super.initState();
  //   singleVideoResponseBloc..getMovies(videoId);
  // }


  @override
  void dispose() {
    super.dispose();
    singleVideoResponseBloc..drainStream();
  }

  @override
  Widget build(BuildContext context) {

    data = data.isEmpty? ModalRoute.of(context).settings.arguments:data;
    videoId = data['videoId'];
    singleVideoResponseBloc..getSingleVideo(videoId);

    return StreamBuilder<SingleVideoResponse>(
      stream: singleVideoResponseBloc.subject.stream,
      builder: (context, AsyncSnapshot<SingleVideoResponse> snapshot) {
        if (snapshot.hasData) {
          if (snapshot.data.error != null && snapshot.data.error.length > 0) {
            return NotFoundScreen(
                actionText: snapshot.data.error,
                onPressed: () {
                  Navigator.pop(context);
                });
          }
          return _buildVideoDetailsWidget(snapshot.data, context);
        } else if (snapshot.hasError) {
          return NoInternetScreen(onPressed: () {
            singleVideoResponseBloc..getSingleVideo(videoId);
          });
        } else {
          return LoadingScreen();
        }
      },
    );
  }

  Widget _buildVideoDetailsWidget(SingleVideoResponse data, BuildContext context) {
    SingleVideo video = data.singleVideo;
    Responsive().init(context);
    ThemesMode().init(context);
    // double height = Responsive.orientation == Orientation.landscape?Responsive.screenHeight:(Responsive.screenWidth/3.55)+(Responsive.screenWidth/3.55);
    // double width = Responsive.orientation == Orientation.landscape?Responsive.screenWidth:Responsive.screenWidth;
    return Scaffold(
      body: SafeArea(
        child:
        Container(
          padding:EdgeInsets.all(0.0),
          child: Column(
            children: [
              VideoPlayerWidget(video: video),
              Responsive.orientation == Orientation.portrait?
              Expanded(
                flex: 1,
                child: Column(
                  children: [
                    Divider(thickness: 2, height: 2,),
                    VideoControlListWidget(video:video),
                    Divider(thickness: 2, height: 2,),
                    Expanded(
                      flex: 1,
                      child: SingleChildScrollView(
                        child: Column(
                          children: <Widget>[
                            MovieCardWidget(video:video),
                            Divider(thickness: 2, height: 2,),
                            GenresListWidget(video: video),
                            Divider(thickness: 2, height: 2,),
                            SimilarMovieListWidget(video:video, onPressed: (value){

                              Navigator.popAndPushNamed(context, AppConstants.rVideoDetailsScreen, arguments: {'videoId': value});

                              },),
                            Divider(thickness: 2, height: 2,),
                            PhotosCardWidget(video:video),
                            Divider(thickness: 2, height: 2,),
                            DetailsCardWidget(video:video),
                            Container(height: 30, color: ThemesMode.isDarkMode ? AppColors.primaryDark : AppColors.textWhite,),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ):SizedBox(height: 0,),
            ],
          ),
        ),
      ),
    );
  }



}
