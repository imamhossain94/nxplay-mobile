
import 'package:nx_play/src/models/nx_play/refresh_token.dart';

class RefreshTokenResponse{

  final RefreshToken refreshToken;
  final String error;

  RefreshTokenResponse(this.refreshToken, this.error);

  RefreshTokenResponse.fromJson(dynamic json)
      : refreshToken = RefreshToken.fromJson(json),
        error = "";

  RefreshTokenResponse.withError(String errorValue)
      : refreshToken = RefreshToken(),
        error = errorValue;

}