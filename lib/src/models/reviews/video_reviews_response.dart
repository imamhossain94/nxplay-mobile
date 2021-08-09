import 'package:nx_play/src/models/reviews/video_reviews.dart';

class VideoReviewsResponse{

  final VideoReviews videoReviews;
  final String error;

  VideoReviewsResponse(this.videoReviews, this.error);

  VideoReviewsResponse.fromJson(dynamic json)
      : videoReviews = VideoReviews.fromJson(json),
        error = "";

  VideoReviewsResponse.withError(String errorValue)
      : videoReviews = VideoReviews(),
        error = errorValue;
}