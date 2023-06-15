import 'dart:convert';

import 'package:cendrassos/cendrassos_theme.dart';
import 'package:cendrassos/config_cendrassos.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

List<String> tipusNotificacio = notificacionsColor.keys.toList();

List<Notificacio> notificacioFromJson(String str) => List<Notificacio>.from(
    json.decode(str).map((x) => Notificacio.fromJson(x)));

class Notificacio {
  final DateTime dia;
  final String hora;
  final String professor;
  final String text;
  final String tipus;

  Notificacio(this.dia, this.hora, this.professor, this.text, this.tipus);

  Notificacio.fromJson(Map<String, dynamic> json)
      : dia = DateFormat('dd/M/yyyy').parse(json['dia']),
        hora = json['hora'] ?? "",
        professor = json['professor'] ?? "",
        text = json['text'] ?? "",
        tipus = json['tipus'] ?? "Desconeguda";

  Map<String, dynamic> toJson() => {
        'dia': DateFormat('dd/MM/yyyy').format(dia),
        'hora': hora,
        'professor': professor,
        'text': text,
        'tipus': tipus
      };

  @override
  String toString() => "$hora hora - $tipus - $professor : $text";

  static int getHashCode(DateTime key) {
    return key.day * 1000000 + key.month * 10000 + key.year;
  }

  Color getColor() {
    var color = notificacionsColor[tipus];
    return color ?? defaultColor;
  }

  static bool isSameDay(DateTime? dateA, DateTime? dateB) {
    return dateA?.year == dateB?.year &&
        dateA?.month == dateB?.month &&
        dateA?.day == dateB?.day;
  }

  String getData() {
    final DateFormat formatter = DateFormat('yyyy-MM-dd');
    return formatter.format(dia);
  }
}
