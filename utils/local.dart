import 'dart:math';

import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';
import 'package:location/location.dart';

bool validatePAN(String pan) {
  pan = pan.replaceAll(' ', '');
  RegExp regex = RegExp(r'^[a-zA-Z]{5}[0-9]{4}[a-zA-Z]{1}$');
  return regex.hasMatch(pan);
}

bool validateAadhar(String aadhar) {
  aadhar = aadhar.replaceAll(' ', '');
  RegExp regex = RegExp(r'^[0-9]{12}$');
  return regex.hasMatch(aadhar);
}

Future<Map<String, String>?> getCurrentLocation() async {
  Location location = Location();

  bool serviceEnabled;
  PermissionStatus permissionGranted;
  LocationData locationData;

  serviceEnabled = await location.serviceEnabled();
  if (!serviceEnabled) {
    serviceEnabled = await location.requestService();
    if (!serviceEnabled) {
      return null;
    }
  }

  permissionGranted = await location.hasPermission();
  if (permissionGranted == PermissionStatus.denied) {
    permissionGranted = await location.requestPermission();
    if (permissionGranted != PermissionStatus.granted) {
      return null;
    }
  }
  locationData = await location.getLocation();

  return {
    'longitude': (locationData.longitude ?? 0.0).toString(),
    'latitude': (locationData.latitude ?? 0.0).toString()
  };
}

String generateRandomString(int len) {
  var r = Random();
  String randomString = String.fromCharCodes(List.generate(len, (index) => r.nextInt(33) + 89));
  return randomString;
}

Future<String> getOcrTexts(String filePath) async {
  final textRecognizer = TextRecognizer(script: TextRecognitionScript.latin);
  final RecognizedText recognizedText =
      await textRecognizer.processImage(InputImage.fromFilePath(filePath));

  String text = recognizedText.text;
  return text;
}
