import 'package:intl/intl.dart';
import 'package:json_annotation/json_annotation.dart';

class FrappeDateTimeConverter implements JsonConverter<DateTime, String> {
  const FrappeDateTimeConverter();

  @override
  DateTime fromJson(String json) {
    if (json.contains(".")) {
      json = json.substring(0, json.length - 1);
    }

    return DateTime.parse(json);
  }

  @override
  String toJson(DateTime json) => DateFormat('yyyy-MM-dd').format(json);
}
