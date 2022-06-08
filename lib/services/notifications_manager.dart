import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import '../config_cendrassos.dart';

class NotificationManager {
  late FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;
  AndroidInitializationSettings? initializationSettingsAndroid;
  IOSInitializationSettings? initializationSettingsIOS;
  LinuxInitializationSettings? initializationSettingsLinux;
  InitializationSettings? initializationSettings;

  String? selectedNotificationPayload;

  static const channelId = "123";

  NotificationManager() {
    flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
  }

  Future initNotificationManager(Function(String? p) selectNotification) async {
    initializationSettingsAndroid = AndroidInitializationSettings('app_icon');
    initializationSettingsIOS = IOSInitializationSettings();
    initializationSettingsLinux =
        LinuxInitializationSettings(defaultActionName: 'Open notification');
    initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsIOS,
      linux: initializationSettingsLinux,
    );

    await flutterLocalNotificationsPlugin.initialize(initializationSettings!,
        onSelectNotification: selectNotification);
  }

  Future<void> showNotification(String username, String nom) async {
    var androidPlatformChannelSpecifics = AndroidNotificationDetails(
      channelId,
      appName,
      channelDescription: 'Notificacions del Djau',
      importance: Importance.max,
      priority: Priority.high,
    );
    var iOSPlatformChannelSpecifics = IOSNotificationDetails();
    var platformChannelSpecifics = NotificationDetails(
      android: androidPlatformChannelSpecifics,
      iOS: iOSPlatformChannelSpecifics,
    );
    await flutterLocalNotificationsPlugin.show(
      0,
      nomInstitut,
      'Notificacions al Djau de $nom',
      platformChannelSpecifics,
      payload: username,
    );
  }
}
