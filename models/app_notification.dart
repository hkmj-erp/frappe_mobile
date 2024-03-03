import 'package:json_annotation/json_annotation.dart';

import '../formatters/frappe_bool_converter.dart';
import '../formatters/frappe_datetime_converter.dart';

part 'app_notification.g.dart';

@JsonSerializable()
@FrappeBoolConverter()
@FrappeDateTimeConverter()
class AppNotification {
  String subject;
  String message;
  DateTime creation;
  bool isRoute;
  String? route;
  AppNotification({required this.subject, required this.message,required this.creation, this.isRoute = false});

  factory AppNotification.fromJson(Map<String, dynamic> json) => _$AppNotificationFromJson(json);
  Map<String, dynamic> toJson() => _$AppNotificationToJson(this);
}