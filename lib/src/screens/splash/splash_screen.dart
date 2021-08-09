import 'package:flutter/material.dart';
import 'package:nx_play/src/screens/splash/components/body.dart';
import 'package:nx_play/src/services/notification_service/fcm_notification_service.dart';
import 'package:nx_play/src/services/nx_play/refresh_access_token.dart';
import 'package:nx_play/src/services/pref_service/shared_pref_service.dart';
import 'package:nx_play/src/utils/constant.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    checkAccessToken();
  }

  void checkAccessToken() async {
    RefreshAccessTokenService
    refreshAccessTokenService = new RefreshAccessTokenService();
    if(await refreshAccessTokenService.refreshAccessToken() == true){
      //Navigate to home or intro
      route();
    }else{
      route();
    }
  }

  void route() {
    if (getIntroIsDone() == true) {
      routeToHome();
    } else {
      routeToIntro();
    }
  }

  void routeToIntro() {
    Future.delayed(
        Duration(seconds: 3),
        () =>
            Navigator.pushReplacementNamed(
                context, AppConstants.rIntroScreen));
  }

  void routeToHome() {
    Future.delayed(
        Duration(microseconds: 0),
        () =>
            Navigator.pushReplacementNamed(
              context, AppConstants.rHomeScreen));
  }

  @override
  Widget build(BuildContext context) {
    return Body();
  }
}
