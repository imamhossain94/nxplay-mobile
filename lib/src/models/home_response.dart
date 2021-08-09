import 'package:nx_play/src/models/video/videos.dart';

class HomeResponse{

  final List<Videos> newVideos;
  final List<Videos> popularVideos;
  final List<Videos> videos;
  final String error;

  HomeResponse(this.newVideos, this.popularVideos, this.videos, this.error);

  HomeResponse.fromJson(Map<String, dynamic> json)
      : newVideos =  (json["newVideos"] as List).map((i) => new Videos.fromJson(i)).toList(),
        popularVideos = (json["popularVideos"] as List).map((i) => new Videos.fromJson(i)).toList(),
        videos = (json["videos"] as List).map((i) => new Videos.fromJson(i)).toList(),
        error = "";

  HomeResponse.withError(String errorValue)
      : newVideos = List(),popularVideos = List(),videos = List(),
        error = errorValue;

}