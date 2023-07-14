import 'dart:async';
import 'package:cendrassos/api/credentials_query.dart';
import 'package:cendrassos/api/login_response.dart';
import 'package:cendrassos/api/news_query.dart';
import 'package:cendrassos/api/news_response.dart';
import 'package:cendrassos/api/notificacions_response.dart';
import 'package:cendrassos/config_cendrassos.dart';
import 'package:cendrassos/models/perfil.dart';

import '../models/alumne.dart';
import '../models/login.dart';
import 'api_base_helper.dart';
import '../models/notificacio.dart';
import 'credentials_response.dart';

class NotificacionsRepository {
  final ApiBaseHelper _helper = ApiBaseHelper();

  static String bearerText = "JWT"; // "JWT"

  Map<String, String> getHeaders(String token) => {
        "Content-Type": "application/json",
        "Accept": "application/json",
        "Authorization": "$bearerText $token",
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

  Future<CredentialsResponse> sendQr(CredentialsQuery dades) async {
    var url = qrToken;
    Map<String, String> requestHeaders = {
      'Content-type': 'application/json',
      'Accept': 'application/json',
    };

    final response = await _helper.post(url, dades.toJson(), requestHeaders);
    return CredentialsResponse.fromJson(response);
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

  Future<bool> areNewNotifications(Alumne alumne) async {
    var url = pathNews;
    try {
      // TODO: Fer login en comptes de fiar-se del token?

      var query = NewsQuery(lastSyncDate: alumne.lastSyncDate).toJson();
      final response = await _helper.post(url, query, getHeaders(alumne.token));
      return NewsResponse.fromJson(response).resultIs("Sí");
    } catch (e) {
      return false;
    }
  }

  Future<Perfil> getProfile(String token) async {
    var url = pathProfile;

    final response = await _helper.get(url, getHeaders(token));
    return Perfil.fromJson(response);
  }
}
