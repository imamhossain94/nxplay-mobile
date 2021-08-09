import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:nx_play/src/services/nx_play/nx_play_auth_service.dart';


class NxPlaySignUpService{
  String accessToken, error, name, email, password;
  NxPlaySignUpService({this.name, this.email, this.password});

  Future<bool> nxPlaySignUp() async {
    try{
      NxPlayAuthServices nxPlayServices = new NxPlayAuthServices();
      var requestBody =jsonEncode({'name': name,'email': email, 'password': password,});
      debugPrint("Request Data : $requestBody");
      try{
        var responseData = await nxPlayServices.getNxPlaySignUp(requestBody);
        if(responseData != null){
          debugPrint("Sign up Success $responseData");
          return true;
        }else{
          this.error = 'Sign up Failed';
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