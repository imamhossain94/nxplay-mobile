import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:nx_play/src/services/nx_play/nx_play_auth_service.dart';
import 'package:nx_play/src/services/pref_service/shared_pref_service.dart';


class NxPlayLogInService{
  String accessToken, error, email, password;
  NxPlayLogInService({this.email, this.password});
  Future<bool> nxPlayLogIn() async {
    try{
      NxPlayAuthServices nxPlayServices = new NxPlayAuthServices();
      var requestBody =jsonEncode({'email': email, 'password': password,});
      debugPrint("Request Data : $requestBody");

      try{
        var responseData = await nxPlayServices.getNxPlayLogin(requestBody);
        if(responseData != null){
          debugPrint("Login Success $responseData");
          saveNxPlayUser(responseData);
          return true;
        }else{
          this.error = 'Login Failed';
          return false;
        }
      }catch (e){
        this.error = e;
        return false;
      }
    } catch (error) {
      print(error);
      this.error = error;
      return false;
    }
  }

}