import 'package:nx_play/src/models/comments/video_comment.dart';
import 'package:nx_play/src/models/links.dart';

class CommentReplies {
  final int currentPage;
  final List<ReplyData> replyData;
  final String firstPageUrl;
  final int from;
  final int lastPage;
  final String lastPageUrl;
  final List<Links> links;
  final Null nextPageUrl;
  final String path;
  final int perPage;
  final String prevPageUrl;
  final int to;
  final int total;

  CommentReplies(
      {this.currentPage,
        this.replyData,
        this.firstPageUrl,
        this.from,
        this.lastPage,
        this.lastPageUrl,
        this.links,
        this.nextPageUrl,
        this.path,
        this.perPage,
        this.prevPageUrl,
        this.to,
        this.total});

  CommentReplies.fromJson(Map<String, dynamic> json) :
      currentPage = json['current_page'],
      replyData = (json["data"] as List).map((i) => new ReplyData.fromJson(i)).toList(),
      firstPageUrl = json['first_page_url'],
      from = json['from'],
      lastPage = json['last_page'],
      lastPageUrl = json['last_page_url'],
      links = (json["links"] as List).map((i) => new Links.fromJson(i)).toList(),
      nextPageUrl = json['next_page_url'],
      path = json['path'],
      perPage = json['per_page'],
      prevPageUrl = json['prev_page_url'],
      to = json['to'],
      total = json['total'];


  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['current_page'] = this.currentPage;
    if (this.replyData != null) {
      data['data'] = this.replyData.map((v) => v.toJson()).toList();
    }
    data['first_page_url'] = this.firstPageUrl;
    data['from'] = this.from;
    data['last_page'] = this.lastPage;
    data['last_page_url'] = this.lastPageUrl;
    if (this.links != null) {
      data['links'] = this.links.map((v) => v.toJson()).toList();
    }
    data['next_page_url'] = this.nextPageUrl;
    data['path'] = this.path;
    data['per_page'] = this.perPage;
    data['prev_page_url'] = this.prevPageUrl;
    data['to'] = this.to;
    data['total'] = this.total;
    return data;
  }
}

class ReplyData {
  final int id;
  final int userId;
  final int videoId;
  final String commentText;
  final int parentId;
  final String createdAt;
  final User user;
  final List<CommentLikes> commentLikes;
  final List<CommentDislikes> commentDislikes;

  ReplyData(
      {this.id,
        this.userId,
        this.videoId,
        this.commentText,
        this.parentId,
        this.createdAt,
        this.user,
        this.commentLikes,
        this.commentDislikes});

  ReplyData.fromJson(Map<String, dynamic> json):
    id = json['id'],
    userId = json['user_id'],
    videoId = json['video_id'],
    commentText = json['comment_text'],
    parentId = json['parent_id'],
    createdAt = json['created_at'],
    user = User.fromJson(json['user']),
    commentLikes = (json["comment_likes"] as List).map((i) => new CommentLikes.fromJson(i)).toList(),
    commentDislikes = (json["comment_dislikes"] as List).map((i) => new CommentDislikes.fromJson(i)).toList();

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['video_id'] = this.videoId;
    data['comment_text'] = this.commentText;
    data['parent_id'] = this.parentId;
    data['created_at'] = this.createdAt;
    if (this.user != null) {
      data['user'] = this.user.toJson();
    }
    if (this.commentLikes != null) {
      data['comment_likes'] = this.commentLikes.map((v) => v.toJson()).toList();
    }
    if (this.commentDislikes != null) {
      data['comment_dislikes'] =
          this.commentDislikes.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

