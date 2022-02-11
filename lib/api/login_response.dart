import 'package:cendrassos/models/Alumne.dart';

class LoginResponse {
  Alumne alumne = Alumne("", "", "", "");
  String accessToken = "";

  LoginResponse({required this.alumne, this.accessToken = ""});

  LoginResponse.fromJson(Map<String, dynamic> json, String contrasenya) {
    accessToken = json['accessToken'];
    alumne = Alumne.fromPartialJson(json['user'], contrasenya, accessToken);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['alumne'] = alumne.toJson();
    data['accessToken'] = this.accessToken;
    return data;
  }
}
