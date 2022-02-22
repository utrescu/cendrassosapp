import 'package:cendrassos/api/notificacions_repository.dart';
import 'package:cendrassos/services/notifications_manager.dart';
import 'package:cendrassos/services/storage.dart';

class BackgroundTask {
  NotificationManager manager = NotificationManager();
  NotificacionsRepository api = NotificacionsRepository();
  DjauLocalStorage prefs = DjauLocalStorage();
  DjauSecureStorage storage = DjauSecureStorage();

  Future<void> checkNewNotificacions() async {
    await manager.initNotificationManager();
    var alumnes = await prefs.getAlumnesList();
    for (var i = 0; i < alumnes.length; i++) {
      var data = await storage.getAlumne(alumnes[i]);
      if (await api.areNewNotifications(data.token)) {
        manager.showNotification(data.username, data.nom);
      }
    }
  }
}
