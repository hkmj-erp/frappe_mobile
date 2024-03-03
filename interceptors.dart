import 'dart:convert';
import 'package:http_interceptor/http_interceptor.dart';
import 'models/response.dart';
import 'widgets/overlay_notifications.dart';

class ErrorInterceptor implements InterceptorContract {
  bool popError;
  ErrorInterceptor({this.popError = true});
  @override
  Future<bool> shouldInterceptRequest() async => false;

  @override
  Future<bool> shouldInterceptResponse() async => true;

  @override
  Future<BaseRequest> interceptRequest({required BaseRequest request}) async {
    return request;
  }

  @override
  Future<BaseResponse> interceptResponse({required BaseResponse response}) async {
    if (response is Response) {
      final formattedResponse = FrappeResponse(body: response.body);
      Map decoded = jsonDecode(response.body);
      if ([200, 202].contains(response.statusCode)) {
        if (decoded.containsKey('message')) {
          formattedResponse.data = decoded['message'];
        } else if (decoded.containsKey('data')) {
          formattedResponse.data = decoded['data'];
        } else if (decoded.containsKey('results')) {
          formattedResponse.data = decoded['results'];
        }
      } else {
        formattedResponse.failed = true;
        if (decoded.containsKey("exception")) {
          if (decoded["exception"].contains("frappe.exceptions")) {
            int colonIndex = decoded["exception"].indexOf(': ');
            String extractedMessage = colonIndex != -1
                ? decoded["exception"].substring(colonIndex + 2).trim()
                : decoded["exception"];
            formattedResponse.error =
                FrappeError(title: "Exception", description: extractedMessage);
          } else {
            formattedResponse.error =
                FrappeError(title: "Exception", description: decoded["exception"]);
          }
        } else if (decoded.containsKey('exc_type')) {
          formattedResponse.error =
              FrappeError(title: decoded['exc_type'], description: decoded['_server_messages']);
        } else {
          formattedResponse.error =
              FrappeError(title: "Unknown", description: "Untracebale Error! Contact Admin.");
        }
        formattedResponse.error!.description =
            formattedResponse.error!.description.replaceAll(RegExp(r'<(.*?)>'), "");
        if (popError) showOverlayAlert(formattedResponse.error!.description);
      }
      return formattedResponse;
    }
    return response;
  }
}
