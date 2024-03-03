import 'dart:io';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../../../routes.dart';
import '../../../widgets/overlay_notifications.dart';
import '../repository.dart';
import 'states.dart';

class FCMNotificationCubit extends Cubit<FCMNotificationState> {
  FirebaseMessaging? messaging;
  String firebaseAppName;
  FCMNotificationCubit({required this.firebaseAppName}) : super(FCMInitialState());

  initialise() async {
    messaging ??= FirebaseMessaging.instance;
    await messaging?.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );
    messaging?.onTokenRefresh.listen((event) {
      updateDeviceTokenToServer();
      //Fetch New Token and Update in Server
    });

    if (!Platform.isWindows) {
      messaging!.getInitialMessage().then((message) async => {
            if (message != null) {showAppNotification(message)},
          });
      FirebaseMessaging.onMessage.listen((RemoteMessage message) {
        showAppNotification(message);
      });
    }

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      if (message.data["is_route"] == "1") {
        navigatorKey.currentState?.context.push(message.data["screen"]);
      } else {
        navigatorKey.currentState?.context.push("/notifications");
      }
    });
  }

  updateDeviceTokenToServer() async {
    if (!Platform.isWindows) {
      String? token = await FirebaseMessaging.instance.getToken();
      if (token != null) {
        await storeFirebaseAppToken(firebaseAppName, token);
      }
    }
  }
}
