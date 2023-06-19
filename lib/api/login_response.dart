class LoginResponse {
  String nom = "";
  String accessToken = "";

  static String nomField = 'nom';
  static String tokenField = 'token';

  LoginResponse({required this.nom, this.accessToken = ""});

  LoginResponse.fromJson(Map<String, dynamic> json) {
    accessToken = json[tokenField];
    nom = json[nomField] ?? "";
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data[nomField] = nom;
    data[tokenField] = accessToken;
    return data;
  }
}
