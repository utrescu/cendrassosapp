// @JsonSerializable()
class Login {
  String alumne = "";
  String contrasenya = "";

  Login(this.alumne, this.contrasenya);

  factory Login.fromJson(dynamic json) {
    return Login(json['alumne'] as String, json['contrasenya'] as String);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['alumne'] = this.alumne;
    data['password'] = this.contrasenya;
    return data;
  }

  @override
  toString() {
    return '{ ${this.alumne}, ${this.contrasenya} }';
  }
}
