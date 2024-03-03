import 'package:firebase_messaging/firebase_messaging.dart';

class FCMNotificationEvent {}

class FCMNotificationInitialize extends FCMNotificationEvent {}

class FCMNotificationReceivedEvent extends FCMNotificationEvent {
  RemoteNotification notification;
  FCMNotificationReceivedEvent({required this.notification});
}

class FCMTokenUpdateEvent extends FCMNotificationEvent {}
