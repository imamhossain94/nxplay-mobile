class NxPlayLogin {
  final String accessToken;
  final String tokenType;
  final int expiresIn;
  final Data data;

  NxPlayLogin({this.accessToken, this.tokenType, this.expiresIn, this.data});

  NxPlayLogin.fromJson(Map<String, dynamic> json):
    accessToken = json['access_token'],
    tokenType = json['token_type'],
    expiresIn = json['expires_in'],
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['access_token'] = this.accessToken;
    data['token_type'] = this.tokenType;
    data['expires_in'] = this.expiresIn;
    if (this.data != null) {
      data['data'] = this.data.toJson();
    }
    return data;
  }
}

class Data {
  final int id;
  final String name;
  final String email;
  final String emailVerifiedAt;
  final String providerId;
  final String avatar;
  final int role;
  final String createdAt;
  final String updatedAt;
  final String deletedAt;

  Data({this.id,
        this.name,
        this.email,
        this.emailVerifiedAt,
        this.providerId,
        this.avatar,
        this.role,
        this.createdAt,
        this.updatedAt,
        this.deletedAt});

  Data.fromJson(Map<String, dynamic> json):
    id = json['id'],
    name = json['name'],
    email = json['email'],
    emailVerifiedAt = json['email_verified_at'],
    providerId = json['provider_id'].toString(),
    avatar = json['avatar'],
    role = json['role'],
    createdAt = json['created_at'],
    updatedAt = json['updated_at'],
    deletedAt = json['deleted_at'];


  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['email'] = this.email;
    data['email_verified_at'] = this.emailVerifiedAt;
    data['provider_id'] = this.providerId;
    data['avatar'] = this.avatar;
    data['role'] = this.role;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['deleted_at'] = this.deletedAt;
    return data;
  }
}