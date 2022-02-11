import 'package:cendrassos/api/notificacions_repository.dart';
import 'package:cendrassos/models/Alumne.dart';
import 'package:cendrassos/models/login.dart';
import 'package:cendrassos/services/storage.dart';
import 'package:flutter/material.dart';

class LoginResult {
  bool isLogged;
  String errorMessage;

  LoginResult(this.isLogged, this.errorMessage);
}

class DjauModel with ChangeNotifier {
  NotificacionsRepository _repository = NotificacionsRepository();

  DjauStorage _storage = DjauStorage();

  bool _isLogged = false;
  String errorMessage = "";

  Alumne alumne = Alumne("", "", "", "");

  bool isLogged() => _isLogged;

  // Entrar en el sistema
  Future<LoginResult> login(String username, String password) async {
    try {
      final response = await _repository.login(Login(username, password));
      alumne =
          Alumne(username, password, response.alumne.nom, response.accessToken);
      _isLogged = true;
      errorMessage = "";
      await _storage.saveAlumne(alumne);
    } catch (e) {
      _isLogged = false;
      errorMessage = e.toString();
    }
    notifyListeners();
    return LoginResult(this._isLogged, this.errorMessage);
  }

  // Canviar d'alumne
  void switchAlumne(Alumne nou) async {
    try {
      var dades = await _storage.getAlumne(nou.username);
      alumne = dades;
    } catch (e) {
      _isLogged = false;
      errorMessage = "Aquest alumne no existeix";
    }

    // TODO: Fer login amb el nou alumne
    // (primer comprovar si el token val)
    notifyListeners();
  }

  void logout() {
    notifyListeners();
  }
}