import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:nx_play/src/models/comments/comment_replies_response.dart';
import 'package:nx_play/src/models/comments/post_video_comment_response.dart';
import 'package:nx_play/src/models/comments/video_comment_response.dart';
import 'package:nx_play/src/models/home_response.dart';
import 'package:nx_play/src/models/like/like_comment_response.dart';
import 'package:nx_play/src/models/like/like_video_response.dart';
import 'package:nx_play/src/models/reviews/post_video_reviews_response.dart';
import 'package:nx_play/src/models/reviews/video_reviews_response.dart';
import 'package:nx_play/src/models/video/get_more_videos_response.dart';
import 'package:nx_play/src/models/video/get_search_videos_response.dart';
import 'package:nx_play/src/services/pref_service/shared_pref_service.dart';
import 'package:nx_play/src/models/single_video/single_video_response.dart';

class VideoServices {

  Dio dio;

  VideoServices() {
    if (dio == null) {
      BaseOptions options = new BaseOptions(
          baseUrl: DotEnv().env['APP_URL'],
          receiveDataWhenStatusError: true,
          connectTimeout: 60*1000,
          receiveTimeout: 60*1000
      );
      dio = new Dio(options);
    }
  }

  Future<HomeResponse> getHomeVideos() async {
    try {
      Response response = await dio.get("/home",);
      final HomeResponse homeResponse = HomeResponse.fromJson(response.data);
      return homeResponse;
    }on DioError  catch (ex) {
      if(ex.type == DioErrorType.CONNECT_TIMEOUT){
        //throw Exception("Connection  Timeout Exception");
        return HomeResponse.withError('Connection  Timeout Exception');
      }
      print(ex.message);
      //throw Exception(ex.message);
      return HomeResponse.withError(ex.message);
    } catch (error, stacktrace) {
      print("Exception occurred: $error stackTrace: $stacktrace");
      return HomeResponse.withError("$error");
    }
  }

  Future<SingleVideoResponse> getSingleVideos(int videoId) async {
    try {
      dio.options.headers['content-Type'] = 'application/json';
      dio.options.headers["authorization"] = "Bearer ${getAccessToken()}";
      Response response = await dio.get("/videos/$videoId");
      final SingleVideoResponse singleVideoResponse = SingleVideoResponse.fromJson(response.data);
      return singleVideoResponse;
    }on DioError  catch (ex) {
      if(ex.type == DioErrorType.CONNECT_TIMEOUT){
        throw Exception("Connection  Timeout Exception");
      }
      throw Exception(ex.message);
    } catch (error, stacktrace) {
      print("Exception occurred: $error stackTrace: $stacktrace");
      return SingleVideoResponse.withError("$error");
    }
  }

  Future<GetMoreVideosResponse> getMoreVideos(Map<String, String> queryParameters) async {
    try {
      dio.options.headers['content-Type'] = 'application/json';
      dio.options.headers["authorization"] = "Bearer ${getAccessToken()}";
      Response response = await dio.get("/videos", queryParameters: queryParameters);
      final GetMoreVideosResponse getAllVideosResponse = GetMoreVideosResponse.fromJson(response.data);
      return getAllVideosResponse;
    }on DioError  catch (ex) {
      if(ex.type == DioErrorType.CONNECT_TIMEOUT){
        throw Exception("Connection  Timeout Exception");
      }
      throw Exception(ex.message);
    } catch (error, stacktrace) {
      print("Exception occurred: $error stackTrace: $stacktrace");
      return GetMoreVideosResponse.withError("$error");
    }
  }

  Future<GetSearchVideosResponse> getSearchVideos(Map<String, String> queryParameters) async {
    try {
      dio.options.headers['content-Type'] = 'application/json';
      dio.options.headers["authorization"] = "Bearer ${getAccessToken()}";
      Response response = await dio.get("/search", queryParameters: queryParameters);
      final GetSearchVideosResponse getAllVideosResponse = GetSearchVideosResponse.fromJson(response.data);
      return getAllVideosResponse;
    }on DioError  catch (ex) {
      if(ex.type == DioErrorType.CONNECT_TIMEOUT){
        throw Exception("Connection  Timeout Exception");
      }
      throw Exception(ex.message);
    } catch (error, stacktrace) {
      print("Exception occurred: $error stackTrace: $stacktrace");
      return GetSearchVideosResponse.withError("$error");
    }
  }




