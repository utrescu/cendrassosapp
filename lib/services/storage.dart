import 'package:cendrassos/models/alumne.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class SecureStorage {
  final _storage = const FlutterSecureStorage();

  Future writeSecureStorage(String key, String value) async {
    var writeData = await _storage.write(key: key, value: value);
    return writeData;
  }

  Future readSecureData(String key) async {
    var readData = await _storage.read(key: key);
    return readData;
  }

  Future deleteSecureData(String key) async {
    var deleteData = await _storage.delete(key: key);
    return deleteData;
  }
}

class DjauSecureStorage {
  final SecureStorage _storage = SecureStorage();

  Future<void> saveAlumne(Alumne alumne) async {
    var json = jsonEncode(alumne.toJson());
    _storage.writeSecureStorage(alumne.username, json);
  }

  Future<Alumne> getAlumne(String username) async {
    var data = await _storage.readSecureData(username);
    var responseJson = json.decode(data);
    return Alumne.fromJson(responseJson);
  }

  Future<void> deleteAlumne(String username) async {
    await _storage.deleteSecureData(username);
  }
}

class DjauLocalStorage {
  static const String lastLoginKey = 'lastlogin'; // Ultim usuari loginat
  static const String alumnesKey = 'alumnes'; // llista d'alumnes confirmats
  static const String pendentsKey = 'pendents'; // llista d'alumnes pendents

  Future<String?> getLastLogin() async {
    var prefs = await SharedPreferences.getInstance();
    return prefs.getString(lastLoginKey);
  }

  Future deleteLastLogin() async {
    var prefs = await SharedPreferences.getInstance();
    prefs.remove(lastLoginKey);
  }

  Future<void> setLastLogin(String username) async {
    var prefs = await SharedPreferences.getInstance();
    prefs.setString(lastLoginKey, username);
    addAlumneToList(prefs, username, alumnesKey);
    confirmAlumne(prefs, username);
  }

  // Gestió de pendents

  Future<void> addAlumneToPendents(String username) async {
    var prefs = await SharedPreferences.getInstance();
    addAlumneToList(prefs, username, pendentsKey);
  }

  Future<void> confirmAlumne(SharedPreferences pref, String username) async {
    var prefs = await SharedPreferences.getInstance();
    addAlumneToList(prefs, username, alumnesKey);
    deleteAlumneFrom(prefs, username, pendentsKey);
  }

  // obtenir els alumnes d'una de les llistes
  Future<List<String>> getAlumnesList(String key) async {
    var prefs = await SharedPreferences.getInstance();
    var alumnes = prefs.getStringList(key);
    return alumnes ?? [];
  }

  Future<List<String>> getAllAlumnes() async {
    var prefs = await SharedPreferences.getInstance();
    var alumnes = prefs.getStringList(alumnesKey) ?? [];
    var pendents = prefs.getStringList(pendentsKey) ?? [];

    return alumnes + pendents;
  }

  void addAlumneToList(
      SharedPreferences prefs, String username, String key) async {
    var alumnes = prefs.getStringList(key) ?? [];
    if (!alumnes.contains(username)) {
      alumnes.add(username);
      prefs.setStringList(alumnesKey, alumnes);
    }
  }

  // Eliminar un alumne d'una de les llistes
  Future<List<String>> deleteAlumneFrom(
      SharedPreferences prefs, String username, String key) async {
    var alumnes = prefs.getStringList(key) ?? [];
    if (alumnes.contains(username)) {
      alumnes.remove(username);
      prefs.setStringList(key, alumnes);
    }
    return alumnes;
  }

  // Eliminar un alumne del sistema
  void deleteAlumneFromList(String username) async {
    var prefs = await SharedPreferences.getInstance();
    var alumnes = await deleteAlumneFrom(prefs, username, alumnesKey);

    if (alumnes.isEmpty) {
      prefs.remove(lastLoginKey);
    } else {
      // Si és l'actiu el canviem pel primer que quedi
      var defaultUser = prefs.getString(lastLoginKey);
      if (defaultUser == username) {
        prefs.setString(lastLoginKey, alumnes.first);
      }
    }
  }
}
