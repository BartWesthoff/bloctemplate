import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class LocalNotificationService {
  static final FlutterLocalNotificationsPlugin _notificationsPlugin =
      FlutterLocalNotificationsPlugin();

  static void initialize() {
    const InitializationSettings initializationSettings =
        InitializationSettings(
      android: AndroidInitializationSettings("@mipmap/ic_launcher"),
    );

    _notificationsPlugin.initialize(initializationSettings);
  }

  static void display(RemoteMessage message) {
    final id = DateTime.now().millisecondsSinceEpoch ~/ 1000;
    const NotificationDetails notificationDetails = NotificationDetails(
      android: AndroidNotificationDetails(
        "Planner",
        "Planner channel",
        importance: Importance.max,
        priority: Priority.high,
        subText: "this is a notification",
      ),
    );

    _notificationsPlugin.show(
      id,
      message.notification!.title,
      message.notification!.body,
      notificationDetails,
    );
  }
}
