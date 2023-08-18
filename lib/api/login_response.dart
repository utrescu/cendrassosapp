class LoginResponse {
  String nom = "";
  String accessToken = "";
  String refreshToken = "";

  static String nomField = 'nom';
  static String tokenField = 'access';
  static String refreshField = 'refresh';

  LoginResponse(
      {required this.nom, this.accessToken = "", this.refreshToken = ""});

  LoginResponse.fromJson(Map<String, dynamic> json) {
    accessToken = json[tokenField];
    refreshToken = json[refreshField];
    nom = json[nomField] ?? "";
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data[nomField] = nom;
    data[tokenField] = accessToken;
    data[refreshToken] = refreshField;
    return data;
  }
}
