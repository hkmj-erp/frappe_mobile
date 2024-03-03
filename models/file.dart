import 'package:json_annotation/json_annotation.dart';

part 'file.g.dart';

@JsonSerializable()
class FrappeFile {
  FrappeFile(this.id, this.fileName, this.fileUrl);

  @JsonKey(name: "name")
  final String id;

  @JsonKey(name: "file_name")
  final String fileName;

  @JsonKey(name: "file_url")
  final String fileUrl;

  factory FrappeFile.fromJson(Map<String, dynamic> json) => _$FrappeFileFromJson(json);
  Map<String, dynamic> toJson() => _$FrappeFileToJson(this);
}
