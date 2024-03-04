import 'package:hive_flutter/hive_flutter.dart';

import 'models/credential.dart';

Future<FrappeCredential?> getApiFromStorage(String domain) async {
  final box = Hive.box<FrappeCredential>('frappeCreds');
  return box.get(domain);
}

saveApiInStorage(FrappeCredential api) async {
  final box = Hive.box<FrappeCredential>('frappeCreds');
  await box.put(api.domain, api);
}

removeApiInStorage(FrappeCredential api) async {
  final box = Hive.box<FrappeCredential>('frappeCreds');
  await box.delete(api.domain);
}
