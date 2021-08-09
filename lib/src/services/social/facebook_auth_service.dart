import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:nx_play/src/services/nx_play/nx_play_auth_service.dart';
import 'package:nx_play/src/services/pref_service/shared_pref_service.dart';


class FacebookAuthService{
  AccessToken _accessToken;
  String accessToken, error;

  Future<bool> facebookSignIn() async {
    try{
      _accessToken = await FacebookAuth.instance.isLogged;
      if(_accessToken != null){
        try{
          final userData = await FacebookAuth.instance.getUserData(fields: "id,name,email,picture.type(large)");
          return await _facebookSignIn(userData['id'], _accessToken.toJson()['token']);
        }catch (e){
          throw 'Facebook Authentication Failed!';
        }
      }else{
        try{
          _accessToken = await FacebookAuth.instance.login();
          if(_accessToken != null){
            final userData = await FacebookAuth.instance.getUserData(fields: "id,name,email,picture.type(large)");
            return await _facebookSignIn(userData['id'], _accessToken.toJson()['token']);
          }else{
            this.error = 'access token is null';
          }
        }catch (e){
          throw 'Facebook Authentication Failed!';
        }
      }
    }catch (error) {
      print(error);
      this.error = error;
      return false;
    }
  }

  Future<bool> _facebookSignIn(String id, String token) async{
    try{
      NxPlayAuthServices nxPlayServices = new NxPlayAuthServices();
      var requestBody =jsonEncode({'id': id,'id_token': token});
      debugPrint("Request Data : $requestBody");
      try{
        var response = await nxPlayServices.getNxPlayFacebookLogin(requestBody);
        if(response != null){
          debugPrint("Facebook Login Success $response");
          saveNxPlayUser(response);
          return true;
        }else{
          this.error = 'Facebook Login failed';
          return false;
        }
      }catch (e){
        this.error = e;
        return false;
      }
    } catch(error){
      this.error = error.message;
      return false;
    }
  }

  Future<bool> facebookSignOut() async{
    try{
      print('Facebook: SignOut');
      return await FacebookAuth.instance.logOut().then((value) => true);
    }catch(e){
      print('Facebook: $e');
      return false;
    }
  }
}