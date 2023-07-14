class NewsResponse {
  String resultat = "";
  static String resultaField = 'resultat';

  NewsResponse({required this.resultat});

  NewsResponse.fromJson(Map<String, dynamic> json) {
    resultat = json[resultaField];
  }

  bool resultIs(String ok) {
    return resultat == ok;
  }
}
