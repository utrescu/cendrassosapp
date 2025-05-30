import 'package:intl/intl.dart';

class Sortida {
  final int? idPagament;
  final String titol;
  final String desde;
  final String finsa;
  final String programa;
  final String preu;
  final String dataLimit;
  final bool realitzat;

  static DateFormat formatter = DateFormat('yyyy-MM-dd HH:mm:ss');

  // Personalitzar els camps de login
  static String idPagamentField = 'idPagament';
  static String titolField = 'titol';
  static String desdeField = 'desde';
  static String finsaField = 'finsa';
  static String programaField = 'programa';
  static String preuField = "preu";
  static String dataLimitField = "dataLimitPagament";
  static String realitzatField = "realitzat";

  Sortida(this.titol, this.desde, this.finsa, this.programa, this.preu,
      this.dataLimit, this.realitzat, this.idPagament);

  factory Sortida.fromJson(dynamic json) {
    return Sortida(
      json[titolField] as String,
      json[desdeField] as String,
      json[finsaField] as String,
      json[programaField] as String,
      json[preuField] as String,
      json[dataLimitField] as String,
      json[realitzatField] as bool,
      json[idPagamentField] as int?,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> dades = <String, dynamic>{};
    dades[titolField] = titol;
    dades[desdeField] = desde;
    dades[finsaField] = finsa;
    dades[programaField] = programa;
    dades[preuField] = preu;
    dades[dataLimitField] = dataLimit;
    dades[realitzatField] = realitzat;
    dades[idPagamentField] = idPagament;
    return dades;
  }
}
