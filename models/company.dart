import 'package:json_annotation/json_annotation.dart';

import '../formatters/frappe_bool_converter.dart';
part 'company.g.dart';

@JsonSerializable()
@FrappeBoolConverter()
class FrappeCompany {
  @JsonKey(name: "company")
  String name;

  String? logo;

  @JsonKey(name: "preacher_allowed_receipt_creation")
  bool allowed;

  FrappeCompany({required this.name, this.allowed = true});

  factory FrappeCompany.fromJson(Map<String, dynamic> json) => _$FrappeCompanyFromJson(json);
  Map<String, dynamic> toJson() => _$FrappeCompanyToJson(this);
}
