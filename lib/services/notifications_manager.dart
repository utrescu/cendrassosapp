import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import '../config_cendrassos.dart';

class NotificationManager {
  late FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;
  AndroidInitializationSettings? initializationSettingsAndroid;
  DarwinInitializationSettings? initializationSettingsIOS;
  LinuxInitializationSettings? initializationSettingsLinux;
  InitializationSettings? initializationSettings;

  String? selectedNotificationPayload;

  static const channelId = "123";

  NotificationManager() {
    flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
  }

  Future initNotificationManager(Function(String? p) selectNotification) async {
    initializationSettingsAndroid =
        const AndroidInitializationSettings('app_icon');
    initializationSettingsIOS = const DarwinInitializationSettings(
        requestSoundPermission: false,
        requestBadgePermission: false,
        requestAlertPermission: false,
        onDidReceiveLocalNotification: null); // selectNotification);
    initializationSettingsLinux = const LinuxInitializationSettings(
        defaultActionName: 'Open notification');
    initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsIOS,
      linux: initializationSettingsLinux,
    );

    await flutterLocalNotificationsPlugin
        .initialize(initializationSettings!); //,
           //onDidReceiveNotificationResponse: onDidReceiveNotificationResponse); <-- TODO: On vaig quan hi cliquen (basat en selectedNotification)
  }

  // void onDidReceiveNotificationResponse(NotificationResponse notificationResponse) async {
  //     final String? payload = notificationResponse.payload;
  //     if (notificationResponse.payload != null) {
  //       debugPrint('notification payload: $payload');
  //     }
  //     await Navigator.push(
  //       context,
  //       MaterialPageRoute<void>(builder: (context) => SecondScreen(payload)),
  //     );
  // }

  Future<void> showNotification(id, String username, String nom) async {
    var androidPlatformChannelSpecifics = const AndroidNotificationDetails(
      channelId,
      appName,
      channelDescription: 'Notificacions del Djau',
      importance: Importance.max,
      priority: Priority.high,
    );
    var iOSPlatformChannelSpecifics = const DarwinNotificationDetails();
    var platformChannelSpecifics = NotificationDetails(
      android: androidPlatformChannelSpecifics,
      iOS: iOSPlatformChannelSpecifics,
    );
    await flutterLocalNotificationsPlugin.show(
      id,
      nomInstitut,
      'Notificacions al Djau de $nom',
      platformChannelSpecifics,
      payload: username,
    );
  }
}
