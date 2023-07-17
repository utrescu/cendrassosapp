// @JsonSerializable()

import '../config_djau.dart';

class Qr {
  // Exemple: {
  //    "key": "2e114f9f-30fa-4894-82c6-d3de7d7c3683",
  //    "id": 155,
  //    "name": "Kevin Mateo",
  //    "api_end_point": "https://djau.cendrassos.net",
  //    "organization": "Ins Cendrassos"
  // }
  String key = "";
  int id = 0;
  String nom = "";
  String cognoms = "";
  String api = baseUrl;
  String organization = appName;

  static String keyField = 'key';
  static String idField = 'id';
  static String nameField = 'name';
  static String surnameField = 'surname';
  static String apiField = 'api_end_point';
  static String organizationField = 'organization';

  Qr(this.key, this.id, this.nom, this.cognoms, this.api, this.organization);

  Qr.empty();

  factory Qr.fromJson(dynamic json) {
    return Qr(
        json[keyField] as String,
        json[idField] as int,
        json[nameField] as String,
        json[surnameField] as String,
        json[apiField] as String,
        json[organizationField] as String);
  }

  String getFullName() => "$nom $cognoms";

  bool isValid() {
    return key.isNotEmpty || nom.isNotEmpty;
  }

  @override
  toString() {
    return '{ $key, $nom }';
  }
}
