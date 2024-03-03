import 'package:hive_flutter/hive_flutter.dart';

part 'credential.g.dart';

@HiveType(typeId: 0)
class FrappeCredential {
  @HiveField(0)
  String key;
  @HiveField(1)
  String secret;
  @HiveField(2)
  String domain;
  FrappeCredential({required this.key, required this.secret, required this.domain});
}
