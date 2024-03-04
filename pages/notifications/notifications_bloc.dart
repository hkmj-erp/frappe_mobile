import 'package:flutter_bloc/flutter_bloc.dart';

import '../../connect.dart';
import '../../models/app_notification.dart';
import '../../models/response.dart';

enum FetchingState { loading, done, failed }

class NotificationsBloc extends Bloc<Map, Map> {
  List notifications = [];
  Map filters = {'page': 0};

  NotificationsBloc(String firebaseApp, Map initial) : super(initial) {
    on<Map>((event, emit) async {
      filters = event;
      List<AppNotification> notifications =
          await getNotifications(firebaseApp, filters['page'].toString());
      emit({'data': notifications, 'page': filters['page'], 'state': FetchingState.done});
    });
  }

  Future<List<AppNotification>> getNotifications(String firebaseApp, String page) async {
    int pageLength = 12;
    int limitStart = int.parse(page) * pageLength;
    FrappeConnection frappeConnection = FrappeConnection.instance;
    FrappeResponse resp =
        await frappeConnection.getRequest(path: "/api/resource/App Notification", queryParameters: {
      'fields': '["*"]',
      'filters':
          '[["app","=","$firebaseApp"],["user", "=", "${FrappeConnection.loggedInUserId!}"]]',
      'order_by': 'creation desc',
      'limit_start': '$limitStart',
      'limit_page_length': '$pageLength'
    });
    return resp.data.map<AppNotification>((e) => AppNotification.fromJson(e)).toList();
  }
}
