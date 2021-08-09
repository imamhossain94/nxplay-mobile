class LikeVideo {
  final int status;
  final int likes;
  final int dislikes;

  LikeVideo({this.status, this.likes, this.dislikes});

  LikeVideo.fromJson(Map<String, dynamic> json) :
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