  Future<LikeVideoResponse> postVideoLike(var requestData) async {
    try {
      dio.options.headers['content-Type'] = 'application/json';
      dio.options.headers["authorization"] = "Bearer ${getAccessToken()}";

      Response response = await dio.post("/videos/like", data: requestData);
      final LikeVideoResponse likeVideoResponse = LikeVideoResponse.fromJson(response.data);
      return likeVideoResponse;
    }on DioError  catch (ex) {
      if(ex.type == DioErrorType.CONNECT_TIMEOUT){
        throw Exception("Connection  Timeout Exception");
      }
      throw Exception(ex.message);
    } catch (error, stacktrace) {
      print("Exception occurred: $error stackTrace: $stacktrace");
      return LikeVideoResponse.withError("$error");
    }
  }

  //----------------- video-comments -----------------
  Future<VideoCommentsResponse> getVideoComments(int videoId, int page) async {
    try {
      dio.options.headers['content-Type'] = 'application/json';
      dio.options.headers["authorization"] = "Bearer ${getAccessToken()}";
      //dio.options.queryParameters = {'video_id':videoId};
      dio.options.queryParameters = {'video_id': videoId, 'page': page,};
      Response response = await dio.get("/comments");
      final VideoCommentsResponse videoCommentsResponse = VideoCommentsResponse.fromJson(response.data);
      print(videoCommentsResponse.videoComments);
      return videoCommentsResponse;
    }on DioError  catch (ex) {
      if(ex.type == DioErrorType.CONNECT_TIMEOUT){
        throw Exception("Connection  Timeout Exception");
      }
      throw Exception(ex.message.toString());
    } catch (error, stacktrace) {
      print("Exception occurred: $error stackTrace: $stacktrace");
      return VideoCommentsResponse.withError("$error");
    }
  }

  Future<PostVideoCommentsResponse> postVideoComments(int videoId, String commentText) async {
    try {
      dio.options.headers['content-Type'] = 'application/json';
      dio.options.headers["authorization"] = "Bearer ${getAccessToken()}";
      dio.options.queryParameters = {'video_id': videoId, 'comment_text': commentText,};
      Response response = await dio.post("/comments");
      final PostVideoCommentsResponse postVideoCommentsResponse = PostVideoCommentsResponse.fromJson(response.data);
      return postVideoCommentsResponse;
    }on DioError  catch (ex) {
      if(ex.type == DioErrorType.CONNECT_TIMEOUT){
        throw Exception("Connection  Timeout Exception");
      }
      throw Exception(ex.message.toString());
    } catch (error, stacktrace) {
      print("Exception occurred: $error stackTrace: $stacktrace");
      return PostVideoCommentsResponse.withError("$error");
    }
  }

  Future<String> removeVideoComments(int commentId) async {
    try {
      dio.options.headers['content-Type'] = 'application/json';
      dio.options.headers["authorization"] = "Bearer ${getAccessToken()}";
      Response response = await dio.delete("/comments/$commentId");
      return response.data.toString();
    }on DioError  catch (ex) {
      if(ex.type == DioErrorType.CONNECT_TIMEOUT){
        throw Exception("Connection  Timeout Exception");
      }
      throw Exception(ex.message.toString());
    } catch (error, stacktrace) {
      print("Exception occurred: $error stackTrace: $stacktrace");
      return '';
    }
  }

  Future<LikeCommentResponse> postCommentLike(var requestData) async {
    try {
      dio.options.headers['content-Type'] = 'application/json';
      dio.options.headers["authorization"] = "Bearer ${getAccessToken()}";

      Response response = await dio.post("/comments/like", data: requestData);
      final LikeCommentResponse likeCommentResponse = LikeCommentResponse.fromJson(response.data);
      print(likeCommentResponse.likeData.status);
      return likeCommentResponse;
    }on DioError  catch (ex) {
      if(ex.type == DioErrorType.CONNECT_TIMEOUT){
        throw Exception("Connection  Timeout Exception");
      }
      throw Exception(ex.message);
    } catch (error, stacktrace) {
      print("Exception occurred: $error stackTrace: $stacktrace");
      return LikeCommentResponse.withError("$error");
    }
  }

