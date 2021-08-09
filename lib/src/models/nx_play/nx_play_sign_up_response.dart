import 'package:nx_play/src/models/nx_play/nx_play_sign_up.dart';

class NxPlaySignUpResponse{

  final NxPlaySignUp signUpInfo;
  final String error;

  NxPlaySignUpResponse(this.signUpInfo, this.error);

  NxPlaySignUpResponse.fromJson(dynamic json)
      : signUpInfo = NxPlaySignUp.fromJson(json),
        error = "";

  NxPlaySignUpResponse.withError(String errorValue)
      : signUpInfo = NxPlaySignUp(),
        error = errorValue;

}