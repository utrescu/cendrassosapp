class CredentialsResponse {
  String username = "";
  String password = "";
  String nom = "";

  static String usernameField = 'username';
  static String passwordField = 'password';

  CredentialsResponse(
      {required this.username, this.password = "", this.nom = ""});

  CredentialsResponse.fromJson(Map<String, dynamic> json) {
    username = json[usernameField];
    password = json[passwordField];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data[usernameField] = username;
    data[passwordField] = password;
    return data;
  }
}
