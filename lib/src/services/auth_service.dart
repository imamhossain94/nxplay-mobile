import 'dart:async';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'package:http/http.dart' as http;

class AuthServices {
  String id, name, email, image;
  String accessToken, error, tokenType;
  int tokenExpireInSecond, tokenExpireInDate;

  AuthServices(
      {this.accessToken,
      this.error,
      this.id,
      this.tokenType,
      this.tokenExpireInSecond,
      this.tokenExpireInDate});

  Future<bool> forgotPassword(String email) async {
    final url = DotEnv().env['APP_URL'];
    Map<String, String> body = {
      'email': email,
    };

    var response = await http.post('$url/forgot-password', body: body);
    if (response.statusCode == 200) {
      return true;
    } else {
      this.error = 'Something wrong!';
      return false;
    }
  }
}
