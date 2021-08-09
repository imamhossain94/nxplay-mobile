import 'package:flutter/material.dart';
import 'package:nx_play/src/screens/browse/broswe_screen.dart';
import 'package:nx_play/src/screens/explore_videos/more_videos.dart';
import 'package:nx_play/src/screens/forgot_password/forgot_pasword_screen.dart';
import 'package:nx_play/src/screens/home/home_screen.dart';
import 'package:nx_play/src/screens/intro/intro_screen.dart';
import 'package:nx_play/src/screens/profile/profile_screen.dart';
import 'package:nx_play/src/screens/search/search_screen.dart';
import 'package:nx_play/src/screens/sign_in/sign_in_screen.dart';
import 'package:nx_play/src/screens/sign_up/sign_up_screen.dart';
import 'package:nx_play/src/screens/splash/splash_screen.dart';
import 'package:nx_play/src/screens/video_details/video_details_screen.dart';
import 'package:nx_play/src/utils/constant.dart';
import 'package:page_transition/page_transition.dart';


Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case AppConstants.rSplashScreen:
      return PageTransition(child: SplashScreen(), type: PageTransitionType.fade, settings: settings,);
      break;
    case AppConstants.rIntroScreen:
      return PageTransition(child: IntroScreen(), type: PageTransitionType.fade, settings: settings,);
      break;
    case AppConstants.rSignInScreen:
      return PageTransition(child: SignInScreen(), type: PageTransitionType.fade, settings: settings,);
      break;
    case AppConstants.rSignUpScreen:
      return PageTransition(child: SignUpScreen(), type: PageTransitionType.fade, settings: settings,);
      break;
    case AppConstants.rHomeScreen:
      return PageTransition(child: HomeScreen(), type: PageTransitionType.fade, settings: settings,);
      break;
    case AppConstants.rSearchScreen:
      return PageTransition(child: SearchScreen(), type: PageTransitionType.fade, settings: settings,);
      break;
    case AppConstants.rBrowseScreen:
      return PageTransition(child: BrowseScreen(), type: PageTransitionType.fade, settings: settings,);
      break;
    case AppConstants.rProfileScreen:
      return PageTransition(child: ProfileScreen(), type: PageTransitionType.fade, settings: settings,);
      break;                  
    case AppConstants.rResetPassword:
      return PageTransition(child: ForgotPasswordScreen(), type: PageTransitionType.fade, settings: settings,);
      break;
    case AppConstants.rVideoDetailsScreen:
      return PageTransition(child: VideoDetailsScreen(), type: PageTransitionType.rightToLeft, settings: settings,);
      break;
    // case AppConstants.rMoreVideosScreen:
    //   return PageTransition(child: MoreVideos(), type: PageTransitionType.fade, settings: settings,);
    //   break;
    default:
      return null;
  }
}
