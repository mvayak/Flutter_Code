import 'package:flutter/material.dart';
import 'package:marlo/utility/colors.dart';

ThemeData darkTheme = ThemeData(
    fontFamily: "Heebo",
    appBarTheme: const AppBarTheme(backgroundColor: color000000),
    brightness: Brightness.dark,
    backgroundColor: color000000,
    primaryColor: color0CABDF,
    cardColor: color161618,
    textTheme: darkTextTheme,
    primaryIconTheme:  const IconThemeData(color: color000000),
    iconTheme: const IconThemeData(color: colorFFFFFF),
    buttonTheme: const ButtonThemeData(
      buttonColor: color0CABDF,
      disabledColor: color0CABDF,
    ));

ThemeData lightTheme = ThemeData(
    fontFamily: "Heebo",
    appBarTheme: const AppBarTheme(backgroundColor: colorF7F7F7),
    brightness: Brightness.light,
    backgroundColor: colorF7F7F7,
    primaryColor: color0CABDF,
    primaryIconTheme:  const IconThemeData(color: colorFFFFFF),
    iconTheme: const IconThemeData(color: color000000),
    textTheme: lightTextTheme,
    cardColor: colorFFFFFF,
    buttonTheme: const ButtonThemeData(
      buttonColor: color0CABDF,
      disabledColor: color0CABDF,
    ));

TextTheme lightTextTheme = const TextTheme(
  displayLarge: TextStyle(fontSize: 57, color: color000000, fontWeight: FontWeight.w800),
  bodyMedium: TextStyle(fontSize: 45, color: color000000, fontWeight: FontWeight.w800),
  displaySmall: TextStyle(fontSize: 36, color: color000000, fontWeight: FontWeight.w800),
  titleLarge: TextStyle(fontSize: 22, color: color000000, fontWeight: FontWeight.w600),
  titleMedium: TextStyle(fontSize: 16, color: color000000, fontWeight: FontWeight.w600),
  titleSmall: TextStyle(fontSize: 14, color: color000000, fontWeight: FontWeight.w600),
);

TextTheme darkTextTheme = const TextTheme(
  displayLarge: TextStyle(fontSize: 57, color: colorFFFFFF, fontWeight: FontWeight.w800),
  bodyMedium: TextStyle(fontSize: 45, color: colorFFFFFF, fontWeight: FontWeight.w800),
  displaySmall: TextStyle(fontSize: 36, color: colorFFFFFF, fontWeight: FontWeight.w800),
  titleLarge: TextStyle(fontSize: 22, color: colorFFFFFF, fontWeight: FontWeight.w600),
  titleMedium: TextStyle(fontSize: 18, color: colorFFFFFF, fontWeight: FontWeight.w600),
  titleSmall: TextStyle(fontSize: 14, color: colorFFFFFF, fontWeight: FontWeight.w500),
);
