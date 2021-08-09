import 'package:nx_play/src/models/comments/comment_replies.dart';

class CommentRepliesResponse{

  final CommentReplies commentReplies;
  final String error;

  CommentRepliesResponse(this.commentReplies, this.error);

  CommentRepliesResponse.fromJson(dynamic json)
      : commentReplies = CommentReplies.fromJson(json),
        error = "";

  CommentRepliesResponse.withError(String errorValue)
      : commentReplies = CommentReplies(),
        error = errorValue;
}