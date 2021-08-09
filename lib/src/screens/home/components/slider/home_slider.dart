import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:nx_play/src/models/video/videos.dart';
import 'package:nx_play/src/screens/home/components/slider/slider_header.dart';
import 'package:nx_play/src/screens/video_details/video_details_screen.dart';
import 'package:nx_play/src/services/pref_service/shared_pref_service.dart';
import 'package:nx_play/src/utils/app_color.dart';
import 'package:nx_play/src/utils/constant.dart';
import 'package:nx_play/src/utils/responsive.dart';
import 'package:nx_play/src/utils/themes_mode.dart';

class HomeSlider extends StatefulWidget {
  HomeSlider({
    Key key,
    @required this.videos,
  }) : super(key: key);

  final List<Videos> videos;
  @override
  _HomeSliderState createState() => _HomeSliderState(videos);
}

class _HomeSliderState extends State<HomeSlider> {
  final List<Videos> videos;
  _HomeSliderState(this.videos);
  PageController pageController =
      PageController(viewportFraction: 1, keepPage: true);
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    String posterUrl = DotEnv().env['SLIDER_POSTER_URL'];
    return Container(
      height: 360.0,
      width: MediaQuery.of(context).size.width,
      child: Stack(
        children: [
          SliderHeader(
            selectedIndex: selectedIndex,
            length: videos.length,
          ),
          Positioned(
            top: 40,
            left: 0,
            right: 0,
            bottom: 0,
            child: PageView.builder(
              controller: pageController,
              scrollDirection: Axis.horizontal,
              itemCount: videos.length,
              onPageChanged: (index) {
                setState(() {
                  selectedIndex = index;
                });
              },
              itemBuilder: (context, index) {
                return Stack(
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.fromLTRB(10, 40, 10, 0),
                      child: Container(
                          //width: MediaQuery.of(context).size.width-20,
                          height: 264.0,
                          decoration: new BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            shape: BoxShape.rectangle,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black,
                                offset: Offset(0.0, 1.0), //(x,y)
                                blurRadius: 6.0,
                              ),
                            ],
                            image: DecorationImage(
                                fit: BoxFit.cover,
                                image: NetworkImage(
                                    "$posterUrl${videos[index].poster}")),
                          )),
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    Positioned(
                      top: 40,
                      left: 10,
                      right: 10,
                      child: Container(
                        padding: EdgeInsets.fromLTRB(15, 10, 90, 10),
                        //height: 40,
                        width: Responsive.screenWidth - 25,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(8),
                              topRight: Radius.circular(8)),
                          gradient: LinearGradient(
                              colors: [
                                Colors.black.withOpacity(0.4),
                                Colors.black.withOpacity(0.0),
                              ],
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter),
                        ),
                        child: Text(
                          videos[index].title,
                          style: TextStyle(
                              shadows: [
                                Shadow(
                                  offset: Offset(0.0, 0.5),
                                  blurRadius: 3.0,
                                  color: Color.fromARGB(255, 0, 0, 0),
                                )
                              ],
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 36.0),
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 15,
                      left: 10,
                      right: 10,
                      child: Container(
                        alignment: Alignment.bottomCenter,
                        padding: EdgeInsets.fromLTRB(8, 5, 10, 8),
                        height: 80,
                        width: Responsive.screenWidth - 25,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(8),
                              bottomRight: Radius.circular(8)),
                          gradient: LinearGradient(
                              colors: [
                                Colors.blue.withOpacity(0.0),
                                Colors.blue.withOpacity(0.4),
                              ],
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter),
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              child: SingleChildScrollView(
                                  scrollDirection: Axis.horizontal,
                                  child: Row(
                                    children: _buildGenresChips(index),
                                  )),
                            ),
                            Container(
                                height: 20,
                                child: VerticalDivider(
                                  color: ThemesMode.isDarkMode
                                      ? Colors.black
                                      : AppColors.textWhite,
                                  thickness: 1.5,
                                )),
                            Padding(
                              padding: const EdgeInsets.only(
                                left: 8,
                                right: 5,
                                //bottom:5
                              ),
                              child: Chip(
                                elevation: 5.0,
                                label: Icon(Icons.play_arrow),
                                backgroundColor: ThemesMode.isDarkMode
                                    ? AppColors.textBlack
                                    : AppColors.textWhite,
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    Positioned.fill(
                      left: 10,
                      right: 10,
                      top: 40,
                      bottom: 15,
                      child: Material(
                        color: Colors.transparent,
                        child: InkWell(
                          onTap: () {
                            if (getAccessToken() == null) {
                              Navigator.pushNamed(
                                  context, AppConstants.rSignInScreen);
                            } else {

                              Navigator.pushNamed(context, AppConstants.rVideoDetailsScreen, arguments: {'videoId': videos[index].id});

                            }
                          },
                          highlightColor: Colors.black.withOpacity(0.5),
                          splashColor: Colors.black.withOpacity(0.1),
                          borderRadius: BorderRadius.all(Radius.circular(8.0)),
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  List<Widget> _buildGenresChips(int index) {
    return videos[index].genres.map((genres) {
      return Padding(
        padding: const EdgeInsets.only(left: 4, right: 4),
        child: Chip(
          elevation: 1.0,
          label: Text(genres),
          backgroundColor:
              ThemesMode.isDarkMode ? AppColors.textBlack : AppColors.textWhite,
        ),
      );
    }).toList();
  }
}
