import 'package:nx_play/src/models/like/like_video.dart';

class LikeVideoResponse{

  final LikeVideo likeData;
  final String error;

  LikeVideoResponse(this.likeData, this.error);

  LikeVideoResponse.fromJson(dynamic json)
      : likeData = LikeVideo.fromJson(json),
        error = "";

  LikeVideoResponse.withError(String errorValue)
      : likeData = LikeVideo(),
        error = errorValue;

}