import 'package:flutter/material.dart';

// Colors de l'aplicació
var primaryColor = const Color.fromRGBO(217, 48, 29, 1);
var primaryColorDark = const Color.fromARGB(255, 105, 18, 8);
var primaryColorLight = const Color.fromARGB(255, 238, 144, 134);
var secondaryColor = const Color(0xFFFFFFFF);
var secondaryColorDark = const Color(0xffc0ae75);

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

// Forma dels diferents tipus de text

TextTheme textScheme = const TextTheme(
  bodyLarge: TextStyle(
    fontSize: 14,
    color: Color.fromRGBO(217, 48, 29, 1),
  ),
  bodyMedium: TextStyle(fontSize: 14),
  displayLarge: TextStyle(
    fontSize: 36.0,
    fontWeight: FontWeight.bold,
  ),
  headlineSmall: TextStyle(
    fontSize: 20.0,
    fontWeight: FontWeight.bold,
    color: Color.fromRGBO(217, 48, 29, 1),
  ),
  titleLarge: TextStyle(
    color: Color.fromRGBO(217, 48, 29, 1),
  ),
  titleMedium: TextStyle(
    fontSize: 15.0,
    fontWeight: FontWeight.bold,
    color: Color.fromRGBO(217, 48, 29, 1),
  ),
);

var cendrassosTheme = ThemeData(
  primaryColor: primaryColor,
  primaryColorLight: primaryColorLight,
  primaryColorDark: primaryColorDark,
  colorScheme: colorScheme,
  textTheme: textScheme,
);

// Llista dels tipus de notificacions i els colors amb el que es ressaltaran
// -------------------------------------------------------------------
// Cal comprovar que el text és el que arriba en la notificació. Si en calen
// més, s'afegeixen.

Map<String, Color> notificacionsColor = {
  "Falta": const Color(0xFF00BCD4),
  "Justificada": const Color(0xFF4CAF50),
  "Incidència": const Color(0xFFFF9800),
  "Expulsió": const Color(0xFFF44336),
  "Observació": const Color.fromARGB(255, 197, 116, 190),
};

// Textos dels missatges d'error
// -------------------------------------------------------------------
const String missatgeCarregantDades = "Carregant dades";
const String missatgeTornaAProvar = "Torna-ho a provar";
const String missatgeOk = "D'acord";
const String noInternet =
    "Hi ha problemes per accedir a la xarxa. Proveu-ho més tard";
const String errorCarregant =
    "ERROR carregant les dades. Torna-ho a provar més tard";
