import 'package:flutter/material.dart';
import 'package:nx_play/src/bloc/get_home_response_bloc.dart';
import 'package:nx_play/src/models/home_response.dart';
import 'package:nx_play/src/screens/error/no_internet_screen.dart';
import 'package:nx_play/src/screens/error/not_found_screen.dart';
import 'package:nx_play/src/screens/home/components/slider/home_slider.dart';
import 'package:nx_play/src/screens/home/components/videos_list/videos_list.dart';
import 'package:nx_play/src/screens/loading/loading_screen.dart';
import 'package:nx_play/src/utils/app_color.dart';
import 'package:nx_play/src/utils/responsive.dart';
import 'package:nx_play/src/utils/themes_mode.dart';

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  @override
  void initState() {
    super.initState();
    homeResponseBloc..getMovies();
  }

  @override
  Widget build(BuildContext context) {
    Responsive().init(context);
    ThemesMode().init(context);
    return StreamBuilder<HomeResponse>(
      stream: homeResponseBloc.subject.stream,
      builder: (context, AsyncSnapshot<HomeResponse> snapshot) {
        if (snapshot.hasData) {
          if (snapshot.data.error != null && snapshot.data.error.length > 0) {
            return NotFoundScreen(
                actionText: 'Retry',
                onPressed: () {
                  homeResponseBloc..getMovies();
                });
          }
          return _buildHomeWidget(snapshot.data);
        } else if (snapshot.hasError) {
          return NoInternetScreen(onPressed: () {
            homeResponseBloc..getMovies();
          });
        } else {
          return LoadingScreen();
        }
      },
    );
  }

  Widget _buildHomeWidget(HomeResponse data) {
    ThemesMode().init(context);
    return Scaffold(
      backgroundColor: ThemesMode.isDarkMode
          ? AppColors.primaryDark
          : AppColors.backgroundLight,
      body: ListView(
        children: <Widget>[
          HomeSlider(videos: data.newVideos),
          VideosList(
            videos: data.popularVideos,
            title: "POPULAR VIDEOS",
          ),
          VideosList(
            videos: data.videos,
            title: "VIDEOS",
          ),
        ],
      ),
    );
  }
}
