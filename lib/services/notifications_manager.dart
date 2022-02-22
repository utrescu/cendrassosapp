import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import '../config_cendrassos.dart';

class NotificationManager {
  late FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;
  AndroidInitializationSettings? initializationSettingsAndroid;
  IOSInitializationSettings? initializationSettingsIOS;
  LinuxInitializationSettings? initializationSettingsLinux;
  InitializationSettings? initializationSettings;

  String? selectedNotificationPayload;

  NotificationManager() {
    flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
  }

  Future initNotificationManager() async {
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

  void selectNotification(String? payload) async {
    if (payload != null) {
      debugPrint('notification payload: $payload');
      selectedNotificationPayload = payload;
    }
  }

  Future<void> showNotification(String username, String nom) async {
    var androidPlatformChannelSpecifics = AndroidNotificationDetails(
      'CHANEL_ID',
      'CHANEL_NAME',
      channelDescription: 'CHANEL_DESCRIPTION',
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
      NomInstitut,
      'Notificacions al Djau de $nom',
      platformChannelSpecifics,
      payload: username,
    );
  }
}
