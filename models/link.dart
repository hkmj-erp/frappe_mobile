import 'package:json_annotation/json_annotation.dart';

part 'link.g.dart';

@JsonSerializable()
class ERPLink {
  String value;
  String description;

  ERPLink({required this.value, required this.description});

  factory ERPLink.fromJson(Map<String, dynamic> json) => _$ERPLinkFromJson(json);
  Map<String, dynamic> toJson() => _$ERPLinkToJson(this);
}
