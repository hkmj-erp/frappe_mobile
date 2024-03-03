import 'package:json_annotation/json_annotation.dart';

part 'frappeuser.g.dart';

@JsonSerializable()
class FrappeUser {
  @JsonKey(name: "full_name")
  String fullName;

  String email;

  @JsonKey(name: "mobile_no")
  String? mobileNo;

  @JsonKey(name: "user_image")
  String? profileImagePath;

  FrappeUser({required this.fullName, required this.email});

  factory FrappeUser.fromJson(Map<String, dynamic> json) => _$FrappeUserFromJson(json);
  Map<String, dynamic> toJson() => _$FrappeUserToJson(this);
}
