import 'package:cendrassos/api/notificacions_repository.dart';
import 'package:cendrassos/services/notifications_manager.dart';
import 'package:cendrassos/services/storage.dart';
import 'package:flutter/material.dart';

class BackgroundTask {
  NotificationManager manager = NotificationManager();
  NotificacionsRepository api = NotificacionsRepository();
  DjauLocalStorage prefs = DjauLocalStorage();
  DjauSecureStorage storage = DjauSecureStorage();

  Future<void> checkNewNotificacions(dynamic Function(String? p) goto) async {
    debugPrint("[checkNewNotifications] starting");
    await manager.initNotificationManager(goto);
    var lastSync = await prefs.getLastOperationTime();
    var alumnes = await prefs.getAlumnesList();
    for (var i = 0; i < alumnes.length; i++) {
      debugPrint(
          "[checkNewNotifications] check: ${alumnes[i]} last time: $lastSync");
      var data = await storage.getAlumne(alumnes[i]);
      var haveNews = await api.haveNewNotifications(lastSync, data.token);
      debugPrint("[checkNewNotifications] news? $haveNews");
      if (haveNews) {
        manager.showNotification(i, data.username, data.nom);
      }
    }
    await prefs.setLastOperationTime();
  }
}
