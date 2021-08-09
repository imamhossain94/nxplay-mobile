import 'package:nx_play/src/models/comments/video_comment.dart';

class VideoCommentsResponse{

  final VideoComments videoComments;
  final String error;

  VideoCommentsResponse(this.videoComments, this.error);

  VideoCommentsResponse.fromJson(dynamic json)
      : videoComments = VideoComments.fromJson(json),
        error = "";

  VideoCommentsResponse.withError(String errorValue)
      : videoComments = VideoComments(),
        error = errorValue;
}