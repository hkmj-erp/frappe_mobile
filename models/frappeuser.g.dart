// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'frappeuser.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FrappeUser _$FrappeUserFromJson(Map<String, dynamic> json) => FrappeUser(
      fullName: json['full_name'] as String,
      email: json['email'] as String,
    )
      ..mobileNo = json['mobile_no'] as String?
      ..profileImagePath = json['user_image'] as String?;

Map<String, dynamic> _$FrappeUserToJson(FrappeUser instance) =>
    <String, dynamic>{
      'full_name': instance.fullName,
      'email': instance.email,
      'mobile_no': instance.mobileNo,
      'user_image': instance.profileImagePath,
    };
