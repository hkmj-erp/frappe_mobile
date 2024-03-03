import '../connect.dart';
import '../models/frappeuser.dart';
import '../models/response.dart';

Future<FrappeUser> getUserProfile() async {
  FrappeConnection frappeConnection = FrappeConnection.instance;
  FrappeResponse resp = await frappeConnection.getRequest(
      path: 'api/resource/User/${FrappeConnection.loggedInUserId}');

  return FrappeUser.fromJson(resp.data);
}

Future<List<String>> getUserRoles() async {
  FrappeConnection frappeConnection = FrappeConnection.instance;
  FrappeResponse resp = await frappeConnection.getRequest(
      path: 'api/method/frappe.core.doctype.user.user.get_roles',
      queryParameters: {"uid": FrappeConnection.loggedInUserId});
  return resp.data.map<String>((e) => e as String).toList();
}

updateUserProfile(Map<String, dynamic> updateValues) async {
  FrappeConnection frappeConnection = FrappeConnection.instance;
  FrappeResponse resp = await frappeConnection.putRequest(
    path: 'api/resource/User/${FrappeConnection.loggedInUserId}',
    body: updateValues,
  );
  return FrappeUser.fromJson(resp.data);
}
