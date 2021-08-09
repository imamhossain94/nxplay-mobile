class NxPlaySignUp {
  final Data data;

  NxPlaySignUp({this.data});

  NxPlaySignUp.fromJson(Map<String, dynamic> json) :
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data.toJson();
    }
    return data;
  }
}

class Data {
  final String name;
  final String email;
  final String avatar;
  final String updatedAt;
  final String createdAt;
  final int id;

  Data(
      {this.name,
        this.email,
        this.avatar,
        this.updatedAt,
        this.createdAt,
        this.id});

  Data.fromJson(Map<String, dynamic> json) :
    name = json['name'],
    email = json['email'],
    avatar = json['avatar'],
    updatedAt = json['updated_at'],
    createdAt = json['created_at'],
    id = json['id'];

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['email'] = this.email;
    data['avatar'] = this.avatar;
    data['updated_at'] = this.updatedAt;
    data['created_at'] = this.createdAt;
    data['id'] = this.id;
    return data;
  }
}