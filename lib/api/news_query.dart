class NewsQuery {
  String lastSyncDate;
  static String lastSyncDateField = 'last_sync_date';

  NewsQuery({required this.lastSyncDate});

  Map<String, dynamic> toJson() {

    final Map<String, dynamic> data = <String, dynamic>{};
    data[lastSyncDateField] = lastSyncDate;
    return data;
  }

}
