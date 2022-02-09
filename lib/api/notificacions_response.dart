import 'package:cendrassos/models/notificacio.dart';

class NotificacionsResponse {
  int page = 0;
  int totalResults = 0;
  int totalPages = 0;
  List<Notificacio> results = List.empty();

  NotificacionsResponse(
      {required this.page,
      required this.totalResults,
      required this.totalPages,
      required this.results});

  NotificacionsResponse.fromJson(Map<String, dynamic> json) {
    page = json['page'];
    totalResults = json['total_results'];
    totalPages = json['total_pages'];
    if (json['results'] != null) {
      results = [];
      json['results'].forEach((v) {
        results.add(new Notificacio.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['page'] = this.page;
    data['total_results'] = this.totalResults;
    data['total_pages'] = this.totalPages;
    data['results'] = this.results.map((v) => v.toJson()).toList();
    return data;
  }
}
