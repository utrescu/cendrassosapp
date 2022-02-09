import 'dart:async';

import 'package:cendrassos/api/api_response.dart';
import 'package:cendrassos/models/notificacio.dart';
import 'package:cendrassos/notificacions_repository.dart';



class NotificacioBloc {
  NotificacionsRepository _notificacioRepository = NotificacionsRepository();

  StreamController _notificacioListController = StreamController<ApiResponse<List<Notificacio>>>();

  StreamSink get notificationsListSink =>
      _notificacioListController.sink;

  Stream get notificationsListStream =>
      _notificacioListController.stream;

  NotificacioBloc() {
    _notificacioListController = StreamController<ApiResponse<List<Notificacio>>>();
    _notificacioRepository = NotificacionsRepository();
    fetchNotificacions(DateTime.now().month);
  }

  fetchNotificacions(int mes) async {
    notificationsListSink.add(ApiResponse.loading('Recuperant notificacions'));
    try {
      List<Notificacio> movies = await _notificacioRepository.getNotifications(mes);
      notificationsListSink.add(ApiResponse.completed(movies));
    } catch (e) {
      notificationsListSink.add(ApiResponse.error(e.toString()));
      print(e);
    }
  }

  dispose() {
    _notificacioListController.close();
  }
}