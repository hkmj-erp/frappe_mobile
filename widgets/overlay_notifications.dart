import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:overlay_support/overlay_support.dart';

showOverlayAlert(String message) {
  showSimpleNotification(
    Text(message),
    background: Colors.red,
    duration: const Duration(seconds: 5),
    trailing: Builder(builder: (context) {
      return ElevatedButton(
          onPressed: () {
            OverlaySupportEntry.of(context)!.dismiss();
          },
          child: const Text('Dismiss'));
    }),
  );
}

showOverlayMessage(String message) {
  showSimpleNotification(
    Text(message),
    background: const Color.fromARGB(255, 57, 51, 2),
    duration: const Duration(seconds: 5),
    trailing: Builder(builder: (context) {
      return ElevatedButton(
          onPressed: () {
            OverlaySupportEntry.of(context)!.dismiss();
          },
          child: const Text('Dismiss'));
    }),
  );
}

showAppNotification(RemoteMessage message) {
  showSimpleNotification(
    Text(message.notification!.title!),
    subtitle: Text(
      message.notification!.body!,
    ),
    duration: const Duration(seconds: 5),
    slideDismissDirection: DismissDirection.vertical,
    trailing: Builder(builder: (context) {
      return ElevatedButton(
          onPressed: () {
            OverlaySupportEntry.of(context)!.dismiss();
            if (message.data["is_route"] == "1") {
              context.push(message.data["screen"]);
            } else {
              context.push("/notifications");
            }
          },
          child: const Text('Check'));
    }),
  );
}
