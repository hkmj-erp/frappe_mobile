import 'dart:convert';
import 'dart:io';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/foundation.dart';

import '../../connect.dart';
import '../../models/response.dart';

getDeviceInfo() async {
  String? deviceName;
  String? deviceId;
  if (kIsWeb) {
    deviceName = "Web";
    deviceId = "Chrome";
  } else {
    var deviceInfo = DeviceInfoPlugin();
    if (Platform.isIOS) {
      var iosDeviceInfo = await deviceInfo.iosInfo;
      deviceName = iosDeviceInfo.name; // unique ID on iOS
      deviceId = iosDeviceInfo.identifierForVendor; // unique ID on iOS
    } else if (Platform.isAndroid) {
      var androidDeviceInfo = await deviceInfo.androidInfo;
      deviceName = androidDeviceInfo.model; // unique ID on Android
      deviceId = androidDeviceInfo.id; // unique ID on Android
    }
  }
  return {"name": deviceName, "id": deviceId};
}

storeFirebaseAppToken(String firebaseApp, String token) async {
  final deviceInfo = await getDeviceInfo();

  var data = {
    'user': FrappeConnection.loggedInUserId!,
    'token': token,
    'app': firebaseApp,
    "device_id": deviceInfo["id"] ?? "",
    "device_name": deviceInfo["name"] ?? ""
  };
  final resp = await FrappeConnection.instance
      .getRequest(path: "api/resource/Firebase App Token", queryParameters: {
    "filters": jsonEncode(data),
  });
  List<String> entries = resp.data.map<String>((e) => e["name"] as String).toList();
  print(entries);
  if (entries.isEmpty) {
    await FrappeConnection.instance
        .postRequest(path: "api/resource/Firebase App Token", body: data, popError: false);
  }
}

removeFirebaseTokenFromFrappeServer(String firebaseApp) async {
  FrappeConnection frappeConnection = FrappeConnection.instance;

  final deviceInfo = await getDeviceInfo();

  FrappeResponse resp =
      await frappeConnection.getRequest(path: "api/resource/Firebase App Token", queryParameters: {
    "filters": jsonEncode({
      "user": FrappeConnection.loggedInUserId,
      "app": firebaseApp,
      "device_id": deviceInfo["id"],
      "device_name": deviceInfo["name"]
    }),
    "fields": jsonEncode(["name"])
  });

  for (var t in resp.data) {
    await frappeConnection.deleteRequest(path: "api/resource/Firebase App Token/${t['name']}");
  }
}
