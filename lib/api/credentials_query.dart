class CredentialsQuery {
  String key = "";
  String bornDate = "";

  static String keyField = 'key';
  static String bornField = 'born_date';

  CredentialsQuery(this.key, this.bornDate);

  factory CredentialsQuery.fromJson(dynamic json) {
    return CredentialsQuery(json[keyField] as String, json[bornField] as String);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data[keyField] = key;
    data[bornField] = bornDate;
    return data;
  }

  @override
  toString() {
    return '{ $key, $bornDate }';
  }
}
