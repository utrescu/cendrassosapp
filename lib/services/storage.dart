import 'package:cendrassos/models/Alumne.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'dart:convert';

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

class DjauStorage {
  static String _prefix = "alumne_";

  final SecureStorage _storage = SecureStorage();

  Future<int> countAlumnes() async {
    var data = await _storage.readSecureData('${_prefix}_count');
    return data == null ? 0 : int.parse(data);
  }

  Future<void> saveAlumne(Alumne alumne) async {
    var json = jsonEncode(alumne.toJson());
    _storage.writeSecureStorage('${_prefix}_nom', json);
  }

  Future<Alumne> getAlumne(String username) async {
    var data = await _storage.readSecureData(username);
    var responseJson = json.decode(data);
    return Alumne.fromJson(responseJson);
  }
}
