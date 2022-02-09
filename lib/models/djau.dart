import 'package:flutter/material.dart';

class Alumne {
  final String username;
  final String token;
  final String nom;
  final String renovationToken;

  Alumne(this.username, this.nom, this.token, this.renovationToken);

  @override
  int get hashCode => token.hashCode;

  @override
  bool operator ==(Object other) =>
      other is Alumne && other.username == username;
}

class DjauModel extends ChangeNotifier {
  String get usernamame => alumne == null ? "" : alumne!.username;

  Alumne? alumne;

  bool isLogged() => alumne == null;

  void login(String username, String password) {
    // TODO buscar-lo
    if (username != "xavier") {
      var token = "234444444444";
      alumne = Alumne(username, username, token, "");
    }
    notifyListeners();
  }

  void logout() {
    alumne = null;
    notifyListeners();
  }
}
