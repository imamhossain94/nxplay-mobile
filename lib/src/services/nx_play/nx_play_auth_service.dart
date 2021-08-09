import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:nx_play/src/models/nx_play/nx_play_login_response.dart';
import 'package:nx_play/src/models/nx_play/nx_play_sign_up_response.dart';
import 'package:nx_play/src/models/nx_play/refresh_token_response.dart';
import 'package:nx_play/src/models/profile/update_profile_response.dart';
import 'package:nx_play/src/services/pref_service/shared_pref_service.dart';

class NxPlayAuthServices {
  Dio dio;
  String error;

  NxPlayAuthServices() {
    if (dio == null) {
      BaseOptions options = new BaseOptions(
          baseUrl: DotEnv().env['APP_URL'],
          receiveDataWhenStatusError: true,
          connectTimeout: 30*1000,
          receiveTimeout: 30*1000
      );
      dio = new Dio(options);
    }
  }

  Future<NxPlaySignUpResponse> getNxPlaySignUp(var requestData) async {
    try {
      Response response = await dio.post("/register", data: requestData);
      final NxPlaySignUpResponse signUpResponse = NxPlaySignUpResponse.fromJson(response.data);
      return signUpResponse;
    }on DioError  catch (ex) {
      if(ex.type == DioErrorType.CONNECT_TIMEOUT){
        throw 'Connection Timeout';
      }else if(ex.response.statusCode == 400){
        throw ex.response.data['email'].toString().replaceAll('\[', '').replaceAll('\]', '');
      }else{
        throw Exception(ex.message);
      }
    }
  }

  Future<NxPlayLoginResponse> getNxPlayLogin(var requestData) async {
    try {
      Response response = await dio.post("/login", data: requestData);
      final NxPlayLoginResponse loginResponse = NxPlayLoginResponse.fromJson(response.data);
      return loginResponse;
    }on DioError  catch (ex) {
      if(ex.type == DioErrorType.CONNECT_TIMEOUT){
        throw 'Connection Timeout';
      }else if(ex.response.statusCode == 401){
        throw 'Email or password may incorrect.';
      }else{
        throw Exception(ex.message);
      }
    }
  }

  Future<RefreshTokenResponse> getNxPlayRefreshToken(var token) async {
    try {
      BaseOptions options = new BaseOptions(
          baseUrl: DotEnv().env['APP_URL'],
          receiveDataWhenStatusError: true,
          connectTimeout: 5*1000,
          receiveTimeout: 5*1000
      );
      dio = new Dio(options);
      dio.options.headers['content-Type'] = 'application/json';
      dio.options.headers["authorization"] = "Bearer $token";
      Response response = await dio.post("/refresh");
      final RefreshTokenResponse tokenResponse = RefreshTokenResponse.fromJson(response.data);
      return tokenResponse;
    }on DioError  catch (ex) {
      if(ex.type == DioErrorType.CONNECT_TIMEOUT){
        throw 'Connection Timeout';
      }else if(ex.response.statusCode == 500){
        throw 'Server Error';
      }else{
        throw 'Token Error';
      }
    }
  }

  Future<NxPlayLoginResponse> getNxPlayGoogleLogin(var token) async {
    try {
      Response response = await dio.post("/google", data: token);
      final NxPlayLoginResponse loginResponse = NxPlayLoginResponse.fromJson(response.data);
      return loginResponse;
    }on DioError  catch (ex) {
      if(ex.type == DioErrorType.CONNECT_TIMEOUT){
        throw 'Connection Timeout';
      }else if(ex.response.statusCode == 400){
        throw "Google: Not found or id_token expired!";
      }else{
        throw Exception(ex.message);
      }
    }
  }

  Future<NxPlayLoginResponse> getNxPlayFacebookLogin(var token) async {
    try {
      Response response = await dio.post("/facebook", data: token);
      final NxPlayLoginResponse loginResponse = NxPlayLoginResponse.fromJson(response.data);
      return loginResponse;
    }on DioError  catch (ex) {
      if(ex.type == DioErrorType.CONNECT_TIMEOUT){
        throw 'Connection Timeout';
      }else if(ex.response.statusCode == 400){
        throw "Facebook: Not found or id_token expired!";
      }else{
        throw Exception(ex.message);
      }
    }
  }

  Future<NxPlayLoginResponse> getNxPlayGithubLogin(var token) async {
    try {
      Response response = await dio.post("/github", data: token);
      final NxPlayLoginResponse loginResponse = NxPlayLoginResponse.fromJson(response.data);
      print(loginResponse);
      return loginResponse;
    }on DioError  catch (ex) {
      if(ex.type == DioErrorType.CONNECT_TIMEOUT){
        throw 'Connection Timeout';
      }else if(ex.response.statusCode == 400){
        throw "GitHub: Not found or id_token expired!";
      }else{
        throw Exception(ex.message);
      }
    }
  }

  Future<UpdateProfileResponse> updateUserProfile(Map<String, String> queryParameters) async {
    try {
      dio.options.headers['content-Type'] = 'application/json';
      dio.options.headers["authorization"] = "Bearer ${getAccessToken()}";
      Response response = await dio.patch("/users/${getUserId()}", queryParameters: queryParameters);
      print(response.statusMessage);
      final UpdateProfileResponse updateProfileResponse = UpdateProfileResponse.fromJson(response.data);
      return updateProfileResponse;
    }on DioError  catch (ex) {
      if(ex.type == DioErrorType.CONNECT_TIMEOUT){
        throw Exception("Connection  Timeout Exception");
      }
      throw Exception(ex.message);
    } catch (error, stacktrace) {
      print("Exception occurred: $error stackTrace: $stacktrace");
      return UpdateProfileResponse.withError(error.toString());
    }
  }

}
