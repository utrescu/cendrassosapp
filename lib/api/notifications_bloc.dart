import 'dart:async';

import 'package:cendrassos/api/api_response.dart';
import 'package:cendrassos/models/notificacio.dart';
import 'package:cendrassos/api/notificacions_repository.dart';

class NotificacioBloc {
  String _token = "";
  NotificacionsRepository _notificacioRepository = NotificacionsRepository();
  StreamController<ApiResponse<List<Notificacio>>> _notificacioListController =
      StreamController<ApiResponse<List<Notificacio>>>();

  StreamSink<ApiResponse<List<Notificacio>>> get notificationsListSink =>
      _notificacioListController.sink;

  Stream<ApiResponse<List<Notificacio>>> get notificationsListStream =>
      _notificacioListController.stream;

  NotificacioBloc(String token) {
    _notificacioListController =
        StreamController<ApiResponse<List<Notificacio>>>();
    _notificacioRepository = NotificacionsRepository();
    _token = token;
    fetchNotificacions(DateTime.now().month);
  }

  fetchNotificacions(int mes) async {
    notificationsListSink
        .add(ApiResponse.loading('Recuperant notificacions', []));
    try {
      var movies = await _notificacioRepository.getNotifications(mes, _token);
      notificationsListSink.add(ApiResponse.completed(movies));
    } catch (e) {
      notificationsListSink.add(ApiResponse.error(e.toString(), []));
      print(e);
    }
  }

  dispose() {
    _notificacioListController.close();
  }

  String getToken() {
    return _token;
  }

  void setToken(String token) {
    _token = token;
  }
}
