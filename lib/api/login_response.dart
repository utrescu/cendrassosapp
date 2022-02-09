
class LoginResponse {
  String nom = "";
  String token = "";

  LoginResponse({this.nom = "", this.token = ""});

  LoginResponse.fromJson(Map<String, dynamic> json) {
    nom = json['nom'];
    token = json['token'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['nom'] = this.nom;
    data['token'] = this.token;
    return data;
  }
}
