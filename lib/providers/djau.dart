import 'package:cendrassos/api/notificacions_repository.dart';
import 'package:cendrassos/models/Alumne.dart';
import 'package:cendrassos/models/login.dart';
import 'package:cendrassos/services/storage.dart';
import 'package:flutter/material.dart';

class DjauModel with ChangeNotifier {
  NotificacionsRepository _repository = NotificacionsRepository();

  SecureStorage _storage = SecureStorage();

  bool _isLogged = false;
  String errorMessage = "";

  Alumne alumne = Alumne("", "", "", "", "");

  bool isLogged() => _isLogged;

  // Entrar en el sistema
  void login(String username, String password) async {
    try {
      final response = await _repository.login(Login(username, password));
      alumne = Alumne(username, password, response.nom, response.token, "");
      _isLogged = true;
      errorMessage = "";

      var alumnes = _storage.readSecureData('alumnes_count');
      // Mirar si ja hi és
      // si no hi és incrementar alumnes
      _storage.writeSecureStorage('alumne0_token', alumne.token);
      _storage.writeSecureStorage('alumne0_nom', alumne.nom);
      _storage.writeSecureStorage('alumne0_username', alumne.username);
      _storage.writeSecureStorage('alumne0_password', alumne.password);
    } catch (e) {
      _isLogged = false;
      errorMessage = e.toString();
    }
    notifyListeners();
  }

  // Canviar d'alumne
  void switchAlumne(Alumne nou) {
    alumne = nou;
    // TODO: Fer login amb el nou alumne
    // (primer comprovar si el token val)
    notifyListeners();
  }

  void logout() {
    notifyListeners();
  }
}
