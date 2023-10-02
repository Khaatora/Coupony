import 'dart:developer';

import 'package:firebase_messaging/firebase_messaging.dart';

class FirebaseApi{
  final _firebaseMessaging = FirebaseMessaging.instance;

  Future<void> initNotifications() async{
    await _firebaseMessaging.requestPermission();
    final fCMToken = await _firebaseMessaging.getToken();
    log("token: $fCMToken");
    FirebaseMessaging.onBackgroundMessage(handleBackgroundMessage);
  }


  Future<void> handleBackgroundMessage(RemoteMessage message) async{
    log("Title: ${message.notification?.title}");
    log("Title: ${message.notification?.body}");
    log("Payload: ${message.data}");
  }
}