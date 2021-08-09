class LikeComment {
  final int status;
  final int likes;
  final int dislikes;

  LikeComment({this.status, this.likes, this.dislikes});

  LikeComment.fromJson(Map<String, dynamic> json) :
    status = json['status'],
    likes = json['likes'],
    dislikes = json['dislikes'];

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['likes'] = this.likes;
    data['dislikes'] = this.dislikes;
    return data;
  }
}