import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';

class TokenMonitor {
  static String? token = '';
  static late Stream<String> _tokenStream;

  static void setToken(String? tokenNew) {
    print('FCM Token: $tokenNew');
    token = tokenNew;
  }

  static refreshToken() async {



    try {
      _tokenStream = FirebaseMessaging.instance.onTokenRefresh;
      _tokenStream.listen(setToken);
      if (kIsWeb) {
        await FirebaseMessaging.instance
            .getToken(
            vapidKey:
            'BFZszdyEbe_pkbFRqx33N63_ddrnLwXVpSPPOYz14XTw-vGI9uHgvKt8-f43BPMh89viY264wkyjVfW8x1zdiyI')
            .then(setToken);
      } else {
        if (Platform.isIOS) {
          await FirebaseMessaging.instance.getToken().then(setToken);
        } else {
          await FirebaseMessaging.instance.getToken().then(setToken);
        }
      }
      // _tokenStream = FirebaseMessaging.instance.onTokenRefresh;
      // _tokenStream.listen(setToken);
    } catch (e) {
      print('Error getting FCM token: $e');
    }
  }
}
