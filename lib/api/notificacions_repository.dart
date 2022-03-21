import 'dart:async';
import 'package:cendrassos/api/login_response.dart';
import 'package:cendrassos/api/notificacions_response.dart';
import 'package:cendrassos/config_cendrassos.dart';
import 'package:cendrassos/models/perfil.dart';

import '../models/login.dart';
import 'api_base_helper.dart';
import '../models/notificacio.dart';

class NotificacionsRepository {
  final ApiBaseHelper _helper = ApiBaseHelper();

  Map<String, String> getHeaders(String token) => {
        "Content-Type": "application/json",
        "Accept": "application/json",
        "Authorization": "Bearer $token",
      };

  Future<LoginResponse> login(Login dades) async {
    var url = pathLogin;
    Map<String, String> requestHeaders = {
      'Content-type': 'application/json',
      'Accept': 'application/json',
    };

    final response = await _helper.post(url, dades.toJson(), requestHeaders);
    return LoginResponse.fromJson(response);
  }

  // Future<bool> isAuthenticated(String token) async {
  //   var url = "/authenticated";
  //   final response = await _helper.get(url, getHeaders(token));
  //   return response['value'];
  // }

  Future<List<Notificacio>> getNotifications(int mes, String token) async {
    var url = "$pathNotificacions/$mes";

    final response = await _helper.get(url, getHeaders(token));

    var results = NotificacionsResponse.fromApi(response);
    return results.results;
  }

  Future<bool> areNewNotifications(String token) async {
    var url = pathNews;
    try {
      await _helper.get(url, getHeaders(token));
    } catch (e) {
      return false;
    }
    return true;
  }

  Future<Perfil> getProfile(String token) async {
    var url = pathProfile;

    final response = await _helper.get(url, getHeaders(token));
    return Perfil.fromJson(response);
  }
}
