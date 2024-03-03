import 'package:json_annotation/json_annotation.dart';

class FrappeBoolConverter implements JsonConverter<bool, int> {
  const FrappeBoolConverter();

  @override
  bool fromJson(int json) => json == 1;

  @override
  int toJson(bool val) => val ? 1 : 0;
}
