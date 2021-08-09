import 'package:nx_play/src/services/pref_service/shared_pref_service.dart';

class AppConstants {
  //routing_path

  static const String rSplashScreen = '/';
  static const String rIntroScreen = '/intro';
  static const String rSignInScreen = '/sig_in';
  static const String rForgotPassword = '/forgot';
  static const String rSignUpScreen = '/sign_up';
  static const String rHomeScreen = '/home';
  static const String rSearchScreen = '/search';
  static const String rBrowseScreen = '/browse';
  static const String rProfileScreen = '/profile';
  static const String rVideoDetailsScreen = '/single_video';
  static const String rMoreVideosScreen = '/more_video';
  static const String rWelComeScreen = '/welcome';
  static const String rResetPassword = '/reset';

//splash_assets
  static String aSplashWhite = 'assets/splash_assets/play_button_white.json';
  static String aSplashBlue = 'assets/splash_assets/play_button_blue.json';
  static String aSplashLogo = 'assets/splash_assets/nx_logo.png';

//intro_assets
  static String aIntroOneBlack = 'assets/intro_assets/intro_one_black.png';
  static String aIntroOneBlue = 'assets/intro_assets/intro_one_blue.png';

  static String aIntroTwoBlack = 'assets/intro_assets/intro_two_black.png';
  static String aIntroTwoBlue = 'assets/intro_assets/intro_two_blue.png';

  static String aIntroThreeBlack = 'assets/intro_assets/intro_three_black.png';
  static String aIntroThreeBlue = 'assets/intro_assets/intro_three_blue.png';

  static String aIntroFourBlack = 'assets/intro_assets/intro_four_black.png';
  static String aIntroFourBlue = 'assets/intro_assets/intro_four_blue.png';

  //no_internet_assets
  static String aNoInternetBlue = 'assets/no_internet/no_internet_blue.json';
  static String aNoInternetYellow =
      'assets/no_internet/no_internet_yellow.json';

  //app_string
  static String appName = 'Nx Play';
  static String signIn = 'Sign In';
  static String signUp = 'Sign Up';

  static String email = 'Email';
  static String name = 'Name';
  static String password = 'Password';
  static String confirmPassword = 'Confirm Password';
  static String doNotHaveAccount = 'Don\'t have an account?';
  static String forgotPassword = 'Forgot password?';
  static String alreadyHaveAnAccount = 'Already have an account?';
  static String resetPassword = 'Reset Password';
  static String enterYourEmail = 'Enter email address';
  static String sendPasswordResetLink = 'Send Password Reset Link';
  static String enterNewPassword = 'Enter new password';
  static String confirmReset = 'Confirm Reset';

  static String introSkip = 'Skip';
  static String introOneTitle = 'Unlimited movies \n& shows';
  static String introOneText = 'Watch unlimited content in one place. ';
  static String introTwoTitle = 'Download and watch offline';
  static String introTwoText =
      'Out of network? no problem, now you can watch offline.';
  static String introThreeTitle = 'Watch everywhere';
  static String introThreeText = 'Now nx play available on web, android & ios.';
  static String introFourTitle = 'Privacy Policy';
  static String introFourText =
      'By creating an account you\'ll agree to the Terms of Service and Privacy Policy.';
  static String introReadMore = 'Read More';
  static String introAccept = 'Accept';

  //themes------------------------
  static String appTheme = "Theme";
  static String dark = "Dark";
  static String light = "Light";
  static String systemDefault = "System default";
  static List<String> themes = ["System default", "Light", "Dark"];

  //notification------------------
  static String receiveNotification = "Receive notification";
  static String videosNotification = "Videos notification";

  //video_player------------------
  static String autoPlay = "Auto play";
  static String pictureInPicture = "Picture in picture";
  static String videoLooping = "Video looping";

  //app_shared_pref------------------------------
  static String introKey = 'intro';
  static String accessToken = 'access_token';
  static String tokenType = 'token_type';
  static String expiresInMinute = 'expires_in_minute';
  static String expiresInDate = 'expires_in_date';
  //
  static String userId = 'user_id';
  static String userName = 'user_name';
  static String userEmail = 'user_email';
  static String userImage = 'user_image';

  //more-movie-sort_by
  static String moreMovieSortAsc = 'more_movie_sort_asc';
  static String moreMovieSortDes = 'more_movie_sort_des';
  static String moreMovieSortTitle = 'more_movie_sort_title';
  static String moreMovieSortImdb = 'more_movie_sort_imdb';
  static String moreMovieSortViews = 'more_movie_sort_views';
  static String moreMovieTypeMovie = 'more_movie_type_movie';
  static String moreMovieTypeSeries = 'more_movie_type_series';

  //text to avatar
  static String textAvatar() {
    String name = getUserName() != null ? getUserName() : "↻";
    var part = name.trim().split(' ');
    return part.length > 1 ? part[0].trim()[0] + part[1].trim()[0] : name;
  }

  //number with suffix
  static String numberFormatter(String currentBalance) {
    try{
      // suffix = {' ', 'k', 'M', 'B', 'T', 'P', 'E'};
      double value = double.parse(currentBalance);
      if(value < 1000){ // less than a thousand
        return value.toString();
      }else if(value >= 1000 && value < (1000*100*10)){ // less than a million
        double result = value/1000;
        return result.toStringAsFixed(2)+"k";
      }else if(value >= 1000000 && value < (1000000*10*100)){ // less than 100 million
        double result = value/1000000;
        return result.toStringAsFixed(2)+"M";
      }else if(value >= (1000000*10*100) && value < (1000000*10*100*100)){ // less than 100 billion
        double result = value/(1000000*10*100);
        return result.toStringAsFixed(2)+"B";
      }else if(value >= (1000000*10*100*100) && value < (1000000*10*100*100*100)){ // less than 100 trillion
        double result = value/(1000000*10*100*100);
        return result.toStringAsFixed(2)+"T";
      }else{
        return currentBalance;
      }
    }catch(e){
      print(e);
      return e;
    }
  }
}
