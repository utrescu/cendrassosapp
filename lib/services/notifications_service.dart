import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import '../config_cendrassos.dart';

class NotificationService {
  static final NotificationService _notificationService =
      NotificationService._internal();

  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  factory NotificationService() {
    return _notificationService;
  }

  NotificationService._internal();

  static const channel_id = "123";

  Future<void> init(
      Future<dynamic> Function(int, String?, String?, String?)?
          onDidReceive) async {
    final AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('app_icon');

    final IOSInitializationSettings initializationSettingsIOS =
        IOSInitializationSettings(onDidReceiveLocalNotification: onDidReceive);

    final InitializationSettings initializationSettings =
        InitializationSettings(
            android: initializationSettingsAndroid,
            iOS: initializationSettingsIOS,
            macOS: null);
    await flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onSelectNotification: selectNotification);
  }

  void selectNotification(String? payload) async {
    if (payload != null) {
      // TODO: Fer alguna cosa
      //selectedNotificationPayload = payload;
    }
  }

  Future<void> showNotification(String username, String nom) async {
    var androidPlatformChannelSpecifics = AndroidNotificationDetails(
      channel_id,
      AppName,
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
      username.hashCode,
      NomInstitut,
      'Noves notificacions al Djau de $nom',
      platformChannelSpecifics,
      payload: username,
    );
  }
}
