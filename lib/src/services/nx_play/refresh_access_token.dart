import 'package:flutter/cupertino.dart';
import 'package:nx_play/src/models/nx_play/refresh_token.dart';
import 'package:nx_play/src/services/nx_play/nx_play_auth_service.dart';
import 'package:nx_play/src/utils/token_expires_time.dart';
import 'package:nx_play/src/services/pref_service/shared_pref_service.dart';

class RefreshAccessTokenService{
  String error;

  Future<bool> refreshAccessToken() async {
    try{
      RefreshToken token = await getRefreshToken();
      if (token.accessToken != null) {
        TokenExpiresInTime().getCurrentTimeInMinute();
        if (token.tokenExpireInDate != TokenExpiresInTime.currentDate ||
            token.tokenExpireInSecond < TokenExpiresInTime.currentMinute) {
          NxPlayAuthServices nxPlayServices = new NxPlayAuthServices();
          debugPrint("Request Data : $token");
          try{
            var responseData = await nxPlayServices.getNxPlayRefreshToken(token);
            if(responseData != null){
              debugPrint("Token refresh Success $responseData");
              saveRefreshToken(responseData);
              return true;
            }else{
              this.error = 'Token refresh  Failed';
              return false;
            }
          }catch (e){
            this.error = e;
            return false;
          }
        } else {
          return true;
        }
      } else {
        return true;
      }
    } catch (error) {
      print(error);
      this.error = error.toString();
      return false;
    }
  }

}