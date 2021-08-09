import 'package:flutter/material.dart';
import 'package:nx_play/src/components/bottom_navigation_bar.dart';
import 'package:nx_play/src/screens/home/components/app_bar/app_bar.dart';
import 'package:nx_play/src/screens/home/components/body.dart';
import 'package:nx_play/src/services/notification_service/fcm_notification_service.dart';
import 'package:nx_play/src/utils/app_color.dart';
import 'package:nx_play/src/utils/constant.dart';
import 'package:nx_play/src/utils/themes_mode.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  @override
  void initState() {
    FcmNotificationService firebaseMessaging = FcmNotificationService();
    firebaseMessaging.setNotifications();
    firebaseMessaging.streamCtlr.stream.listen((data) {
      Navigator.pushNamed(context, AppConstants.rVideoDetailsScreen, arguments: {'videoId': int.parse(data['video_id'])});
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ThemesMode().init(context);
    return SafeArea(
      child: Scaffold(
        backgroundColor: ThemesMode.isDarkMode
            ? AppColors.primaryDark
            : AppColors.backgroundLight,
        appBar: HomeAppBar(),
        body: Body(),
        bottomNavigationBar: BottomNavBar(
          selectedMenu: AppConstants.rHomeScreen,
        ),
      ),
    );
  }
}
