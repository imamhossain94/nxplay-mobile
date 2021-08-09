import 'package:flutter/material.dart';
import 'package:nx_play/src/bloc/get_more_video_response_bloc.dart';
import 'package:nx_play/src/models/video/get_more_videos.dart';
import 'package:nx_play/src/models/video/get_more_videos_response.dart';
import 'package:nx_play/src/screens/error/no_internet_screen.dart';
import 'package:nx_play/src/screens/error/not_found_screen.dart';
import 'package:nx_play/src/screens/explore_videos/components/video_tile.dart';
import 'package:nx_play/src/screens/loading/loading_screen.dart';
import 'package:nx_play/src/services/pref_service/shared_pref_service.dart';
import 'package:nx_play/src/utils/app_color.dart';
import 'package:nx_play/src/utils/constant.dart';
import 'package:nx_play/src/utils/responsive.dart';
import 'package:nx_play/src/utils/themes_mode.dart';

class Body extends StatefulWidget {
  final Map<String, String> params;
  Body({Key key, @required this.params}):super(key: key);

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {


  int page =1;
  bool loadMoreVideos = false;
  List<VideosData> videosList = [];

  @override
  void initState() {
    videosList = [];
    moreVideoResponseBloc..getMoreVideos(widget.params);
    super.initState();
  }

  @override
  void dispose() {
    moreVideoResponseBloc..drainStream();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Responsive().init(context);
    ThemesMode().init(context);
    return StreamBuilder<GetMoreVideosResponse>(
      stream: moreVideoResponseBloc.subject.stream,
      builder: (context, AsyncSnapshot<GetMoreVideosResponse> snapshot) {
        if (snapshot.hasData) {
          if (snapshot.data.error != null && snapshot.data.error.length > 0) {
            loadMoreVideos = false;
            return NotFoundScreen(
                actionText: 'Retry',
                onPressed: () {
                  moreVideoResponseBloc..getMoreVideos(widget.params);
                });
          }
          return _buildMoreVideosWidget(snapshot.data);
        } else if (snapshot.hasError) {
          loadMoreVideos = false;
          return NoInternetScreen(onPressed: () {
            moreVideoResponseBloc..getMoreVideos(widget.params);
          });
        } else {
          loadMoreVideos = false;
          return LoadingScreen();
        }
      },
    );
  }

  Widget _buildMoreVideosWidget(GetMoreVideosResponse data) {
    //videosList.clear();
    videosList.addAll(data.getMoreVideos.videosData);

    return SafeArea(
      child: Scaffold(
        backgroundColor: ThemesMode.isDarkMode
            ? AppColors.primaryDark
            : AppColors.backgroundLight,
        body: Stack(
          children: [
            _paginationView(data.getMoreVideos),
            loadMoreVideos == true?linerProgressTextField():Text(''),
          ],
        ),
      ),
    );
  }

  Widget _paginationView(GetMoreVideos getMoreVideos){
    return NotificationListener<ScrollNotification>(
      onNotification: (scrollState) {
        if (!loadMoreVideos && scrollState.metrics.pixels == scrollState.metrics.maxScrollExtent) {
          if(getMoreVideos.lastPage > page){
            page = getMoreVideos.currentPage + 1;
            setState(() {
              loadMoreVideos = true;
            });
            widget.params['page'] = '$page';
            getMoreVideos.clearVideosData();
            moreVideoResponseBloc..getMoreVideos(widget.params);
            Future.delayed(Duration(seconds: 1), (){
              setState(() {
                loadMoreVideos = false;
              });
            });
          }
        }
        return false;
      },
      child: ListView.builder(
          itemCount: videosList.length,
          scrollDirection: Axis.vertical,
          itemBuilder: (context, index) {
            return Padding(
              padding: EdgeInsets.all(10),
              child: VideoTileWidget(videosData: videosList[index], onPressed: (){
                if (getAccessToken() == null) {
                  Navigator.pushNamed(
                      context, AppConstants.rSignInScreen);
                } else {
                  Navigator.pushNamed(context, AppConstants.rVideoDetailsScreen, arguments: {'videoId': videosList[index].id});
                }
              }),
            );
          }
      ),
    );
  }

  Widget linerProgressTextField() {
    return Positioned(
      left:0,
      right: 0,
      bottom: 0,
      child: LinearProgressIndicator(
        minHeight: 3,
        backgroundColor: ThemesMode.isDarkMode
            ? AppColors.textYellow
            : AppColors.textBlue,
        valueColor: AlwaysStoppedAnimation<Color>(Colors.white,),
      ),
    );
  }
}
