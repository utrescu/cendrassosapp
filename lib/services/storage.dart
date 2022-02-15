import 'package:cendrassos/models/Alumne.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class SecureStorage {
  final _storage = FlutterSecureStorage();

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
    _storage.writeSecureStorage('${alumne.username}', json);
  }

  Future<Alumne> getAlumne(String username) async {
    var data = await _storage.readSecureData(username);
    var responseJson = json.decode(data);
    return Alumne.fromJson(responseJson);
  }
}

class DjauLocalStorage {
  static final String lastLoginKey = 'lastlogin';
  static final String usersKey = 'alumnes';

  Future<String?> getLastLogin() async {
    var prefs = await SharedPreferences.getInstance();
    return prefs.getString(lastLoginKey);
  }

  Future<void> setLastLogin(String username) async {
    var prefs = await SharedPreferences.getInstance();
    prefs.setString(lastLoginKey, username);
    setAlumnes(username);
  }

  Future<List<String>> getAlumnes() async {
    var prefs = await SharedPreferences.getInstance();
    var alumnes = prefs.getStringList(usersKey);
    return alumnes ?? [];
  }

  void setAlumnes(String username) async {
    var prefs = await SharedPreferences.getInstance();
    var alumnes = await getAlumnes();
    if (!alumnes.contains(username)) {
      alumnes.add(username);
      prefs.setStringList(usersKey, alumnes);
    }
  }
}
