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
    await manager.initNotificationManager(goto);
    var alumnes = await prefs.getAlumnesList();
    for (var i = 0; i < alumnes.length; i++) {
      var data = await storage.getAlumne(alumnes[i]);
      if (await api.areNewNotifications(data)) {
        debugPrint('[BackgroundFetch] $alumnes[i] Si');
        await manager.showNotification(i, data.username, data.nom);
        data.updateLastSyncDate();
        await storage.saveAlumne(data);
      }
    }
  }
}
