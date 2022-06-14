import 'dart:convert';

import 'package:cendrassos/cendrassos_theme.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

enum NotificacioType {
  observacio,
  falta,
  justificada,
  incidencia,
  expulsio,
  desconeguda
}

const Map<String, NotificacioType> traduccions = {
  "Observació": NotificacioType.observacio,
  "Falta": NotificacioType.falta,
  "Incidència": NotificacioType.incidencia,
  "Justificada": NotificacioType.justificada,
  "Expulsió": NotificacioType.expulsio
};

extension ParseToString on NotificacioType {
  String toShortString() {
    return toString().split('.').last;
  }
}

List<Notificacio> notificacioFromJson(String str) => List<Notificacio>.from(
    json.decode(str).map((x) => Notificacio.fromJson(x)));

class Notificacio {
  final DateTime dia;
  final String hora;
  final String professor;
  final String text;
  final NotificacioType tipus;

  static NotificacioType tradueix(String nom) {
    if (traduccions[nom] != null) {
      return traduccions[nom]!;
    } else {
      return NotificacioType.desconeguda;
    }
  }

  Notificacio(this.dia, this.hora, this.professor, this.text, this.tipus);

  Notificacio.fromJson(Map<String, dynamic> json)
      : dia = DateFormat('dd/M/yyyy').parse(json['dia']),
        hora = json['hora'] ?? "",
        professor = json['professor'] ?? "",
        text = json['text'] ?? "",
        tipus = tradueix(json['tipus']);

  Map<String, dynamic> toJson() => {
        'dia': DateFormat('dd/MM/yyyy').format(dia),
        'hora': hora,
        'professor': professor,
        'text': text,
        'tipus': tipus.toShortString()
      };

  @override
  String toString() =>
      "$hora hora - ${tipus.toShortString()} - $professor : $text";

  static int getHashCode(DateTime key) {
    return key.day * 1000000 + key.month * 10000 + key.year;
  }

  Color getColor() {
    var color = notificacionsColor[tipus.toShortString()];
    return color ?? defaultColor;
  }

  static bool isSameDay(DateTime? dateA, DateTime? dateB) {
    return dateA?.year == dateB?.year &&
        dateA?.month == dateB?.month &&
        dateA?.day == dateB?.day;
  }
}
