import 'package:flutter/material.dart';

final primaryColor = Color(0xff082659);
final secondaryColor = Color(0xff51eec2);

final appTheme = ThemeData(
  appBarTheme: AppBarTheme(
    backgroundColor: primaryColor,
    centerTitle: true,
  ),
  iconTheme: IconThemeData(color: secondaryColor),
  brightness: Brightness.light,
  primaryColor: primaryColor,
  colorScheme: ColorScheme.light(
    primary: primaryColor,
  ),
  progressIndicatorTheme: ProgressIndicatorThemeData(color: primaryColor),
  floatingActionButtonTheme: FloatingActionButtonThemeData(
    backgroundColor: primaryColor,
    foregroundColor: secondaryColor,
  ),
  inputDecorationTheme: InputDecorationTheme(
    floatingLabelStyle: TextStyle(color: primaryColor),
    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(color: secondaryColor),
      borderRadius: BorderRadius.circular(8),
    ),
    border: OutlineInputBorder(
      borderSide: BorderSide(color: primaryColor),
      borderRadius: BorderRadius.circular(8),
    ),
  ),
);
