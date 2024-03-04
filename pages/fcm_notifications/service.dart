import 'package:dhananjaya/main.dart';
import 'package:dhananjaya/routes.dart';
import 'package:dhananjaya/services/frappe/frappe.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:go_router/go_router.dart';

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
    String? token = await FirebaseMessaging.instance.getToken();
    if (token != null) {
      await storeFirebaseAppToken(firebaseAppName,token);
    }
  }
}