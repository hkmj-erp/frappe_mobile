import 'package:devotee_diary/services/frappe/interceptors.dart';
import 'package:devotee_diary/services/frappe/models/response.dart';
import 'package:http/http.dart' as http;
import 'models/api.dart';
import 'storage.dart';
import 'package:http_interceptor/http_interceptor.dart';

class FrappeConnection {
  http.Client client = http.Client();
  static FrappeApi? connectionApi;
  static String? loggedInUserId;
  static FrappeConnection? _connectionInstance;

  FrappeConnection._();
  static FrappeConnection get instance => _connectionInstance ?? FrappeConnection._();

  static initialise() {
    _connectionInstance ??= FrappeConnection._();
  }

  setupApi({required FrappeApi receivedApi}) async {
    connectionApi = receivedApi;
    await connect();
  }

  connect() async {
    String userPath = "api/method/frappe.auth.get_logged_user";
    FrappeConnection frappeConnection = FrappeConnection.instance;
    FrappeResponse resp = await frappeConnection.getRequest(path: userPath);
    if (resp.failed) {
      throw Exception('Couldn\'t Connect : ${resp.error!.description}');
    } else {
      loggedInUserId = resp.data;
    }
  }

  static destroyConnectioninstance() async {
    removeApiInStorage(connectionApi!);
    connectionApi = null;
    _connectionInstance = null;
  }

  validateRequest() {
    if (connectionApi == null) {
      throw Exception('There are no API set to access Frappe.');
    }
  }

  Future<FrappeResponse> getRequest(
      {required String path,
      Map<String, dynamic>? queryParameters,
      Map<String, String>? additionalHeaders,
      bool popError = true}) async {
    validateRequest();
    Map<String, String> headers = {
      'Authorization': 'token ${connectionApi!.key}:${connectionApi!.secret}'
    };
    if (additionalHeaders != null) {
      headers.addEntries(additionalHeaders.entries);
    }

    Uri uri = Uri.https(connectionApi!.domain, path, queryParameters);
    // final http = InterceptedHttp.build(interceptors: [
    //   ErrorInterceptor(),
    // ]);
    Client client = InterceptedClient.build(interceptors: [
      ErrorInterceptor(popError: popError),
    ]);
    FrappeResponse resp = (await client.get(uri, headers: headers)) as FrappeResponse;
    return resp;
  }

  Future<FrappeResponse> postRequest(
      {required String path,
      Map<String, String>? additionalHeaders,
      Object? body,
      bool popError = true}) async {
    validateRequest();
    Map<String, String> headers = {
      'Authorization': 'token ${connectionApi!.key}:${connectionApi!.secret}'
    };
    if (additionalHeaders != null) {
      headers.addEntries(additionalHeaders.entries);
    }
    Uri uri = Uri.https(connectionApi!.domain, path);
    final http = InterceptedHttp.build(interceptors: [
      ErrorInterceptor(popError: popError),
    ]);
    return (await http.post(uri, headers: headers, body: body)) as FrappeResponse;
  }

  Future<FrappeResponse> putRequest({
    required String path,
    Map<String, String>? additionalHeaders,
    Object? body,
  }) async {
    validateRequest();
    Map<String, String> headers = {
      'Authorization': 'token ${connectionApi!.key}:${connectionApi!.secret}'
    };
    if (additionalHeaders != null) {
      headers.addEntries(additionalHeaders.entries);
    }
    Uri uri = Uri.https(connectionApi!.domain, path);
    final http = InterceptedHttp.build(interceptors: [
      ErrorInterceptor(),
    ]);
    return (await http.put(uri, headers: headers, body: body)) as FrappeResponse;
  }

  Future<FrappeResponse> deleteRequest({
    required String path,
    Map<String, String>? additionalHeaders,
  }) async {
    validateRequest();
    Map<String, String> headers = {
      'Authorization': 'token ${connectionApi!.key}:${connectionApi!.secret}'
    };
    if (additionalHeaders != null) {
      headers.addEntries(additionalHeaders.entries);
    }
    Uri uri = Uri.https(connectionApi!.domain, path);
    final http = InterceptedHttp.build(interceptors: [
      ErrorInterceptor(),
    ]);
    return (await http.delete(uri, headers: headers)) as FrappeResponse;
  }
}
