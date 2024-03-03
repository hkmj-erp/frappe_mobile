import 'package:devotee_diary/services/frappe/models/api.dart';
import 'package:hive_flutter/hive_flutter.dart';

Future<FrappeApi?> getApiFromStorage(String domain) async {
  final box = Hive.box<FrappeApi>('frappeApis');
  return box.get(domain);
}

saveApiInStorage(FrappeApi api) async {
  final box = Hive.box<FrappeApi>('frappeApis');
  await box.put(api.domain, api);
}

removeApiInStorage(FrappeApi api) async {
  final box = Hive.box<FrappeApi>('frappeApis');
  await box.delete(api.domain);
}
