import 'dart:convert';

import 'package:cendrassos/cendrassos_theme.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

/// Tipus de notificacions
///
/// Com que els tipus de notificacions són dinàmics, es crea una llista amb
/// els possibles noms per emplenar les notificacions a partir dels noms
/// de la configuració
List<String> tipusNotificacio = notificacionsColor.keys.toList();

// Crea una llista de notificacions a partir d'un string JSON
List<Notificacio> notificacioFromJson(String str) => List<Notificacio>.from(
    json.decode(str).map((x) => Notificacio.fromJson(x)));

/// Defineix una notificació.
///
/// Només es fa servir per mostrar-la a la UI
///
/// - Data [dia]
/// - Hora [hora]
/// - Professor [professor]
/// - [text] de la notificació
/// - [tipus] de notificació
///
/// No s'emmagatzema
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

  /// Obtenir el color de la notificació.
  ///
  /// Si no està definit retorna
  /// el color per defecte definit en la configuració
  Color getColor() {
    var color = notificacionsColor[tipus];
    return color ?? defaultColor;
  }

  /// Comprova si una notificació és del mateix dia que una altra.
  ///
  /// Es fa servir per ordenar
  static bool isSameDay(DateTime? dateA, DateTime? dateB) {
    return dateA?.year == dateB?.year &&
        dateA?.month == dateB?.month &&
        dateA?.day == dateB?.day;
  }
}