  //getCommentsReplies----------
  Future<CommentRepliesResponse> getCommentReply(int parentId, int page) async {
    try {
      dio.options.headers['content-Type'] = 'application/json';
      dio.options.headers["authorization"] = "Bearer ${getAccessToken()}";
      dio.options.queryParameters = {'page': page,};
      Response response = await dio.get("/comments/$parentId");
      final CommentRepliesResponse commentRepliesResponse = CommentRepliesResponse.fromJson(response.data);
      print(commentRepliesResponse.commentReplies);
      return commentRepliesResponse;
    }on DioError  catch (ex) {
      if(ex.type == DioErrorType.CONNECT_TIMEOUT){
        throw Exception("Connection  Timeout Exception");
      }
      throw Exception(ex.message.toString());
    } catch (error, stacktrace) {
      print("Exception occurred: $error stackTrace: $stacktrace");
      return CommentRepliesResponse.withError("$error");
    }
  }
//607 taka
  Future<PostVideoCommentsResponse> postCommentReply(int videoId, int parentId, int repliedToId, String commentText) async {
    try {
      dio.options.headers['content-Type'] = 'application/json';
      dio.options.headers["authorization"] = "Bearer ${getAccessToken()}";
      dio.options.queryParameters = {'video_id': videoId, 'parent_id': parentId,  'replied_to_id': repliedToId,'comment_text': commentText,};
      Response response = await dio.post("/comments");
      final PostVideoCommentsResponse postVideoCommentsResponse = PostVideoCommentsResponse.fromJson(response.data);
      return postVideoCommentsResponse;
    }on DioError  catch (ex) {
      if(ex.type == DioErrorType.CONNECT_TIMEOUT){
        throw Exception("Connection  Timeout Exception");
      }
      throw Exception(ex.message.toString());
    } catch (error, stacktrace) {
      print("Exception occurred: $error stackTrace: $stacktrace");
      return PostVideoCommentsResponse.withError("$error");
    }
  }

  //----------------- video--reviews -----------------

  Future<VideoReviewsResponse> getVideoReview(int videoId, int page) async {
    try {
      dio.options.headers['content-Type'] = 'application/json';
      dio.options.headers["authorization"] = "Bearer ${getAccessToken()}";
      dio.options.queryParameters = {'video_id': videoId, 'page': page,};
      Response response = await dio.get("/reviews");
      final VideoReviewsResponse videoReviewsResponse = VideoReviewsResponse.fromJson(response.data);
      return videoReviewsResponse;
    }on DioError  catch (ex) {
      if(ex.type == DioErrorType.CONNECT_TIMEOUT){
        throw Exception("Connection  Timeout Exception");
      }
      throw Exception(ex.message.toString());
    } catch (error, stacktrace) {
      print("Exception occurred: $error stackTrace: $stacktrace");
      return VideoReviewsResponse.withError("$error");
    }
  }

  Future<PostVideoReviewsResponse> postVideoReviews(int videoId, String title, String body, String rating) async {
    try {
      dio.options.headers['content-Type'] = 'application/json';
      dio.options.headers["authorization"] = "Bearer ${getAccessToken()}";
      dio.options.queryParameters = {'video_id': videoId, 'title': title, 'body': body, 'rating': rating};
      Response response = await dio.post("/reviews");
      final PostVideoReviewsResponse postVideoReviewsResponse = PostVideoReviewsResponse.fromJson(response.data);
      return postVideoReviewsResponse;
    }on DioError  catch (ex) {
      if(ex.type == DioErrorType.CONNECT_TIMEOUT){
        throw Exception("Connection  Timeout Exception");
      }
      print(ex.response.data['error']);
      throw Exception(ex.response.data['error']);
    } catch (error, stacktrace) {
      print("Exception occurred: $error stackTrace: $stacktrace");
      return PostVideoReviewsResponse.withError("Unknown error");
    }
  }

  Future<String> removeVideoReviews(int reviewId) async {
    try {
      dio.options.headers['content-Type'] = 'application/json';
      dio.options.headers["authorization"] = "Bearer ${getAccessToken()}";
      Response response = await dio.delete("/reviews/$reviewId");
      return response.data.toString();
    }on DioError  catch (ex) {
      if(ex.type == DioErrorType.CONNECT_TIMEOUT){
        throw Exception("Connection  Timeout Exception");
      }
      throw Exception(ex.message.toString());
    } catch (error, stacktrace) {
      print("Exception occurred: $error stackTrace: $stacktrace");
      return '';
    }
  }


}
