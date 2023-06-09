// @JsonSerializable()

class Login {
  String alumne = "";
  String contrasenya = "";

  static String alumneField = 'username';
  static String passwordField = 'password';

  Login(this.alumne, this.contrasenya);

  factory Login.fromJson(dynamic json) {
    return Login(json[alumneField] as String, json[passwordField] as String);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data[alumneField] = alumne;
    data[passwordField] = contrasenya;
    return data;
  }

  @override
  toString() {
    return '{ $alumne, $contrasenya }';
  }
}
