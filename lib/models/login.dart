// @JsonSerializable()
import '../config_cendrassos.dart';

class Login {
  String alumne = "";
  String contrasenya = "";

  Login(this.alumne, this.contrasenya);

  factory Login.fromJson(dynamic json) {
    return Login(json[usernameField] as String, json['contrasenya'] as String);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data[usernameField] = alumne;
    data['Password'] = contrasenya;
    return data;
  }

  @override
  toString() {
    return '{ $alumne, $contrasenya }';
  }
}
