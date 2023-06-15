import 'package:flutter/material.dart';

// Colors

var primaryColor = const Color.fromRGBO(217, 48, 29, 1);
var primaryColorDark = const Color.fromARGB(255, 155, 28, 18);
var primaryColorLight = const Color.fromARGB(255, 240, 133, 127);
var secondaryColor = const Color(0xFFFFFFFF);
var secondaryColorDark = const Color(0xffc0ae75);
var cardColor = Colors.grey.shade100;
var backgroundColor = Colors.grey.shade50;

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
  cardColor: cardColor,
  backgroundColor: backgroundColor,
);

TextTheme textTheme = TextTheme(
    bodyLarge: TextStyle(
      fontSize: 14,
      color: primaryColor,
    ),
    bodyMedium: const TextStyle(fontSize: 14),
    displayLarge: const TextStyle(
      fontSize: 36.0,
      fontWeight: FontWeight.bold,
    ),
    headlineSmall: TextStyle(
      fontSize: 20.0,
      fontWeight: FontWeight.bold,
      color: primaryColor,
    ),
    titleLarge: TextStyle(
      fontSize: 20,
      fontWeight: FontWeight.bold,
      color: primaryColor,
    ),
    titleMedium: TextStyle(
      fontSize: 15.0,
      fontWeight: FontWeight.bold,
      color: primaryColor,
    ),
    titleSmall: TextStyle(
      fontSize: 12.0,
      fontWeight: FontWeight.bold,
      color: primaryColor,
    ),
    labelMedium: TextStyle(
      fontSize: 15.0,
      color: secondaryColor,
    ));

var cendrassosTheme = ThemeData(
  primaryColor: primaryColor,
  primaryColorLight: primaryColorLight,
  primaryColorDark: primaryColorDark,
  colorScheme: colorScheme,
  textTheme: textTheme,
);
