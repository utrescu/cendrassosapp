import 'package:cendrassos/api/credentials_query.dart';
import 'package:cendrassos/api/notificacions_repository.dart';
import 'package:cendrassos/models/alumne.dart';
import 'package:cendrassos/models/perfil.dart';
import 'package:cendrassos/models/login.dart';
import 'package:cendrassos/services/storage.dart';
import 'package:flutter/material.dart';

import '../models/qr.dart';

class LoginResult {
  DjauStatus isLogged;
  String errorMessage;

  LoginResult(this.isLogged, this.errorMessage);
}

enum DjauStatus { loaded, error, withoutUser, disabled }

class DjauModel with ChangeNotifier {
  final NotificacionsRepository _repository = NotificacionsRepository();
  final DjauSecureStorage _storage = DjauSecureStorage();
  final DjauLocalStorage _prefs = DjauLocalStorage();

  DjauStatus _isLogged = DjauStatus.withoutUser;
  String errorMessage = "";
  Alumne alumne = Alumne("", "", "", "");
  bool isLogged() => _isLogged == DjauStatus.loaded;
  bool isError() => _isLogged == DjauStatus.error;

  // Donar d'alta
  Future<LoginResult> register(Qr qr, String born) async {
    try {
      final resultat = await _repository.sendQr(CredentialsQuery(qr.key, born));
      _isLogged = DjauStatus.disabled;
      errorMessage = "";
      alumne = Alumne.fromCredentials(qr.nom, resultat);

      await _storage.saveAlumne(alumne);
      await _prefs.addAlumneToPendents(alumne.username);
      await _storage.saveAlumne(alumne);
    } catch (e) {
      _isLogged = DjauStatus.error;
      errorMessage = e.toString();
    }
    notifyListeners();
    return LoginResult(_isLogged, errorMessage);
  }

  // Entrar en el sistema
  Future<LoginResult> login(String username, String password) async {
    try {
      final response = await _repository.login(Login(username, password));
      alumne = Alumne(username, password, response.nom, response.accessToken);
      _isLogged = DjauStatus.loaded;
      errorMessage = "";
      _prefs.setLastLogin(username);
      await _storage.saveAlumne(alumne);
    } catch (e) {
      _isLogged = DjauStatus.error;
      errorMessage = e.toString();
    }
    notifyListeners();
    return LoginResult(_isLogged, errorMessage);
  }

  // Canviar d'alumne
  Future<LoginResult> loadAlumne(String username) async {
    try {
      var dades = await _storage.getAlumne(username);
      alumne = dades;
      var resultat = await login(alumne.username, alumne.password);
      notifyListeners();
      return resultat;
    } catch (e) {
      _isLogged = DjauStatus.withoutUser;
      errorMessage = "No hi ha dades de l'alumne $username";
      notifyListeners();
      return LoginResult(_isLogged, errorMessage);
    }
  }

  Future setDefaultAlumne(String username) async {
    await _prefs.setLastLogin(username);
  }

  Future<int> loadInitialPage() async {
    var alumnes = await _prefs.getAlumnesList(DjauLocalStorage.alumnesKey);
    var pendents = await _prefs.getAlumnesList(DjauLocalStorage.pendentsKey);
    if (alumnes.isEmpty && pendents.isEmpty) return 0;

    if (pendents.isNotEmpty) {
      return 1;
    }
    return 2;
  }

  Future loadDefaultAlumne() async {
    var alumne = await _prefs.getLastLogin();
    if (alumne != null) {
      await loadAlumne(alumne);
    } else {
      _isLogged = DjauStatus.withoutUser;
      errorMessage = "L'alumne $alumne no pot entrar";
    }
  }

  Future deleteAlumne(String username) async {
    await _storage.deleteAlumne(username);
    _prefs.deleteAlumneFromList(username);
    await loadDefaultAlumne();
  }

  // Obtenir els noms dels alumnes i el seu username
  Future<Map<String, String>> getAlumnes() async {
    var resultat = <String, String>{};

    var usernames = await _prefs.getAlumnesList(DjauLocalStorage.alumnesKey);
    for (var username in usernames) {
      try {
        var alumne = await _storage.getAlumne(username);
        resultat[username] = alumne.nom;
      } catch (e) {
        debugPrint("No hi ha alumnes registrats");
      }
    }
    return resultat;
  }

  void logout() {
    notifyListeners();
  }

  Future<Perfil> loadPerfil() async {
    final response = await _repository.getProfile(alumne.token);
    return response;
    // return Perfil("ESO1A", "20/02/1927", "666666666",
    //     "CM de Siurana 8 - El Far d'Empordà", {
    //   Responsable(
    //     "Manel Garcia Pimiento",
    //     "manel@gmail.com",
    //     "606000666",
    //   ),
    //   Responsable(
    //     "Filomena Pi Boronat",
    //     "filo@hotmail.com",
    //     "972500550",
    //   ),
    // });
  }
}
