class LoginResponse {
  String nom = "";
  String accessToken = "";

  LoginResponse({required this.nom, this.accessToken = ""});

  LoginResponse.fromJson(Map<String, dynamic> json) {
    accessToken = json['accessToken'];
    nom = json['nom'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['nom'] = nom;
    data['accessToken'] = accessToken;
    return data;
  }
}
