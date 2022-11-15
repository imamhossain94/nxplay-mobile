// import 'dart:convert';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter_dotenv/flutter_dotenv.dart';
// import 'package:github_auth/github_auth.dart';
// import 'package:nx_play/src/services/nx_play/nx_play_auth_service.dart';
// import 'package:nx_play/src/services/pref_service/shared_pref_service.dart';

// class GithubAuthService{
//   String githubClientId, githubClientService, githubCallbackUrl;
//   String error;
//   BuildContext context;

//   GithubAuthService({this.context}){
//     githubClientId = DotEnv().env['GITHUB_CLIENT_ID'];
//     githubClientService = DotEnv().env['GITHUB_CLIENT_SECRET'];
//     githubCallbackUrl = DotEnv().env['GITHUB_CALLBACK_URL'];
//   }

//   Future<bool> githubSignIn() async {
//     try{
//       await Firebase.initializeApp();
//       final auth = GithubAuth(
//         clientId: githubClientId,
//         clientSecret: githubClientService,
//         callbackUrl: githubCallbackUrl,
//         scope: 'user,gist,user:email',
//         clearCache: true,
//       );

//       try{
//         FlutterAuthResult response = await auth.login(context);
//         NxPlayAuthServices nxPlayServices = new NxPlayAuthServices();
//         var requestBody =jsonEncode({'id_token': response.token,});
//         debugPrint("Request Data : $requestBody");

//         var responseData = await nxPlayServices.getNxPlayGithubLogin(requestBody);
//         if(responseData != null){
//           debugPrint("Github Login Success $response");
//           saveNxPlayUser(responseData);
//           return true;
//         }else{
//           this.error = 'Github Login Failed';
//           return false;
//         }
//       } on FlutterAuthException catch(e) {
//         throw 'Github: Authentication Failed!';
//       }catch (e){
//         this.error = e;
//         return false;
//       }
//     } catch (error) {
//       print(error);
//       this.error = error;
//       return false;
//     }
//   }
// }