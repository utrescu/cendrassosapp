import 'package:cendrassos/api/credentials_response.dart';

class Alumne {
  final String username;
  final String password;
  String token;
  final String nom;

  // Personalitzar els camps de login
  static String usernameField = 'username';
  static String passwordField = 'password';
  static String nomField = 'nom';
  static String tokenField = 'token';

  Alumne(
    this.username,
    this.password,
    this.nom,
    this.token,
  );

  Alumne.fromCredentials(String nomAlumne, CredentialsResponse c)
      : username = c.username,
        password = c.password,
        nom =  nomAlumne,
        token = "";

  @override
  int get hashCode => token.hashCode;

  @override
  bool operator ==(Object other) =>
      other is Alumne && other.username == username;

  factory Alumne.fromJson(dynamic json) {
    return Alumne(
      json[usernameField] as String,
      json[passwordField] as String,
      json[nomField] as String,
      json[tokenField] as String,
    );
  }

  factory Alumne.fromPartialJson(dynamic json, String password, String token) {
    return Alumne(
      json[usernameField] as String,
      password,
      json[nomField] as String,
      token,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data[usernameField] = username;
    data[passwordField] = password;
    data[tokenField] = token;
    data[nomField] = nom;
    return data;
  }
}
