class PostVideoComments {
  int userId;
  String videoId;
  String commentText;
  String parentId;

  PostVideoComments({this.userId, this.videoId, this.commentText, this.parentId});

  PostVideoComments.fromJson(Map<String, dynamic> json) :
    userId = json['user_id'],
    videoId = json['video_id'],
    commentText = json['comment_text'],
    parentId = json['parent_id'];


  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['user_id'] = this.userId;
    data['video_id'] = this.videoId;
    data['comment_text'] = this.commentText;
    data['parent_id'] = this.parentId;
    return data;
  }
}