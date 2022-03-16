import 'package:cendrassos/api/notificacions_repository.dart';
import 'package:cendrassos/models/Alumne.dart';
import 'package:cendrassos/models/Perfil.dart';
import 'package:cendrassos/models/login.dart';
import 'package:cendrassos/services/storage.dart';
import 'package:flutter/material.dart';

class LoginResult {
  DjauStatus isLogged;
  String errorMessage;

  LoginResult(this.isLogged, this.errorMessage);
}

enum DjauStatus { Loaded, Error, WithoutUser }

class DjauModel with ChangeNotifier {
  NotificacionsRepository _repository = NotificacionsRepository();
  DjauSecureStorage _storage = DjauSecureStorage();
  DjauLocalStorage _prefs = DjauLocalStorage();

  DjauStatus _isLogged = DjauStatus.WithoutUser;
  String errorMessage = "";
  Alumne alumne = Alumne("", "", "", "");
  bool isLogged() => _isLogged == DjauStatus.Loaded;
  bool isError() => _isLogged == DjauStatus.Error;

  // Entrar en el sistema
  Future<LoginResult> login(String username, String password) async {
    try {
      final response = await _repository.login(Login(username, password));
      alumne = Alumne(username, password, response.nom, response.accessToken);
      _isLogged = DjauStatus.Loaded;
      errorMessage = "";
      _prefs.setLastLogin(username);
      await _storage.saveAlumne(alumne);
    } catch (e) {
      _isLogged = DjauStatus.Error;
      errorMessage = e.toString();
    }
    notifyListeners();
    return LoginResult(_isLogged, this.errorMessage);
  }

  // Canviar d'alumne
  Future loadAlumne(String username) async {
    try {
      var dades = await _storage.getAlumne(username);
      alumne = dades;
      await login(alumne.username, alumne.password);
    } catch (e) {
      _isLogged = DjauStatus.WithoutUser;
      errorMessage = "No hi ha dades de l'alumne $username";
      notifyListeners();
    }
  }

  Future setDefaultAlumne(String username) async {
    await _prefs.setLastLogin(username);
  }

  Future loadDefaultAlumne() async {
    var alumne = await _prefs.getLastLogin();
    if (alumne != null) {
      await loadAlumne(alumne);
    } else {
      _isLogged = DjauStatus.WithoutUser;
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
    var resultat = Map<String, String>();

    var usernames = await _prefs.getAlumnesList();
    for (var username in usernames) {
      try {
        var alumne = await _storage.getAlumne(username);
        resultat[username] = alumne.nom;
      } catch (e) {}
    }
    return resultat;
  }

  void logout() {
    notifyListeners();
  }

  Future<Perfil> loadPerfil() async {
    // final response = await _repository.getProfile(alumne.token);
    // return response;
    return Perfil("ESO1A", "20/02/1927", "666666666",
        "CM de Siurana 8 - El Far d'Empordà", {
      Responsable(
        "Manel Garcia Pimiento",
        "manel@gmail.com",
        "606000666",
      ),
      Responsable(
        "Filomena Pi Boronat",
        "filo@hotmail.com",
        "972500550",
      ),
    });
  }
}
