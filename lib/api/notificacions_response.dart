import 'package:cendrassos/models/notificacio.dart';

class NotificacionsResponse {
  int totalResults = 0;
  List<Notificacio> results = List.empty();

  NotificacionsResponse({required this.totalResults, required this.results});

  NotificacionsResponse.fromApi(List<dynamic> received) {
    totalResults = received.length;
    results = [];
    // El primer resultat és basura!
    for (var element in received.skip(1)) {
      results.add(Notificacio.fromJson(element));
    }
  }

  NotificacionsResponse.fromJson(Map<String, dynamic> json) {
    totalResults = json['total_results'];
    results = [];
    if (json['results'] != null) {
      // results = List<Notificacio>.from(json['results']).map((x) => Notificacio.fromJson(x));
      json['results'].forEach((v) {
        results.add(Notificacio.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['total_results'] = totalResults;
    data['results'] = results.map((v) => v.toJson()).toList();
    return data;
  }
}
