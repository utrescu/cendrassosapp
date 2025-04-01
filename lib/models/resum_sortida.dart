import 'package:intl/intl.dart';

class ResumSortida {
  final int id;
  final String titol;
  final String data;
  final bool pagament;
  final bool realitzat;

  static DateFormat formatter = DateFormat('yyyy-MM-dd HH:mm:ss');

  // Personalitzar els camps de login
  static String idField = 'id';
  static String titolField = 'titol';
  static String dataField = 'data';
  static String pagamentField = 'pagament';
  static String realitzatField = "realitzat";

  ResumSortida(
    this.id,
    this.titol,
    this.data,
    this.pagament,
    this.realitzat,
  );

  @override
  bool operator ==(Object other) =>
      other is ResumSortida && other.id == id;

  factory ResumSortida.fromJson(dynamic json) {
    return ResumSortida(
      json[idField] as int,
      json[titolField] as String,
      json[dataField] as String,
      json[pagamentField] as bool,
      json[realitzatField] as bool,
    );
  }

  
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data[idField] = id;
    data[titolField] = titol;
    data[dataField] = data;
    data[pagamentField] = pagament;
    data[realitzatField] = realitzat;
    return data;
  }
}
