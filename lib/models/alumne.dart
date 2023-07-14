import 'package:cendrassos/api/credentials_response.dart';
import 'package:intl/intl.dart';

class Alumne {
  final String username;
  final String password;
  final String nom;
  String token;
  late String lastSyncDate;

  static DateFormat formatter = DateFormat('yyyy-MM-dd HH:mm:ss');

  // Personalitzar els camps de login
  static String usernameField = 'username';
  static String passwordField = 'password';
  static String nomField = 'nom';
  static String tokenField = 'token';
  static String lastSyncDateField = "last_sync_date";

  Alumne(
    this.username,
    this.password,
    this.nom,
    this.token,
    this.lastSyncDate,
  );

  Alumne.fromCredentials(String nomAlumne, CredentialsResponse c)
      : username = c.username,
        password = c.password,
        nom = nomAlumne,
        token = "" {
    lastSyncDate = formatter.format(DateTime.now());
  }

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
      json[lastSyncDateField] as String,
    );
  }

  factory Alumne.fromPartialJson(dynamic json, String password, String token) {
    return Alumne(
      json[usernameField] as String,
      password,
      json[nomField] as String,
      token,
      formatter.format(DateTime.now()),
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data[usernameField] = username;
    data[passwordField] = password;
    data[tokenField] = token;
    data[nomField] = nom;
    data[lastSyncDateField] = lastSyncDate;
    return data;
  }
}
