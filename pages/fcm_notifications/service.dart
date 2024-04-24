import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:go_router/go_router.dart';

import '../../../../main.dart';
import '../../../../routes.dart';
import '../../frappe.dart';

class FCMNotificationService {
  FirebaseMessaging? messaging;

  initialize() async {
    messaging ??= FirebaseMessaging.instance;
    await messaging?.requestPermission(
      alert: true,
      badge: true,
      sound: true,
    );
    messaging?.onTokenRefresh.listen((event) {
      updateDeviceTokenToServer();
      //Fetch New Token and Update in Server
    });

    messaging!.getInitialMessage().then((message) async => {
          if (message != null) {showAppNotification(message)},
        });
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      showAppNotification(message);
    });
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      if (message.data["is_route"] == "1") {
        navigatorKey.currentState?.context.push(message.data["screen"]);
      } else {
        navigatorKey.currentState?.context.push("/notifications");
      }
    });
  }

  updateDeviceTokenToServer() async {
    String? token;
    if (kIsWeb) {
      token = Firebase.apps.first.options.measurementId;
    } else {
      token = await FirebaseMessaging.instance.getToken();
    }

    if (token != null) {
      await storeFirebaseAppToken(firebaseAppName, token);
    }
  }
}
