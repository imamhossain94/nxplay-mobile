class RefreshToken {
  final String accessToken;
  final String tokenType;
  final int expiresIn;
  var data;
  int tokenExpireInSecond;
  int tokenExpireInDate;

  RefreshToken({this.accessToken, this.tokenType, this.expiresIn, this.data, this.tokenExpireInSecond, this.tokenExpireInDate});

  RefreshToken.fromJson(Map<String, dynamic> json):
    accessToken = json['access_token'],
    tokenType = json['token_type'],
    expiresIn = json['expires_in'],
    data = json['data'];

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['access_token'] = this.accessToken;
    data['token_type'] = this.tokenType;
    data['expires_in'] = this.expiresIn;
    data['data'] = this.data;
    return data;
  }
}