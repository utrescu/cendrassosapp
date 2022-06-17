import 'package:cendrassos/models/alumne.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:intl/intl.dart';
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
  static const String lastLoginKey = 'lastlogin';
  static const String usersKey = 'alumnes';
  static const String lastOperationKey = "lastoperation";
  static final DateFormat _formatDates = DateFormat("yyyy-MM-dd HH:mm:ss");
  static final String oldTimes =
      _formatDates.format(DateTime(1970, 1, 1, 0, 10, 0));

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
    addAlumneToList(username);
  }

  Future<List<String>> getAlumnesList() async {
    var prefs = await SharedPreferences.getInstance();
    var alumnes = prefs.getStringList(usersKey);
    return alumnes ?? [];
  }

  void addAlumneToList(String username) async {
    var prefs = await SharedPreferences.getInstance();
    var alumnes = prefs.getStringList(usersKey) ?? [];
    if (!alumnes.contains(username)) {
      alumnes.add(username);
      prefs.setStringList(usersKey, alumnes);
    }
  }

  void deleteAlumneFromList(String username) async {
    var prefs = await SharedPreferences.getInstance();
    var alumnes = prefs.getStringList(usersKey) ?? [];
    if (alumnes.contains(username)) {
      alumnes.remove(username);
      prefs.setStringList(usersKey, alumnes);

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

  Future<String> getLastOperationTime() async {
    var prefs = await SharedPreferences.getInstance();
    return prefs.getString(lastOperationKey) ?? oldTimes;
  }

  Future<void> setLastOperationTime() async {
    var prefs = await SharedPreferences.getInstance();
    prefs.setString(lastOperationKey, _formatDates.format(DateTime.now()));
  }
}
