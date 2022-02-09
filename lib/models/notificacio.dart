import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

enum NotificacioType { observacio, falta, incidencia, expulsio }

extension ParseToString on NotificacioType {
  String toShortString() {
    return this.toString().split('.').last;
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

  Notificacio(this.dia, this.hora, this.professor, this.text, this.tipus);

  Notificacio.fromJson(Map<String, dynamic> json)
      : dia = DateFormat('dd/MM/yyyy').parse(json['dia']),
        hora = json['hora'] ?? "",
        professor = json['professor'] ?? "",
        text = json['text'] ?? "",
        tipus = NotificacioType.values.firstWhere(
            (e) => e.toString() == 'NotificacioType.' + json['tipus']);

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
    switch (this.tipus) {
      case NotificacioType.falta:
        return const Color(0xFF00BCD4);
      case NotificacioType.incidencia:
        return const Color(0xFFFF9800);
      case NotificacioType.expulsio:
        return const Color(0xFFF44336);
      case NotificacioType.observacio:
        return const Color(0xFF4CAF50);
    }
    // return Color(0x00000000);
  }

  static bool isSameDay(DateTime? dateA, DateTime? dateB) {
    return dateA?.year == dateB?.year &&
        dateA?.month == dateB?.month &&
        dateA?.day == dateB?.day;
  }
}
