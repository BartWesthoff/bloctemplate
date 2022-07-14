import 'dart:typed_data';

import 'package:bloctemplate/src/config/notifications/local/forwarded_notification.dart';
import 'package:bloctemplate/src/config/notifications/received_notification.dart';
import 'package:bloctemplate/src/core/helper/imagehelper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:rxdart/subjects.dart';
import 'package:timezone/timezone.dart' as tz;

class LocalNotificationService {
  String? payload;

  LocalNotificationService({this.payload}) {
    init();
  }

  void init() async {
    await flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onSelectNotification: (String? _payload) async {
        if (_payload != null) {
          debugPrint('notification payload: $_payload');
        }
        payload = _payload;
        selectNotificationSubject.add(_payload);
      },
    );
  }

  static Future<void> areNotificationsEnabledOnAndroid(
    BuildContext context,
  ) async {
    final bool? areEnabled = await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.areNotificationsEnabled();
    await showDialog<void>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        content: Text(
          areEnabled == null
              ? 'ERROR: received null'
              : (areEnabled
                  ? 'Notifications are enabled'
                  : 'Notifications are NOT enabled'),
        ),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  // static Future<NotificationAppLaunchDetails?> getNotificationAppLaunchDetails() async{
  //   final NotificationAppLaunchDetails? notificationAppLaunchDetails = !kIsWeb &&
  //       Platform.isLinux
  //       ? null
  //       : await flutterLocalNotificationsPlugin.getNotificationAppLaunchDetails();
  //   return notificationAppLaunchDetails;
  // }

  static void handleNotification(BuildContext context) {
    selectNotificationSubject.stream.listen((String? payload) async {
      debugPrint("push notification payload: $payload");
      await Navigator.pushNamed(context, '/secondPage');
    });
  }

  static Future<void> showNotification({
    required ForwardedNotification notification,
  }) async {
    DefaultStyleInformation? styleInformation;
    String largeIconPath = "";
    const String groupKey = 'com.android.example.GROUP';
    const String groupChannelId = 'grouped channel id';
    const String groupChannelName = 'grouped channel name';
    const String groupChannelDescription = 'grouped channel description';

    const List<String> lines = <String>['line <b>1</b>', 'line <i>2</i>'];
    // picture given
    if (notification.picture != null) {
      if (!notification.hasAccess) {
        final ByteArrayAndroidBitmap largeIcon = ByteArrayAndroidBitmap(
          await ImageHelper.getByteArrayFromUrl(notification.largeIconURL),
        );
        final ByteArrayAndroidBitmap bigPicture = ByteArrayAndroidBitmap(
          await ImageHelper.getByteArrayFromUrl(notification.bigPictureURL),
        );
        styleInformation = BigPictureStyleInformation(
          bigPicture,
          largeIcon: largeIcon,
          contentTitle: notification.title,
          htmlFormatContentTitle: true,
          hideExpandedLargeIcon: true,
          summaryText: notification.summaryText,
          htmlFormatSummaryText: true,
        );
      } else {
        largeIconPath = await ImageHelper.downloadAndSaveFile(
          notification.largeIconURL,
          notification.largeIconFileName,
        );
        final String bigPicturePath = await ImageHelper.downloadAndSaveFile(
          notification.bigPictureURL,
          notification.bigPictureFileName,
        );
        styleInformation = BigPictureStyleInformation(
          FilePathAndroidBitmap(bigPicturePath),
          largeIcon: FilePathAndroidBitmap(largeIconPath),
          contentTitle: notification.bigTitle,
          htmlFormatContentTitle: true,
          summaryText: notification.summaryText,
          htmlFormatSummaryText: true,
          hideExpandedLargeIcon: true,
        );
      }
    }
    // picture not given
    else {
      styleInformation = InboxStyleInformation(
        lines,
        htmlFormatLines: true,
        contentTitle: notification.title,
        htmlFormatContentTitle: true,
        htmlFormatSummaryText: true,
      );
    }

    final AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails(
      groupChannelId,
      groupChannelName,
      channelDescription: groupChannelDescription,
      importance: Importance.max,
      priority: Priority.high,
      groupKey: groupKey,
      visibility: NotificationVisibility.public,
      enableLights: true,
      ledColor: const Color.fromARGB(255, 255, 138, 0),
      ledOnMs: 1000,
      largeIcon:
          notification.hasAccess ? FilePathAndroidBitmap(largeIconPath) : null,
      ledOffMs: 500,
      styleInformation: styleInformation,
    );

    final String bigPicturePath = await ImageHelper.downloadAndSaveFile(
      notification.bigPictureURL,
      notification.bigPictureFileName,
    );

    final IOSNotificationDetails iOSPlatformChannelSpecifics =
        IOSNotificationDetails(
      subtitle: notification.subtitle,
      badgeNumber: 1,
      threadIdentifier: groupKey,
      attachments: <IOSNotificationAttachment>[
        IOSNotificationAttachment(bigPicturePath)
      ],
    );
    final MacOSNotificationDetails macOSPlatformChannelSpecifics =
        MacOSNotificationDetails(
      subtitle: notification.subtitle,
      badgeNumber: 1,
      threadIdentifier: groupKey,
      attachments: <MacOSNotificationAttachment>[
        MacOSNotificationAttachment(bigPicturePath)
      ],
    );
    final NotificationDetails platformChannelSpecifics = NotificationDetails(
      iOS: iOSPlatformChannelSpecifics,
      macOS: macOSPlatformChannelSpecifics,
      android: androidPlatformChannelSpecifics,
    );

    if (notification.delay > 0) {
      await flutterLocalNotificationsPlugin.zonedSchedule(
        0,
        notification.title,
        notification.body,
        tz.TZDateTime.now(tz.local)
            .add(Duration(seconds: 0 + notification.delay)),
        platformChannelSpecifics,
        androidAllowWhileIdle: true,
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime,
      );
    } else {
      await flutterLocalNotificationsPlugin.show(
        0,
        notification.title,
        notification.body,
        platformChannelSpecifics,
        payload: notification.payload,
      );
    }
  }

  static void requestPermissions() {
    flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            IOSFlutterLocalNotificationsPlugin>()
        ?.requestPermissions(
          alert: true,
          badge: true,
          sound: true,
        );
    flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            MacOSFlutterLocalNotificationsPlugin>()
        ?.requestPermissions(
          alert: true,
          badge: true,
          sound: true,
        );
  }

  static Future<void> showInsistentNotification() async {
    // This value is from: https://developer.android.com/reference/android/app/Notification.html#FLAG_INSISTENT
    const int insistentFlag = 8;
    final AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails(
      'your channel id',
      'your channel name',
      channelDescription: 'your channel description',
      importance: Importance.max,
      priority: Priority.high,
      ticker: 'ticker',
      additionalFlags: Int32List.fromList(<int>[insistentFlag]),
    );
    final NotificationDetails platformChannelSpecifics =
        NotificationDetails(android: androidPlatformChannelSpecifics);
    await flutterLocalNotificationsPlugin.show(
      0,
      'insistent title',
      'insistent body',
      platformChannelSpecifics,
      payload: 'item x',
    );
  }

  static Future<void> scheduleDailyTenAMNotification() async {
    await flutterLocalNotificationsPlugin.zonedSchedule(
      0,
      'daily scheduled notification title',
      'daily scheduled notification body',
      LocalNotificationService.nextInstanceOfTenAM(),
      const NotificationDetails(
        android: AndroidNotificationDetails(
          'daily notification channel id',
          'daily notification channel name',
          channelDescription: 'daily notification description',
        ),
      ),
      androidAllowWhileIdle: true,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
      matchDateTimeComponents: DateTimeComponents.dateAndTime,
      // matchDateTimeComponents: DateTimeComponents.dayOfMonthAndTime, monthly
      // matchDateTimeComponents: DateTimeComponents.dayOfWeekAndTime, for week
    );
  }

  static Future<void> checkPendingNotificationRequests(
    BuildContext context,
  ) async {
    final List<PendingNotificationRequest> pendingNotificationRequests =
        await flutterLocalNotificationsPlugin.pendingNotificationRequests();
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        content: Text(
          '${pendingNotificationRequests.length} pending notification '
          'requests',
        ),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  static Future<void> repeatNotification(RepeatInterval repeatInterval) async {
    const AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails(
      'repeating channel id',
      'repeating channel name',
      channelDescription: 'repeating description',
    );
    const NotificationDetails platformChannelSpecifics =
        NotificationDetails(android: androidPlatformChannelSpecifics);
    await flutterLocalNotificationsPlugin.periodicallyShow(
      0,
      'repeating title',
      'repeating body',
      repeatInterval,
      platformChannelSpecifics,
      androidAllowWhileIdle: true,
    );
  }

  static tz.TZDateTime nextInstanceOfTenAM() {
    final tz.TZDateTime now = tz.TZDateTime.now(tz.local);
    tz.TZDateTime scheduledDate =
        tz.TZDateTime(tz.local, now.year, now.month, now.day, 10);
    if (scheduledDate.isBefore(now)) {
      scheduledDate = scheduledDate.add(const Duration(days: 1));
    }
    return scheduledDate;
  }

// String get payload => payload;
// set payload(String payload) => this.payload = payload;
}

final BehaviorSubject<String?> selectNotificationSubject =
    BehaviorSubject<String?>();

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

final BehaviorSubject<ReceivedNotification> didReceiveLocalNotificationSubject =
    BehaviorSubject<ReceivedNotification>();

const AndroidInitializationSettings initializationSettingsAndroid =
    AndroidInitializationSettings('icon');

/// Note: permissions aren't requested here just to demonstrate that can be
/// done later
final IOSInitializationSettings initializationSettingsIOS =
    IOSInitializationSettings(
  // requestAlertPermission: true,
  // requestBadgePermission: true,
  // requestSoundPermission: true,
  onDidReceiveLocalNotification: (
    int id,
    String? title,
    String? body,
    String? payload,
  ) async {
    didReceiveLocalNotificationSubject.add(
      ReceivedNotification(
        id: id,
        title: title,
        body: body,
        payload: payload,
      ),
    );
  },
);
const MacOSInitializationSettings initializationSettingsMacOS =
    MacOSInitializationSettings(
        // requestAlertPermission: false,
        // requestBadgePermission: false,
        // requestSoundPermission: false,
        );
final LinuxInitializationSettings initializationSettingsLinux =
    LinuxInitializationSettings(
  defaultActionName: 'Open notification',
  defaultIcon: AssetsLinuxIcon('assets/icons/app_icon.png'),
);
final InitializationSettings initializationSettings = InitializationSettings(
  android: initializationSettingsAndroid,
  iOS: initializationSettingsIOS,
  macOS: initializationSettingsMacOS,
  linux: initializationSettingsLinux,
);
