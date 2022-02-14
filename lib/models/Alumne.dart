class Alumne {
  final String username;
  final String password;
  final String token;
  final String nom;

  static String usernameField = "email";

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
      json['password'] as String,
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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data[usernameField] = this.username;
    data['password'] = this.password;
    data['token'] = this.token;
    data['nom'] = this.nom;
    return data;
  }
}
