import 'package:flutter/material.dart';

// Colors

var primaryColor = const Color.fromRGBO(217, 48, 29, 1);
var primaryColorDark = const Color.fromARGB(255, 105, 18, 8);
var primaryColorLight = Color.fromARGB(255, 238, 144, 134);
var primaryColorUltraLight = Color.fromARGB(255, 240, 206, 203);
var secondaryColor = const Color(0xFFFFFFFF);
var secondaryColorDark = const Color(0xffc0ae75);
var secondaryColorLight = Color.fromARGB(255, 233, 231, 231);

Map<String, Color> notificacionsColor = {
  "falta": const Color(0xFF00BCD4),
  "justificada": const Color(0xFF4CAF50),
  "incidencia": const Color(0xFFFF9800),
  "expulsio": const Color(0xFFF44336),
  "observacio": Color.fromARGB(255, 197, 116, 190),
};

var defaultColor = const Color(0x000000FF);

Map<int, Color> _primaryColorMap = {
  050: Color.fromRGBO(
      primaryColor.red, primaryColor.green, primaryColor.blue, .1),
  100: Color.fromRGBO(
      primaryColor.red, primaryColor.green, primaryColor.blue, .2),
  200: Color.fromRGBO(
      primaryColor.red, primaryColor.green, primaryColor.blue, .3),
  300: Color.fromRGBO(
      primaryColor.red, primaryColor.green, primaryColor.blue, .4),
  400: Color.fromRGBO(
      primaryColor.red, primaryColor.green, primaryColor.blue, .5),
  500: Color.fromRGBO(
      primaryColor.red, primaryColor.green, primaryColor.blue, .6),
  600: Color.fromRGBO(
      primaryColor.red, primaryColor.green, primaryColor.blue, .7),
  700: Color.fromRGBO(
      primaryColor.red, primaryColor.green, primaryColor.blue, .8),
  800: Color.fromRGBO(
      primaryColor.red, primaryColor.green, primaryColor.blue, .9),
  900: Color.fromRGBO(
      primaryColor.red, primaryColor.green, primaryColor.blue, 1),
};

MaterialColor primarySwatch =
    MaterialColor(primaryColor.value, _primaryColorMap);

ColorScheme colorScheme = ColorScheme.fromSwatch(
  primarySwatch: primarySwatch,
  primaryColorDark: primaryColorDark,
  brightness: Brightness.light,
  accentColor: secondaryColorDark,
  cardColor: Colors.grey.shade100,
  backgroundColor: Colors.grey.shade50,
);

var cendrassosTheme = ThemeData.from(colorScheme: colorScheme);

// Mida dels textos

var buttonFontSize = 15.0;
var defaultFontSize = 14.0;
var titleFontSize = 20.0;
