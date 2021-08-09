import 'package:nx_play/src/models/video/videos.dart';

class Home {
  final Videos newVideos;
  final Videos popularVideos;
  final Videos videos;
  String error;

  Home(this.newVideos, this.popularVideos, this.videos, this.error);

  Home.fromJson(Map<String, dynamic> json):
        newVideos = new Videos(),
        popularVideos = new Videos(),
        videos = new Videos(),
        error = "";

}