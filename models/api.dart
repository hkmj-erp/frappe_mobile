import 'package:hive_flutter/hive_flutter.dart';

part 'api.g.dart';

@HiveType(typeId: 0)
class FrappeApi {
  @HiveField(0)
  String key;
  @HiveField(1)
  String secret;
  @HiveField(2)
  String domain;
  FrappeApi({required this.key, required this.secret, required this.domain});
}
