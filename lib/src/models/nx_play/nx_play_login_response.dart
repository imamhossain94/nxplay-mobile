import 'package:nx_play/src/models/nx_play/nx_play_login.dart';

class NxPlayLoginResponse{

  final NxPlayLogin logInInfo;
  final String error;

  NxPlayLoginResponse(this.logInInfo, this.error);

  NxPlayLoginResponse.fromJson(dynamic json)
      : logInInfo = NxPlayLogin.fromJson(json),
        error = "";

  NxPlayLoginResponse.withError(String errorValue)
      : logInInfo = NxPlayLogin(),
        error = errorValue;

}