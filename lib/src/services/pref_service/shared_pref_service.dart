import 'package:nx_play/src/models/nx_play/nx_play_login_response.dart';
import 'package:nx_play/src/models/nx_play/refresh_token.dart';
import 'package:nx_play/src/models/nx_play/refresh_token_response.dart';
import 'package:nx_play/src/utils/constant.dart';
import 'package:nx_play/src/utils/token_expires_time.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPref {
  static SharedPreferences prefs;

  void init() async {
    prefs = await SharedPreferences.getInstance();
  }
}

//intro
bool getIntroIsDone() {
  bool value = SharedPref.prefs.getBool(AppConstants.introKey);
  return value != null ? value : false;
}

void setIntroIsDone() async {
  SharedPref.prefs.setBool(AppConstants.introKey, true);
}

void saveNxPlayUser(NxPlayLoginResponse response) {
  TokenExpiresInTime().getCurrentTimeInMinute();
  SharedPref.prefs.setString(AppConstants.accessToken, response.logInInfo.accessToken);
  SharedPref.prefs.setString(AppConstants.tokenType, response.logInInfo.tokenType);
  SharedPref.prefs.setInt(AppConstants.expiresInMinute, TokenExpiresInTime.currentMinute + (response.logInInfo.expiresIn ~/ 60));
  SharedPref.prefs.setInt(AppConstants.expiresInDate, TokenExpiresInTime.currentDate);
  SharedPref.prefs.setInt(AppConstants.userId, response.logInInfo.data.id);
  SharedPref.prefs.setString(AppConstants.userName, response.logInInfo.data.name);
  SharedPref.prefs.setString(AppConstants.userEmail, response.logInInfo.data.email);
  SharedPref.prefs.setString(AppConstants.userImage, response.logInInfo.data.avatar);
}

String getAccessToken() {
  String value = SharedPref.prefs.getString(AppConstants.accessToken);
  return value;
}

int getUserId() {
  int value = SharedPref.prefs.getInt(AppConstants.userId);
  return value;
}

void setUserName(String value) {
  SharedPref.prefs.setString(AppConstants.userName, value);
}

String getUserName() {
  String value = SharedPref.prefs.getString(AppConstants.userName);
  return value;
}

String getUserEmail() {
  String value = SharedPref.prefs.getString(AppConstants.userEmail);
  return value;
}

void setUserAvatar(String value) {
  SharedPref.prefs.setString(AppConstants.userImage, value);
}

String getUserAvatar() {
  String value = SharedPref.prefs.getString(AppConstants.userImage);
  return value;
}

void removeNxPlayUser() async {
  SharedPref.prefs.remove(AppConstants.accessToken);
  SharedPref.prefs.remove(AppConstants.tokenType);
  SharedPref.prefs.remove(AppConstants.expiresInMinute);
  SharedPref.prefs.remove(AppConstants.expiresInDate);
  SharedPref.prefs.remove(AppConstants.userId);
  SharedPref.prefs.remove(AppConstants.userName);
  SharedPref.prefs.remove(AppConstants.userEmail);
  SharedPref.prefs.remove(AppConstants.userImage);
}

Future<RefreshToken> getRefreshToken() async{
  String accessToken = SharedPref.prefs.getString(AppConstants.accessToken);
  String tokenType = SharedPref.prefs.getString(AppConstants.tokenType);
  int tokenExpireInMinute =
  SharedPref.prefs.getInt(AppConstants.expiresInMinute);
  int tokenExpireInDate = SharedPref.prefs.getInt(AppConstants.expiresInDate);
  return RefreshToken(
      accessToken: accessToken,
      tokenType: tokenType,
      tokenExpireInSecond: tokenExpireInMinute,
      tokenExpireInDate: tokenExpireInDate);
}

void saveRefreshToken(RefreshTokenResponse response) {
  TokenExpiresInTime().getCurrentTimeInMinute();
  SharedPref.prefs.setString(AppConstants.accessToken, response.refreshToken.accessToken);
  SharedPref.prefs.setString(AppConstants.tokenType, response.refreshToken.tokenType);
  SharedPref.prefs.setInt(AppConstants.expiresInMinute, TokenExpiresInTime.currentMinute + (response.refreshToken.expiresIn ~/ 60));
  SharedPref.prefs.setInt(AppConstants.expiresInDate, TokenExpiresInTime.currentDate);
}

