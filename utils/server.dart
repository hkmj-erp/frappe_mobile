import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import '../connect.dart';
import '../models/models.dart';

Future<List<ERPLink>> searchDocumentOptions(
    {required String doctype, String query = "", Map filters = const {}}) async {
  FrappeConnection erpConnection = FrappeConnection.instance;

  FrappeResponse resp = await erpConnection.postRequest(
      path: 'api/method/frappe.desk.search.search_link',
      body: {'doctype': doctype, 'txt': '', 'filters': jsonEncode(filters), 'page_length': '100'});

  if (!resp.failed) {
    return resp.data.map<ERPLink>((value) => ERPLink.fromJson(value)).toList();
  }
  return [];
}

Future<String?> getabsoulteImagePath(String filePath) async {
  if (filePath == "") {
    return null;
  }
  String url = "";

  if (filePath.contains("http")) {
    url = filePath;
  } else {
    url = "https://${FrappeConnection.connectionApi!.domain}$filePath";
  }
  return url;
}

Future<String?> getabsoulteFilePath(String filePath) async {
  if (filePath == "") {
    return null;
  }
  String url = "";

  if (filePath.contains("http")) {
    url = filePath;
  } else {
    url = "https://${FrappeConnection.connectionApi!.domain}$filePath";
  }
  return url;
}

attachImageToDocument(
    {required String docType,
    required String name,
    required String docField,
    required String folder,
    required String filePath}) async {
  Map<String, dynamic> data = {
    "doctype": docType,
    "name": name,
    "field": docField,
    "folder": folder
  };

  var url = Uri.https(FrappeConnection.connectionApi!.domain,
      'api/method/hkm.mobile_app.utils.attach_image_to_doc');

  var request = http.MultipartRequest("POST", url);
  request.headers.addAll({
    'Authorization':
        'Token ${FrappeConnection.connectionApi!.key}:${FrappeConnection.connectionApi!.secret}'
  });

  request.fields['data'] = jsonEncode(data);

  await http.MultipartFile.fromPath(
    'image',
    filePath,
    contentType: MediaType('image', '*'),
  ).then((value) => request.files.add(value));

  http.StreamedResponse response = await request.send();
  var responseD = await http.Response.fromStream(response);
  // print(responseD.body);
  if (response.statusCode == 200) {
    return true;
  } else {
    return false;
  }
}

Future<FrappeResponse> getUserProfile() async {
  FrappeConnection frappeConnection = FrappeConnection.instance;
  FrappeResponse resp = await frappeConnection.getRequest(
      path: 'api/resource/User/${FrappeConnection.loggedInUserId}');
  return resp;
}

Future<List<String>> getUserRoles() async {
  FrappeConnection frappeConnection = FrappeConnection.instance;
  FrappeResponse resp = await frappeConnection.getRequest(
      path: 'api/method/frappe.core.doctype.user.user.get_roles',
      queryParameters: {"uid": FrappeConnection.loggedInUserId});
  return resp.data.map<String>((e) => e as String).toList();
}

Future<FrappeResponse> updateUserProfile(Map<String, dynamic> updateValues) async {
  FrappeConnection frappeConnection = FrappeConnection.instance;
  FrappeResponse resp = await frappeConnection.putRequest(
    path: 'api/resource/User/${FrappeConnection.loggedInUserId}',
    body: updateValues,
  );
  return resp;
}
