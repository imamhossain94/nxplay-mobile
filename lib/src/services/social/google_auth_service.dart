import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:nx_play/src/services/nx_play/nx_play_auth_service.dart';
import 'package:nx_play/src/services/pref_service/shared_pref_service.dart';


class GoogleAuthService{
  GoogleSignIn _googleSignIn;
  String accessToken, error;

  GoogleAuthService(){
    if(_googleSignIn==null){
      _googleSignIn = GoogleSignIn(
        scopes: <String>[
          'email',
          'https://www.googleapis.com/auth/contacts.readonly',
        ],
      );
    }
  }

  Future<bool> googleSignIn() async {
    try{
      try{
        return await _googleSignIn.signIn().then((result) async {
          try{
            await result.authentication.then((googleKey) async {
              NxPlayAuthServices nxPlayServices = new NxPlayAuthServices();
              var requestBody =jsonEncode({'id_token': googleKey.idToken,});
              debugPrint("Request Data : $requestBody");
              try{
                var response = await nxPlayServices.getNxPlayGoogleLogin(requestBody);
                if(response != null){
                  debugPrint("Google SignIn Success $response");
                  saveNxPlayUser(response);
                  return true;
                }else{
                  this.error = 'Google SignIn failed';
                  return false;
                }
              }catch (e){
                this.error = e;
                return false;
              }
            });
          }catch (e){
            print(e.toString());
            throw 'Process Is Canceled';
          }
        }).then((value) => true);
      }catch (e){
        print(e.toString());
        throw 'Process Is Canceled';
      }
    } catch (error) {
      print(error);
      this.error = error;
      return false;
    }
  }

  Future<bool> googleSignOut() async{
    try{
      return await _googleSignIn.disconnect().then((value) => true);
    }catch(e){
      print(e);
      return false;
    }
  }
}