//themes
int getSavedTheme() {
  return AppConstants.themes.indexOf(
      SharedPref.prefs.getString(AppConstants.appTheme) ??
          AppConstants.systemDefault);
}

//notification
bool getReceivedNotification() {
  bool value = SharedPref.prefs.getBool(AppConstants.receiveNotification);
  return value != null ? value : false;
}

void setReceivedNotification(bool value) {
  SharedPref.prefs.setBool(AppConstants.receiveNotification, value);
}

bool getVideosNotification() {
  bool value = SharedPref.prefs.getBool(AppConstants.videosNotification);
  return value != null ? value : false;
}

void setVideosNotification(bool value) {
  SharedPref.prefs.setBool(AppConstants.videosNotification, value);
}

//video player
void setVideoAutoPlay(bool value) {
  SharedPref.prefs.setBool(AppConstants.autoPlay, value);
}

bool getVideoAutoPlay() {
  bool value = SharedPref.prefs.getBool(AppConstants.autoPlay);
  return value != null ? value : false;
}

void setVideoPictureInPicture(bool value) {
  SharedPref.prefs.setBool(AppConstants.pictureInPicture, value);
}

bool getVideoPictureInPicture() {
  bool value = SharedPref.prefs.getBool(AppConstants.pictureInPicture);
  return value != null ? value : false;
}

void setVideoLooping(bool value) {
  SharedPref.prefs.setBool(AppConstants.videoLooping, value);
}

bool getVideoLooping() {
  bool value = SharedPref.prefs.getBool(AppConstants.videoLooping);
  return value != null ? value : false;
}


//more-movie-sort-by
// moreMovieSortAsc
void setMoreMovieSortAsc(bool value) {
  SharedPref.prefs.setBool(AppConstants.moreMovieSortAsc, value);
}

bool getMoreMovieSortAsc() {
  bool value = SharedPref.prefs.getBool(AppConstants.moreMovieSortAsc);
  return value != null ? value : false;
}
// moreMovieSortDes
void setMoreMovieSortDes(bool value) {
  SharedPref.prefs.setBool(AppConstants.moreMovieSortDes, value);
}

bool getMoreMovieSortDes() {
  bool value = SharedPref.prefs.getBool(AppConstants.moreMovieSortDes);
  return value != null ? value : false;
}

// moreMovieSortTitle
void setMoreMovieSortTitle(bool value) {
  SharedPref.prefs.setBool(AppConstants.moreMovieSortTitle, value);
}

bool getMoreMovieSortTitle() {
  bool value = SharedPref.prefs.getBool(AppConstants.moreMovieSortTitle);
  return value != null ? value : false;
}

// moreMovieSortImdb
void setMoreMovieSortImdb(bool value) {
  SharedPref.prefs.setBool(AppConstants.moreMovieSortImdb, value);
}

bool getMoreMovieSortImdb() {
  bool value = SharedPref.prefs.getBool(AppConstants.moreMovieSortImdb);
  return value != null ? value : false;
}
// moreMovieSortTitle
void setMoreMovieSortViews(bool value) {
  SharedPref.prefs.setBool(AppConstants.moreMovieSortViews, value);
}

bool getMoreMovieSortViews() {
  bool value = SharedPref.prefs.getBool(AppConstants.moreMovieSortViews);
  return value != null ? value : false;
}
// moreMovieTypeMovie
void setMoreMovieTypeMovie(bool value) {
  SharedPref.prefs.setBool(AppConstants.moreMovieTypeMovie, value);
}

bool getMoreMovieTypeMovie() {
  bool value = SharedPref.prefs.getBool(AppConstants.moreMovieTypeMovie);
  return value != null ? value : false;
}
// moreMovieTypeSeries
void setMoreMovieTypeSeries(bool value) {
  SharedPref.prefs.setBool(AppConstants.moreMovieTypeSeries, value);
}

bool getMoreMovieTypeSeries() {
  bool value = SharedPref.prefs.getBool(AppConstants.moreMovieTypeSeries);
  return value != null ? value : false;
}

