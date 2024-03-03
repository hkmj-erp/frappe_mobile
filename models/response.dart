import 'package:http/http.dart';

class FrappeResponse extends Response {
  bool failed;
  @override
  String body;
  dynamic data;
  FrappeError? error;
  FrappeResponse({this.failed = false, this.data, required this.body}) : super(body, 200);
}

class FrappeError {
  late String title;
  late String description;
  FrappeError({required this.title, required this.description});
}