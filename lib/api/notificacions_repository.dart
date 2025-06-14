import 'dart:async';
import 'package:cendrassos/api/credentials_query.dart';
import 'package:cendrassos/api/login_response.dart';
import 'package:cendrassos/api/news_query.dart';
import 'package:cendrassos/api/news_response.dart';
import 'package:cendrassos/api/notificacions_response.dart';
import 'package:cendrassos/api/resum_sortides_response.dart';
import 'package:cendrassos/config_djau.dart';
import 'package:cendrassos/models/perfil.dart';
import 'package:cendrassos/models/resum_sortida.dart';
import 'package:cendrassos/models/sortida.dart';
import 'package:flutter/material.dart';

import '../models/alumne.dart';
import '../models/login.dart';
import 'api_base_helper.dart';
import '../models/notificacio.dart';
import 'credentials_response.dart';

class NotificacionsRepository {
  late final ApiBaseHelper _helper;

  NotificacionsRepository() {
    _helper = ApiBaseHelper(refreshTokenMethod);
  }

  static String bearerText = "Bearer";

  Map<String, String> getHeaders(String token) => {
        "Content-Type": "application/json",
        "Accept": "application/json",
        "Authorization": "$bearerText $token",
      };

  static Login? lastLogin;
  static String currentToken = "";

  Future<LoginResponse> login(Login dades) async {
    var url = pathLogin;
    Map<String, String> requestHeaders = {
      'Content-type': 'application/json',
      'Accept': 'application/json',
    };

    final response = await _helper.post(url, dades.toJson(), requestHeaders);
    lastLogin = dades;
    currentToken = response["access"];

    return LoginResponse.fromJson(response);
  }

  Future<LoginResponse> refreshTokenMethod() async {
    debugPrint('Relogin');

    var response = await login(lastLogin!);
    currentToken = response.accessToken;
    return response;
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

  Future<List<Notificacio>> getNotifications(int mes) async {
    var url = "$pathNotificacions/$mes";

    final response = await _helper.get(url, getHeaders(currentToken));

    var results = NotificacionsResponse.fromApi(response);
    return results.results;
  }

  Future<bool> areNewNotifications(Alumne alumne) async {
    var url = pathNews;
    try {
      // No pot confiar en el token perquè no pot saber quan de temps fa
      // que no ha entrat
      var entrar = await login(Login(alumne.username, alumne.password));

      var query = NewsQuery(lastSyncDate: alumne.lastSyncDate).toJson();
      final response =
          await _helper.post(url, query, getHeaders(entrar.accessToken));
      debugPrint("Result $response");
      return NewsResponse.fromJson(response).resultIs("Sí");
    } catch (e) {
      return false;
    }
  }

  Future<Perfil> getProfile() async {
    var url = pathProfile;

    final response = await _helper.get(url, getHeaders(currentToken));
    return Perfil.fromJson(response);
  }

// Sortides

  Future<List<ResumSortida>> getSortides() async {
    var url = pathSortides;

    final response = await _helper.get(url, getHeaders(currentToken));

    var results = ResumSortidesResponse.fromApi(response);
    return results.results;
  }

  Future<Sortida> getSortida(int id) async {
    var url = "$pathSortides/$id/";

    final response = await _helper.get(url, getHeaders(currentToken));
    return Sortida.fromJson(response);
  }
}
