import 'package:nx_play/src/models/links.dart';

class VideoComments {
  final int currentPage;
  final List<CommentsData> commentsData;
  final String firstPageUrl;
  final int from;
  final int lastPage;
  final String lastPageUrl;
  final List<Links> links;
  final String nextPageUrl;
  final String path;
  final int perPage;
  final String prevPageUrl;
  final int to;
  final int total;

  VideoComments(
      {this.currentPage,
        this.commentsData,
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

  VideoComments.fromJson(Map<String, dynamic> json) :
    currentPage = json['current_page'],
    commentsData = (json["data"] as List).map((i) => new CommentsData.fromJson(i)).toList(),
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
    if (this.commentsData != null) {
      data['data'] = this.commentsData.map((v) => v.toJson()).toList();
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

class CommentsData {
  final int id;
  final int userId;
  final int videoId;
  final String commentText;
  final int parentId;
  final String createdAt;
  //final List<Replies> replies;
  final User user;
  final int repliesCount;
  final int commentLikesCount;
  final int commentDislikesCount;
  final List<CommentLikes> commentLikes;
  final List<CommentDislikes> commentDislikes;

  CommentsData({this.id,
        this.userId,
        this.videoId,
        this.commentText,
        this.parentId,
        this.createdAt,
        //this.replies,
        this.user,
        this.repliesCount,
        this.commentLikesCount,
        this.commentDislikesCount,
        this.commentLikes,
        this.commentDislikes});

  CommentsData.fromJson(Map<String, dynamic> json) :
    id = json['id'],
    userId = json['user_id'],
    videoId = json['video_id'],
    commentText = json['comment_text'],
    parentId = json['parent_id'],
    createdAt = json['created_at'],
    //replies = (json["replies"] as List).map((i) => new Replies.fromJson(i)).toList(),
    user = User.fromJson(json['user']),
    repliesCount = json['replies_count'],
    commentLikesCount = json['comment_likes_count'],
    commentDislikesCount = json['comment_dislikes_count'],
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
    data['replies_count'] = this.repliesCount;
    data['comment_likes_count'] = this.commentLikesCount;
    data['comment_dislikes_count'] = this.commentDislikesCount;
    // if (this.replies != null) {
    //   data['replies'] = this.replies.map((v) => v.toJson()).toList();
    // }
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

class Replies {
  final int id;
  final int userId;
  final int videoId;
  final String commentText;
  final int parentId;
  final String createdAt;
  final User user;
  final List<CommentLikes> commentLikes;
  final List<CommentDislikes> commentDislikes;

  Replies(
      {this.id,
        this.userId,
        this.videoId,
        this.commentText,
        this.parentId,
        this.createdAt,
        this.user,
        this.commentLikes,
        this.commentDislikes});

  Replies.fromJson(Map<String, dynamic> json):
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

class User {
  final int id;
  final String name;
  final String avatar;

  User({this.id, this.name, this.avatar});

  User.fromJson(Map<String, dynamic> json):
    id = json['id'],
    name = json['name'],
    avatar = json['avatar'];

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['avatar'] = this.avatar;
    return data;
  }
}

class CommentLikes {
  final int id;
  final int commentId;
  final int userId;
  final int status;

  CommentLikes({this.id, this.commentId, this.userId, this.status});

  CommentLikes.fromJson(Map<String, dynamic> json):
    id = json['id'],
    commentId = json['comment_id'],
    userId = json['user_id'],
    status = json['status'];

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['comment_id'] = this.commentId;
    data['user_id'] = this.userId;
    data['status'] = this.status;
    return data;
  }
}

class CommentDislikes {
  final int id;
  final int commentId;
  final int userId;
  final int status;

  CommentDislikes({this.id, this.commentId, this.userId, this.status});

  CommentDislikes.fromJson(Map<String, dynamic> json):
        id = json['id'],
        commentId = json['comment_id'],
        userId = json['user_id'],
        status = json['status'];

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['comment_id'] = this.commentId;
    data['user_id'] = this.userId;
    data['status'] = this.status;
    return data;
  }
}
