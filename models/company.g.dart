// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'company.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FrappeCompany _$FrappeCompanyFromJson(Map<String, dynamic> json) =>
    FrappeCompany(
      name: json['company'] as String,
      allowed: json['preacher_allowed_receipt_creation'] == null
          ? true
          : const FrappeBoolConverter()
              .fromJson(json['preacher_allowed_receipt_creation'] as int),
    )..logo = json['logo'] as String?;

Map<String, dynamic> _$FrappeCompanyToJson(FrappeCompany instance) =>
    <String, dynamic>{
      'company': instance.name,
      'logo': instance.logo,
      'preacher_allowed_receipt_creation':
          const FrappeBoolConverter().toJson(instance.allowed),
    };
