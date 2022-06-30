import 'dart:developer';

import 'package:cendrassos/api/notificacions_repository.dart';
import 'package:cendrassos/services/notifications_manager.dart';
import 'package:cendrassos/services/storage.dart';
import 'package:flutter/material.dart';

import '../models/login.dart';

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
    log("[Djau] Comprovant notificacions dels alumnes");
    for (var i = 0; i < alumnes.length; i++) {
      var data = await storage.loadAlumne(alumnes[i]);

      try {
        debugPrint("[checkNewNotifications] login: ${alumnes[i]}");
        var dadesLogin = Login(data.username, data.password);
        var response = await api.login(dadesLogin);

        debugPrint(
            "[checkNewNotifications] check: ${alumnes[i]} last time: $lastSync");
        var haveNews =
            await api.haveNewNotifications(lastSync, response.accessToken);
        debugPrint("[checkNewNotifications] news? $haveNews");
        if (haveNews) {
          manager.showNotification(i, data.username, data.nom);
        }
      } catch (e) {
        log("[Djau] Ha falat la comunició amb el servidor recuperant notificacions");
        return;
      }
    }
    await prefs.setLastOperationTime();
  }
}
