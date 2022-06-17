// @JsonSerializable()

/// Dades que es passaran a l'API per identificar a un alumne
///
/// - [alumne] defineix l'username
/// - [contrasenya] per la contrasenya
///
/// No es fan servir per emmagatzemar dades
class Login {
  String alumne = "";
  String contrasenya = "";

  Login(this.alumne, this.contrasenya);

  factory Login.fromJson(dynamic json) {
    return Login(json['username'] as String, json['password'] as String);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['username'] = alumne;
    data['password'] = contrasenya;
    return data;
  }

  @override
  toString() {
    return '{ $alumne, $contrasenya }';
  }
}
