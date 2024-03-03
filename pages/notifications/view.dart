import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../extensions/extensions.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import '../../models/app_notification.dart';
import 'notifications_bloc.dart';

class NotificationsPage extends StatefulWidget {
  const NotificationsPage({super.key});

  @override
  State<NotificationsPage> createState() => _NotificationsPageState();
}

class _NotificationsPageState extends State<NotificationsPage> {
  List notifications = [];
  Map<String, dynamic> filters = {'page': 0};
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    context.read<NotificationsBloc>().add(filters);
    _scrollController.addListener(() {
      if (_scrollController.position.pixels == _scrollController.position.maxScrollExtent) {
        filters['page'] += 1;
        context.read<NotificationsBloc>().add(filters);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notifications'),
      ),
      body: BlocListener<NotificationsBloc, Map>(
        child: BlocBuilder<NotificationsBloc, Map>(
          builder: (context, state) {
            return Column(
              children: [
                Expanded(
                    child: ListView.separated(
                  separatorBuilder: (context, index) => const Divider(),
                  controller: _scrollController,
                  itemCount: notifications.length,
                  itemBuilder: (context, index) {
                    return NotificationsTile(
                      notification: notifications[index],
                    );
                  },
                )),
              ],
            );
          },
        ),
        listener: (context, event) {
          filters['page'] = event['page'];
          if (filters['page'] == 0) {
            setState(() {
              notifications = event['data'];
              _scrollController.jumpTo(0);
            });
          } else {
            setState(() {
              notifications = [...notifications, ...event['data']];
            });
          }
        },
      ),
    );
  }
}

class NotificationsTile extends StatelessWidget {
  final AppNotification notification;
  const NotificationsTile({Key? key, required this.notification}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        if (notification.isRoute) {
          context.push("${notification.route}");
        }
      },
      title: Text(
        notification.subject,
        style: context.textTheme.titleSmall!.copyWith(color: context.colorScheme.primary),
      ),
      subtitle: Text(
        notification.message,
        style: context.textTheme.bodySmall,
      ),
      leading: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.notifications, color: context.colorScheme.primary),
        ],
      ),
      trailing: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
        Text(
          DateFormat("hh:mm a").format(notification.creation),
          style: context.textTheme.labelMedium!,
        ),
        Text(
          DateFormat("dd MMM").format(notification.creation),
          style: context.textTheme.labelLarge!,
        ),
      ]),
    );
  }
}
