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

  /// Emmagatzema l'alumne [alumne] en el Secure Storage del sistema
  /// en el que estigui corrent l'aplicació.
  Future<void> saveAlumne(Alumne alumne) async {
    var json = jsonEncode(alumne.toJson());
    _storage.writeSecureStorage(alumne.username, json);
  }

  /// Obtenir les dades de l'alumne que estigui associat a un
  /// determinat [username]
  Future<Alumne> getAlumne(String username) async {
    var data = await _storage.readSecureData(username);
    var responseJson = json.decode(data);
    return Alumne.fromJson(responseJson);
  }

  /// Esborra del secure storage l'alumne que estigui lligat a
  /// un determinat [username]
  Future<void> deleteAlumne(String username) async {
    await _storage.deleteSecureData(username);
  }
}

class DjauLocalStorage {
  static const String lastLoginKey = 'lastlogin'; // Ultim usuari loginat
  static const String alumnesKey = 'alumnes'; // llista d'alumnes confirmats

  /// Obtenir el darrer username que ha entrat en l'aplicació o null
  /// si no ha entrat mai ningú
  Future<String?> getLastLogin() async {
    var prefs = await SharedPreferences.getInstance();
    return prefs.getString(lastLoginKey);
  }

  /// Elimina el darrer username que ha entrat en l'aplicació. Només
  /// es fa servir quan s'esborren tots els alumnes de l'aplicació
  Future deleteLastLogin() async {
    var prefs = await SharedPreferences.getInstance();
    prefs.remove(lastLoginKey);
  }

  /// Emmagatzema quin ha estat l'username que ha entrat en l'aplicació
  /// que està definit a [username]
  Future<void> setLastLogin(String username) async {
    var prefs = await SharedPreferences.getInstance();
    prefs.setString(lastLoginKey, username);
    _addAlumneAtList(prefs, username, alumnesKey);
  }
  
  /// Retorna la llista d'usernames que hi ha en l'aplicació
  Future<List<String>> getAlumnesList() async {
    var prefs = await SharedPreferences.getInstance();
    var alumnes = prefs.getStringList(alumnesKey);
    return alumnes ?? [];
  }
  
  /// Afegeix l'usernane [username] a la llista d'usuaris de l'aplicació
  Future addAlumneToList(String username) async {
    var prefs = await SharedPreferences.getInstance();
    _addAlumneAtList(prefs, username, alumnesKey);
  }
  
  void _addAlumneAtList(
      SharedPreferences prefs, String username, String key) async {
    var alumnes = prefs.getStringList(key) ?? [];
    if (!alumnes.contains(username)) {
      alumnes.add(username);
      prefs.setStringList(alumnesKey, alumnes);
    }
  }

  Future<List<String>> _deleteAlumneFrom(
      SharedPreferences prefs, String username, String key) async {
    var alumnes = prefs.getStringList(key) ?? [];
    if (alumnes.contains(username)) {
      alumnes.remove(username);
      prefs.setStringList(key, alumnes);
    }
    return alumnes;
  }

  /// Eliminar un alumne definit pel seu [username] del sistema.
  /// També fa neteja de la clau del darrer alumne que ha entrat i
  /// la neteja o bé en posa un altre
  void deleteAlumneFromList(String username) async {
    var prefs = await SharedPreferences.getInstance();
    var alumnes = await _deleteAlumneFrom(prefs, username, alumnesKey);

    if (alumnes.isEmpty) {
      prefs.remove(lastLoginKey);
    } else {
      var defaultUser = prefs.getString(lastLoginKey);
      if (defaultUser == username) {
        prefs.setString(lastLoginKey, alumnes.first);
      }
    }
  }
}
