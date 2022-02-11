import 'dart:async';
import 'package:cendrassos/api/login_response.dart';
import 'package:cendrassos/api/notificacions_response.dart';

import '../models/login.dart';
import 'api_base_helper.dart';
import '../models/notificacio.dart';

class NotificacionsRepository {
  ApiBaseHelper _helper = ApiBaseHelper();

  Map<String, String> getHeaders(String token) => {
        "Content-Type": "application/json",
        "Accept": "application/json",
        "Authorization": "Bearer $token",
      };

  Future<LoginResponse> login(Login dades) async {
    var url = "/login";
    Map<String, String> requestHeaders = {
      'Content-type': 'application/json',
      'Accept': 'application/json',
    };

    final response = await _helper.post(url, dades.toJson(), requestHeaders);
    return LoginResponse.fromJson(response, dades.contrasenya);
  }

  // Future<bool> isAuthenticated(String token) async {
  //   var url = "/authenticated";
  //   final response = await _helper.get(url, getHeaders(token));
  //   return response['value'];
  // }

  Future<List<Notificacio>> getNotifications(int mes, String token) async {
    var url = "/notificacions/$mes";

    final response = await _helper.get(url, getHeaders(token));

    var results = NotificacionsResponse.fromApi(response);
    return results.results;
  }
}
