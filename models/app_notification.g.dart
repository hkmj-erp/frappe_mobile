// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_notification.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AppNotification _$AppNotificationFromJson(Map<String, dynamic> json) =>
    AppNotification(
      subject: json['subject'] as String,
      message: json['message'] as String,
      creation:
          const FrappeDateTimeConverter().fromJson(json['creation'] as String),
      isRoute: json['isRoute'] == null
          ? false
          : const FrappeBoolConverter().fromJson(json['isRoute'] as int),
    )..route = json['route'] as String?;

Map<String, dynamic> _$AppNotificationToJson(AppNotification instance) =>
    <String, dynamic>{
      'subject': instance.subject,
      'message': instance.message,
      'creation': const FrappeDateTimeConverter().toJson(instance.creation),
      'isRoute': const FrappeBoolConverter().toJson(instance.isRoute),
      'route': instance.route,
    };
