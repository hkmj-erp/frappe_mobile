import 'package:firebase_messaging/firebase_messaging.dart';

class FCMNotificationState {}

class FCMInitialState extends FCMNotificationState {}

class FCMReceivedState extends FCMNotificationState {
  RemoteNotification notification;
  FCMReceivedState({required this.notification});
}
