import 'dart:async';

import 'package:dio/dio.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class FcmNotificationService {

  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
  final streamCtlr = StreamController<Map<dynamic, dynamic>>.broadcast();

  static Future<dynamic> onBackgroundMessage(Map<String, dynamic> message) async {
    if (message.containsKey('data')) {
      // Handle data message
      final dynamic data = message['data'];
    }

    if (message.containsKey('notification')) {
      // Handle notification message
      final dynamic notification = message['notification'];
    }

    // Or do other work.
  }

  setNotifications()  {
    _firebaseMessaging.configure(
      onMessage: (message) async {
        print("onMessage: $message");

        //streamCtlr.sink.add(message['data']['comment_text']);
      },
      onBackgroundMessage: onBackgroundMessage,
      onLaunch: (message) async {
        print("onLaunch: $message");
        streamCtlr.sink.add(message['data']);
      },
      onResume:(message) async {
        print("onResume: $message");
        streamCtlr.sink.add(message['data']);
      },
    );

    final token =  _firebaseMessaging.getToken().then((value) =>  print(value));

  }

  dispose(){
    streamCtlr?.close();
  }
}