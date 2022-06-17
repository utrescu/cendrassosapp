/// Resposta de l'API davant d'una petició de login correcta.
///
/// Només cal que hi hagi el nom de l'alumne [nom] (estalvia peticions)
/// i el [token] que es farà servir per poder fer peticions
class LoginResponse {
  String nom = "";
  String accessToken = "";

  LoginResponse({required this.nom, this.accessToken = ""});

  LoginResponse.fromJson(Map<String, dynamic> json) {
    accessToken = json['access'];
    nom = json['nom'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['nom'] = nom;
    data['access'] = accessToken;
    return data;
  }
}
