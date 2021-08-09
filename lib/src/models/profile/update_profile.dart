class UpdateProfile {
  final ProfileData profileData;

  UpdateProfile({this.profileData});

  UpdateProfile.fromJson(Map<String, dynamic> json):
  profileData = ProfileData.fromJson(json['data']);

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.profileData != null) {
      data['data'] = this.profileData.toJson();
    }
    return data;
  }
}

class ProfileData {
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

  ProfileData(
      {this.id,
        this.name,
        this.email,
        this.emailVerifiedAt,
        this.providerId,
        this.avatar,
        this.role,
        this.createdAt,
        this.updatedAt,
        this.deletedAt});

  ProfileData.fromJson(Map<String, dynamic> json) :
    id = json['id'],
    name = json['name'],
    email = json['email'],
    emailVerifiedAt = json['email_verified_at'],
    providerId = json['provider_id'],
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