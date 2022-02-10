import 'package:cendrassos/models/notificacio.dart';

class NotificacionsResponse {
  int totalResults = 0;
  List<Notificacio> results = List.empty();

  NotificacionsResponse({required this.totalResults, required this.results});

  NotificacionsResponse.fromApi(List<dynamic> received) {
    totalResults = received.length;
    results = [];
    received.forEach((element) {
      results.add(new Notificacio.fromJson(element));
    });
  }

  NotificacionsResponse.fromJson(Map<String, dynamic> json) {
    totalResults = json['total_results'];
    if (json['results'] != null) {
      results = [];
      // results = List<Notificacio>.from(json['results']).map((x) => Notificacio.fromJson(x));
      json['results'].forEach((v) {
        results.add(new Notificacio.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['total_results'] = this.totalResults;
    data['results'] = this.results.map((v) => v.toJson()).toList();
    return data;
  }
}
