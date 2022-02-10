// @JsonSerializable()
class Login {
  String alumne = "";
  String contrasenya = "";

  Login(this.alumne, this.contrasenya);

  factory Login.fromJson(dynamic json) {
    return Login(json['alumne'] as String, json['contrasenya'] as String);
  }

  @override toString() {
    return '{ ${this.alumne}, ${this.contrasenya} }';
  }
}
