import 'package:nx_play/src/models/profile/update_profile.dart';

class UpdateProfileResponse{

  final UpdateProfile updateProfile;
  final String error;

  UpdateProfileResponse(this.updateProfile, this.error);

  UpdateProfileResponse.fromJson(dynamic json)
      : updateProfile = UpdateProfile.fromJson(json),
        error = "";

  UpdateProfileResponse.withError(String errorValue)
      : updateProfile = UpdateProfile(),
        error = errorValue;

}