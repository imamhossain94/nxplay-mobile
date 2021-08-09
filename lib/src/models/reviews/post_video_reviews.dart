class PostVideoReviews {
  int userId;
  String videoId;
  String title;
  String body;
  String rating;
  String updatedAt;
  String createdAt;
  int id;

  PostVideoReviews({
    this.userId,
    this.videoId,
    this.title,
    this.body,
    this.rating,
    this.updatedAt,
    this.createdAt,
    this.id});

  PostVideoReviews.fromJson(Map<String, dynamic> json) :
    userId = json['user_id'],
    videoId = json['video_id'],
    title = json['title'],
    body = json['body'],
    rating = json['rating'],
    updatedAt = json['updated_at'],
    createdAt = json['created_at'],
    id = json['id'];


  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['user_id'] = this.userId;
    data['video_id'] = this.videoId;
    data['title'] = this.title;
    data['body'] = this.body;
    data['rating'] = this.rating;
    data['updated_at'] = this.updatedAt;
    data['created_at'] = this.createdAt;
    data['id'] = this.id;
    return data;
  }
}