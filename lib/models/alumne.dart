import '../config_cendrassos.dart';

class Alumne {
  final String username;
  final String password;
  final String token;
  final String nom;

  Alumne(
    this.username,
    this.password,
    this.nom,
    this.token,
  );

  @override
  int get hashCode => token.hashCode;

  @override
  bool operator ==(Object other) =>
      other is Alumne && other.username == username;

  factory Alumne.fromJson(dynamic json) {
    return Alumne(
      json[usernameField] as String,
      json[passwordField] as String,
      json['nom'] as String,
      json['token'] as String,
    );
  }

  factory Alumne.fromPartialJson(dynamic json, String password, String token) {
    return Alumne(
      json[usernameField] as String,
      password,
      json['nom'] as String,
      token,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data[usernameField] = username;
    data[passwordField] = password;
    data['token'] = token;
    data['nom'] = nom;
    return data;
  }
}
