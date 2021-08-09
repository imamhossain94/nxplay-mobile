import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:nx_play/src/screens/intro/components/content.dart';
import 'package:nx_play/src/services/pref_service/shared_pref_service.dart';
import 'package:nx_play/src/utils/constant.dart';
import 'package:nx_play/src/utils/responsive.dart';
import 'package:nx_play/src/utils/app_color.dart';
import 'package:nx_play/src/utils/themes_mode.dart';

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  int currentPage = 0;
  //var _isDarkMode;

  PageController pageController = PageController(
    initialPage: 0,
    keepPage: true,
  );

 
  @override
  Widget build(BuildContext context) {
      Responsive().init(context);
      ThemesMode().init(context);
      //_isDarkMode = Theme.of(context).brightness == Brightness.dark;

      List<Map<String, String>> splashData = [
      {
        "title": AppConstants.introOneTitle,
        "message": AppConstants.introOneText,
        "image": ThemesMode.isDarkMode
            ? AppConstants.aIntroOneBlack
            : AppConstants.aIntroOneBlue,
      },
      {
        "title": AppConstants.introTwoTitle,
        "message": AppConstants.introTwoText,
        "image": ThemesMode.isDarkMode
            ? AppConstants.aIntroTwoBlack
            : AppConstants.aIntroTwoBlue,
      },
      {
        "title": AppConstants.introThreeTitle,
        "message": AppConstants.introThreeText,
        "image": ThemesMode.isDarkMode
            ? AppConstants.aIntroThreeBlack
            : AppConstants.aIntroThreeBlue,
      },
      {
        "title": AppConstants.introFourTitle,
        "message": AppConstants.introFourText,
        "image": ThemesMode.isDarkMode
            ? AppConstants.aIntroFourBlack
            : AppConstants.aIntroFourBlue,
      },
    ];


    return Container(
      color: ThemesMode.isDarkMode?AppColors.backgroundDark:AppColors.backgroundLight,
      child: Column(
        crossAxisAlignment : CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Expanded(
            child: PageView.builder(
              onPageChanged: (value) {
                setState(() {
                  currentPage = value;
                });
              },
              controller: pageController,
              itemCount: splashData.length,
              itemBuilder: (context, index) => SplashContent(
                image: splashData[index]["image"],
                title: splashData[index]['title'],
                message: splashData[index]['message'],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(8, 0, 8, 15),
            child: Row(
              children: [
                FlatButton(
                  onPressed: () {
                    if (currentPage == 0) {
                      currentPage = splashData.length - 1;
                      changePage(currentPage);
                    } else {
                      currentPage--;
                      changePage(currentPage);
                    }
                  },
                  child: currentPage != 0
                      ? Icon(
                          FontAwesomeIcons.arrowLeft,
                          size: responsiveText(14),
                          color: ThemesMode.isDarkMode
                              ? AppColors.textWhite
                              : AppColors.textBlue,
                        )
                      : Text(AppConstants.introSkip,
                          style: TextStyle(
                            fontSize: responsiveText(14),
                            color: ThemesMode.isDarkMode
                                ? AppColors.textWhite
                                : AppColors.textBlue,
                          )),
                ),
                Spacer(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(
                    splashData.length,
                    (index) => buildDot(index: index),
                  ),
                ),
                Spacer(),
                FlatButton(
                  onPressed: () async {
                    if (currentPage == splashData.length - 1) {
                      setIntroIsDone();
                      Navigator.pushReplacementNamed(
                          context, AppConstants.rHomeScreen);
                    } else {
                      currentPage++;
                      changePage(currentPage);
                    }
                  },
                  child: currentPage != splashData.length - 1
                      ? Icon(
                          FontAwesomeIcons.arrowRight,
                          size: responsiveText(14),
                          color: ThemesMode.isDarkMode
                              ? AppColors.textWhite
                              : AppColors.textBlue,
                        )
                      : Text(AppConstants.introAccept,
                          style: TextStyle(
                            fontSize: responsiveText(14),
                            color: ThemesMode.isDarkMode
                                ? AppColors.textWhite
                                : AppColors.textBlue,
                          )),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void changePage(int index) {
    pageController.animateToPage(index,
        duration: Duration(milliseconds: 500), curve: Curves.ease);
  }

  AnimatedContainer buildDot({int index}) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 200),
      margin: EdgeInsets.only(right: 5),
      height: responsiveHeight(10),
      width: currentPage == index ? responsiveHeight(20) : responsiveHeight(10),
      decoration: BoxDecoration(
        color: currentPage == index
            ? ThemesMode.isDarkMode
                ? AppColors.textWhite
                : AppColors.textBlue
            : Color(0xFFD8D8D8),
        borderRadius: BorderRadius.circular(3),
      ),
    );
  }
}
