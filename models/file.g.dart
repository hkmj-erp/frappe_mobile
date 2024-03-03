// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'file.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FrappeFile _$FrappeFileFromJson(Map<String, dynamic> json) => FrappeFile(
      json['name'] as String,
      json['file_name'] as String,
      json['file_url'] as String,
    );

Map<String, dynamic> _$FrappeFileToJson(FrappeFile instance) =>
    <String, dynamic>{
      'name': instance.id,
      'file_name': instance.fileName,
      'file_url': instance.fileUrl,
    };
