import 'package:cendrassos/api/notificacions_repository.dart';
import 'package:cendrassos/models/alumne.dart';
import 'package:cendrassos/models/perfil.dart';
import 'package:cendrassos/models/login.dart';
import 'package:cendrassos/services/storage.dart';
import 'package:flutter/material.dart';

/// Emmagatzema l'estat del login en el provider
///
/// L'estat està a [isLogged] i el missatge d'error, si n'hi ha, estarà
/// a [message]
class LoginResult {
  DjauStatus isLogged;
  String errorMessage;

  LoginResult(this.isLogged, this.errorMessage);
}

/// Estats en que pot estar l'aplicació
///
/// Són:
/// - Loaded: s'ha carregat un alumne
/// - error: L'aplicació està en estat d'error
/// - withoutUser: No s'ha identificat cap alumne
///
enum DjauStatus { loaded, error, withoutUser }

/// Emmagatzema l'estat general de l'aplicació
///
/// Les dades dels alumnes s'emmagatzemen al SecureStorage del sistema
/// per protegir-los [_storage]
///
/// Les dades de funcionament que cal conservar s'emmagatzemen en el
/// Local Storage [_prefs]
///
/// El [_repository] es fa servir per fer les crides a l'API
class DjauModel with ChangeNotifier {
  final NotificacionsRepository _repository = NotificacionsRepository();
  final DjauSecureStorage _storage = DjauSecureStorage();
  final DjauLocalStorage _prefs = DjauLocalStorage();

  DjauStatus _isLogged = DjauStatus.withoutUser;
  String errorMessage = "";
  Alumne alumne = Alumne("", "", "", "");

  DjauModel();

  DjauModel.withUser(String defaultUser) {
    _prefs.setLastLogin(defaultUser);
  }

  bool isLogged() => _isLogged == DjauStatus.loaded;
  bool isError() => _isLogged == DjauStatus.error;

  /// Intenta entrar en el sistema
  ///
  /// Retorna el resultat en un [LoginResult] de manera que la UI
  /// pot saber si ha pogut entrar i el missatge d'error
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

  /// Canvia d'alumne
  ///
  /// Carrega un nou alumne a l'aplicació que identifica amb [username]
  /// Les dades de l'alumne es carreguen de [_storage]
  ///
  /// Sobretot es fa servir per canviar d'un alumne a un altre que ja estiguin
  /// previament identificats
  Future loadAlumne(String username) async {
    try {
      var dades = await _storage.loadAlumne(username);
      alumne = dades;
      await login(alumne.username, alumne.password);
    } catch (e) {
      _isLogged = DjauStatus.withoutUser;
      errorMessage = "No hi ha dades de l'alumne $username";
      notifyListeners();
    }
  }

  /// Carrega l'alumne per defecte si n'hi ha algun
  Future loadDefaultAlumne() async {
    var alumne = await _prefs.getLastLogin();
    if (alumne != null) {
      await loadAlumne(alumne);
    } else {
      _isLogged = DjauStatus.withoutUser;
      errorMessage = "L'alumne $alumne no pot entrar";
    }
  }

  /// Esborra l'alumne identificat per l'[username]
  ///
  /// En acabar carrega el que hi hagi per defecte
  Future deleteAlumne(String username) async {
    await _storage.deleteAlumne(username);
    _prefs.deleteAlumneFromList(username);
    await loadDefaultAlumne();
  }

  /// Obtenir els noms dels alumnes identificats i el seu username
  Future<Map<String, String>> getAlumnes() async {
    var resultat = <String, String>{};

    var usernames = await _prefs.getAlumnesList();
    for (var username in usernames) {
      try {
        var alumne = await _storage.loadAlumne(username);
        resultat[username] = alumne.nom;
      } catch (e) {
        debugPrint("No hi ha alumnes registrats");
      }
    }
    return resultat;
  }

  /// Desconnectar
  void logout() {
    notifyListeners();
  }

  /// Carrega el perfil de l'alumne actiu
  Future<Perfil> loadPerfil() async {
    final response = await _repository.getProfile(alumne.token);
    return response;
  }
}
