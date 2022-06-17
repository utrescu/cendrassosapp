import 'dart:async';
import 'package:cendrassos/api/login_response.dart';
import 'package:cendrassos/api/news_response.dart';
import 'package:cendrassos/api/notificacions_response.dart';
import 'package:cendrassos/config_cendrassos.dart';
import 'package:cendrassos/models/perfil.dart';
import 'package:flutter/material.dart';

import '../models/login.dart';
import 'api_base_helper.dart';
import '../models/notificacio.dart';
import 'news_query.dart';

/// Defineix les crides a l'API de notifcacions
class NotificacionsRepository {
  final ApiBaseHelper _helper = ApiBaseHelper();

  Map<String, String> getHeaders(String token) => {
        "Content-Type": "application/json",
        "Accept": "application/json",
        "Authorization": "Bearer $token",
      };

  /// Identifica l'alumne
  ///
  /// Ho fa a partir del seu usuari i contrasenya que troba
  /// a [dades]
  ///
  /// És la única crida que es pot fer sense autenticació
  Future<LoginResponse> login(Login dades) async {
    var url = pathLogin;
    Map<String, String> requestHeaders = {
      'Content-type': 'application/json',
      'Accept': 'application/json',
    };

    final response = await _helper.post(url, dades.toJson(), requestHeaders);
    return LoginResponse.fromJson(response);
  }

  /// Obtenir la llista de notificacions d'un determinat mes [mes]
  ///
  /// Necessita el [token] per demostrar que s'ha identificat
  Future<List<Notificacio>> getNotifications(int mes, String token) async {
    var url = "$pathNotificacions/$mes";

    final response = await _helper.get(url, getHeaders(token));

    var results = NotificacionsResponse.fromApi(response);
    return results.results;
  }

  /// Comprova si hi ha noves notificacions o no
  ///
  /// Retorna un booleà que indica si n'hi ha.
  /// Necessita el [token] per demostrar que s'ha identificat
  Future<bool> haveNewNotifications(String dades, String token) async {
    const String expected = "Sí";
    var url = pathNews;
    try {
      var json =
          await _helper.post(url, NewsQuery(dades).toJson(), getHeaders(token));
      var news = NewsResponse.fromJson(json);
      debugPrint(
          "Resultat '${news.resultat}' o sigui ${news.resultat == expected}");
      return news.resultat == expected;
    } catch (e) {
      return false;
    }
  }

  /// Obté el perfil de l'alumne connectat
  ///
  /// Necessita el [token] per demostrar que s'ha identificat
  Future<Perfil> getProfile(String token) async {
    var url = pathProfile;

    final response = await _helper.get(url, getHeaders(token));
    return Perfil.fromJson(response);
  }
}
