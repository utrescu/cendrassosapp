import 'package:cendrassos/models/resum_sortida.dart';

class ResumSortidesResponse {
  int totalResults = 0;
  List<ResumSortida> results = List.empty();

  static String resultsField = 'results';
  static String totalField = 'total_results';

  ResumSortidesResponse({required this.totalResults, required this.results});

  ResumSortidesResponse.fromApi(List<dynamic> received) {
    totalResults = received.length;
    results = [];
    // El primer resultat és basura!
    for (var element in received.skip(1)) {
      results.add(ResumSortida.fromJson(element));
    }
  }

  ResumSortidesResponse.fromJson(Map<String, dynamic> json) {
    totalResults = json[totalField];
    results = [];
    if (json[resultsField] != null) {
      // results = List<Notificacio>.from(json['results']).map((x) => Notificacio.fromJson(x));
      json[resultsField].forEach((v) {
        results.add(ResumSortida.fromJson(v));
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
