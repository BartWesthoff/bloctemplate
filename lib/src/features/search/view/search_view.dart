import 'package:bloctemplate/src/config/notifications/local/forwarded_notification.dart';
import 'package:bloctemplate/src/config/notifications/local/local_notifications.dart';
import 'package:flutter/material.dart';

class Feature2View extends StatelessWidget {
  const Feature2View({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(),
          ElevatedButton(
            onPressed: () => LocalNotificationService.showNotification(
              notification: ForwardedNotification(
                hasAccess: true,
                subtitle: "subtitle",
                payload: "sent to search",
                bigTitle: "this is big title",
                summaryText: "this is a summary",
                title: "this is a title",
                body: "this is a body",

              ),
            ),
            child: const Text("sent notification"),
          ),
        ],
      ),
    );
  }
}
