/// Es passa la data com a cadena per rebre si hi ha novetats
class NewsQuery {
  String lastSyncDate = "";

  NewsQuery(this.lastSyncDate);

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["last_sync_date"] = lastSyncDate;
    return data;
  }
}
