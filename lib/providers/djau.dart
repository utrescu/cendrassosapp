import 'package:cendrassos/api/credentials_query.dart';
import 'package:cendrassos/api/notificacions_repository.dart';
import 'package:cendrassos/models/alumne.dart';
import 'package:cendrassos/models/perfil.dart';
import 'package:cendrassos/models/login.dart';
import 'package:cendrassos/models/sortida.dart';
import 'package:cendrassos/services/storage.dart';
import 'package:flutter/material.dart';

import '../api/exceptions.dart';
import '../models/qr.dart';

class LoginResult {
  DjauStatus isLogged;
  String errorType;
  String errorMessage;

  LoginResult(this.isLogged, this.errorType, this.errorMessage);
}

enum DjauStatus { loaded, error, withoutUser, disabled }

class DjauModel with ChangeNotifier {
  final NotificacionsRepository _repository = NotificacionsRepository();
  final DjauSecureStorage _storage = DjauSecureStorage();
  final DjauLocalStorage _prefs = DjauLocalStorage();

  // Estat de l'alumne actual
  DjauStatus _isLogged = DjauStatus.withoutUser;
  // Missatge d'error si no hem entrat
  String errorMessage = "";
  String errorType = "";
  // Alumne actual
  Alumne alumne = Alumne("", "", "", "", "");

  bool isLogged() => _isLogged == DjauStatus.loaded;
  bool isError() => _isLogged == DjauStatus.error;

  /// Registra un nou alumne amb el "sistema Cendrassos".
  /// Hi ha el contingut d'un codi Qr [qr] i la data de
  /// naixement [born]. Retorna el resultat de l'intent
  Future<LoginResult> register(Qr qr, String born) async {
    try {
      final resultat = await _repository.sendQr(CredentialsQuery(qr.key, born));
      _isLogged = DjauStatus.disabled;
      errorMessage = "";
      errorType = "";
      alumne = Alumne.fromCredentials(qr.getFullName(), resultat);
      await _storage.saveAlumne(alumne);
      await _prefs.addAlumneToList(resultat.username);
    } on AppException catch (f) {
      _isLogged = DjauStatus.error;
      errorType = f.prefix();
      errorMessage = f.message();
    } catch (e) {
      _isLogged = DjauStatus.error;
      errorType = "ERROR";
      errorMessage = e.toString();
    }
    notifyListeners();
    return LoginResult(_isLogged, errorType, errorMessage);
  }

  /// Entrar en el sistema a través d'usuari [username] i
  /// contrasenya [password]. Es fa servir quan s'intenta fer login contra
  /// el servidor
  ///
  /// Si tot va bé carrega la variable `alumne` i si no, posa l'estat en error
  Future<LoginResult> login(String username, String password) async {
    try {
      final response = await _repository.login(Login(username, password));
      alumne = await _storage.getAlumne(username);
      alumne.token = response.accessToken;
      _isLogged = DjauStatus.loaded;
      errorMessage = "";
      errorType = "";
      _prefs.setLastLogin(username);
      await _storage.saveAlumne(alumne);
    } on AppException catch (f) {
      _isLogged = DjauStatus.error;
      errorType = f.prefix();
      errorMessage = f.message();
    } catch (e) {
      _isLogged = DjauStatus.error;
      errorType = "ERROR";
      errorMessage = e.toString();
    }
    notifyListeners();
    return LoginResult(_isLogged, errorType, errorMessage);
  }

  /// Carrega les dades de l'alumne de memòria i les posa a la variable
  /// d'estat `alumne`.
  /// Hi fem referència a través del seu [username]. Comprova si pot
  /// fer login per obtenir un nou token.
  ///
  /// Retorna l'estat de consultar el servidor
  Future<LoginResult> loadAlumne(String username) async {
    try {
      var dades = await _storage.getAlumne(username);
      alumne = dades;
      var resultat = await login(alumne.username, alumne.password);
      notifyListeners();
      return resultat;
    } on AppException catch (f) {
      _isLogged = DjauStatus.withoutUser;
      errorType = f.prefix();
      errorMessage = f.message();
    } catch (e) {
      _isLogged = DjauStatus.withoutUser;
      errorMessage = "No hi ha dades de l'alumne $username";
    }
    notifyListeners();
    return LoginResult(_isLogged, errorType, errorMessage);
  }

  /// Defineix qui és el darrer alumne amb el que s'ha fet login
  /// [username] per poder entrar directament el proper cop i de
  /// pas saber si hem entrat alguna vegada o no.
  Future setDefaultAlumne(String username) async {
    await _prefs.setLastLogin(username);
  }

  /// Defineix quina és la pantalla inicial en iniciar el programa
  /// - No hi ha alumnes -> Login/QR (0)
  /// - Hi ha alumnes però No ha entrat mai -> Pantalla d'alumnes (1)
  /// - Hi ha alumnes i han entrat -> Directe al Dashboard (2)
  Future<int> determineInitialPage() async {
    var alumnes = await _prefs.getAlumnesList();
    if (alumnes.isEmpty) return 0;

    // S1 l'alumne ja havia entrat algun cop
    var lastlogin = await _prefs.getLastLogin();
    if (lastlogin == null || lastlogin.isEmpty) {
      return 1;
    }
    return 2;
  }

  /// Carrega l'alumne que havia entrat per darrera vegada.
  /// La variable `alumne` s'inicialitza amb les seves dades o bé es posa
  /// el sistema en estat d'error.
  ///
  /// L'alumne que va entrar per darrera vegada es defineix
  /// a `SetDefaultAlumne`
  Future loadDefaultAlumne() async {
    var alumne = await _prefs.getLastLogin();
    if (alumne != null) {
      await loadAlumne(alumne);
    } else {
      _isLogged = DjauStatus.withoutUser;
      errorMessage = "L'alumne $alumne no pot entrar";
    }
  }

  /// Esborra l'alumne definit per [username] del sistema
  Future deleteAlumne(String username) async {
    await _storage.deleteAlumne(username);
    await _prefs.deleteAlumneFromList(username);
    await loadDefaultAlumne();
  }

  /// Obtenir um mapa amb els noms dels alumnes i el seu username.
  /// Cal per poder llistar els noms dels alumnes a més del seu
  /// username
  Future<Map<String, String>> getAlumnes() async {
    var resultat = <String, String>{};

    var usernames = await _prefs.getAlumnesList();
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

  /// Carrega el perfil de l'usuari que està actiu en aquest moment
  Future<Perfil> loadPerfil() async {
    final response = await _repository.getProfile();
    return response;
  }

  // Carregar el detalla de la sortida
  Future<Sortida> loadSortida(int id) async {
    final response = await _repository.getSortida(id);
    return response;
  }
}

