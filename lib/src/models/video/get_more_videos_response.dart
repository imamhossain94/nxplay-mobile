import 'package:nx_play/src/models/video/get_more_videos.dart';

class GetMoreVideosResponse{

  final GetMoreVideos getMoreVideos;
  final String error;

  GetMoreVideosResponse(this.getMoreVideos, this.error);

  GetMoreVideosResponse.fromJson(dynamic json)
      : getMoreVideos = GetMoreVideos.fromJson(json),
        error = "";

  GetMoreVideosResponse.withError(String errorValue)
      : getMoreVideos = GetMoreVideos(),
        error = errorValue;

}