import 'package:nx_play/src/models/comments/video_comment.dart';
import 'package:nx_play/src/models/links.dart';

class VideoReviews {
  int currentPage;
  List<ReviewData> reviewData;
  String firstPageUrl;
  int from;
  int lastPage;
  String lastPageUrl;
  List<Links> links;
  String nextPageUrl;
  String path;
  int perPage;
  String prevPageUrl;
  int to;
  int total;

  VideoReviews(
      {this.currentPage,
        this.reviewData,
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

  VideoReviews.fromJson(Map<String, dynamic> json) {
    currentPage = json['current_page'];
    if (json['data'] != null) {
      reviewData = new List<ReviewData>();
      json['data'].forEach((v) {
        reviewData.add(new ReviewData.fromJson(v));
      });
    }
    firstPageUrl = json['first_page_url'];
    from = json['from'];
    lastPage = json['last_page'];
    lastPageUrl = json['last_page_url'];
    if (json['links'] != null) {
      links = new List<Links>();
      json['links'].forEach((v) {
        links.add(new Links.fromJson(v));
      });
    }
    nextPageUrl = json['next_page_url'];
    path = json['path'];
    perPage = json['per_page'];
    prevPageUrl = json['prev_page_url'];
    to = json['to'];
    total = json['total'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['current_page'] = this.currentPage;
    if (this.reviewData != null) {
      data['data'] = this.reviewData.map((v) => v.toJson()).toList();
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

class ReviewData {
  int id;
  int userId;
  int videoId;
  String title;
  String body;
  String rating;
  String createdAt;
  User user;

  ReviewData(
      {this.id,
        this.userId,
        this.videoId,
        this.title,
        this.body,
        this.rating,
        this.createdAt,
        this.user});

  ReviewData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    videoId = json['video_id'];
    title = json['title'];
    body = json['body'];
    rating = json['rating'];
    createdAt = json['created_at'];
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['video_id'] = this.videoId;
    data['title'] = this.title;
    data['body'] = this.body;
    data['rating'] = this.rating;
    data['created_at'] = this.createdAt;
    if (this.user != null) {
      data['user'] = this.user.toJson();
    }
    return data;
  }
}

