import 'package:nx_play/src/models/video/get_more_videos.dart';

class GetSearchVideosResponse{

  final GetMoreVideos getMoreVideos;
  final String error;

  GetSearchVideosResponse(this.getMoreVideos, this.error);

  GetSearchVideosResponse.fromJson(dynamic json)
      : getMoreVideos = GetMoreVideos.fromJson(json),
        error = "";

  GetSearchVideosResponse.withError(String errorValue)
      : getMoreVideos = GetMoreVideos(),
        error = errorValue;

}