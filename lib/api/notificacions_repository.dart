import 'dart:async';
import 'package:cendrassos/api/login_response.dart';
import 'package:cendrassos/api/notificacions_response.dart';

import 'api_base_helper.dart';
import '../models/notificacio.dart';

class NotificacionsRepository {
  ApiBaseHelper _helper = ApiBaseHelper();

  Future<LoginResponse> login(page) async {
    var url = "/login";
    final response = await _helper.post(url, "");
    return LoginResponse.fromJson(response);
  }

  Future<List<Notificacio>> getNotifications(int mes) async {
    var url = "/notificacions/$mes";

    final response = await _helper.get(url);

    var results = NotificacionsResponse.fromApi(response);
    return results.results;
  }
}
