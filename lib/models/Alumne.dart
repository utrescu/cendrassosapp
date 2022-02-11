class Alumne {
  final String username;
  final String password;
  final String token;
  final String nom;
  final String renovationToken;

  Alumne(
      this.username, this.password, this.nom, this.token, this.renovationToken);

  @override
  int get hashCode => token.hashCode;

  @override
  bool operator ==(Object other) =>
      other is Alumne && other.username == username;

  factory Alumne.fromJson(dynamic json) {
    return Alumne(
      json['username'] as String,
      json['password'] as String,
      json['token'] as String,
      json['nom'] as String,
      json['renovationToken'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['username'] = this.username;
    data['password'] = this.password;
    data['token'] = this.token;
    data['nom'] = this.nom;
    data["renovationToken"] = this.renovationToken;
    return data;
  }
}
