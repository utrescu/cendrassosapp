import 'dart:core';

/// Resposta de la petició de noves incidències
class NewsResponse {
  String resultat = "";

  NewsResponse.fromJson(Map<String, dynamic> json) {
    resultat = json['resultat'];
  }
}
