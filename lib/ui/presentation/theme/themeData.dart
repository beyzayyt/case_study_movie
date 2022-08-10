import 'package:flutter/material.dart';

enum AppTheme {
  LightAppTheme,
  DarkAppTheme,
}

final appThemeData = {
  AppTheme.DarkAppTheme: ThemeData(
    brightness: Brightness.dark,
    secondaryHeaderColor: Colors.grey[800],
    scaffoldBackgroundColor: Colors.black,
    primaryColor: Colors.amber,
    textTheme: TextTheme(
      headline3: const TextStyle().copyWith(color: Colors.white),
      subtitle1: const TextStyle().copyWith(color: Colors.white),
    ),
  ),
  AppTheme.LightAppTheme: ThemeData(
    brightness: Brightness.light,
    secondaryHeaderColor: Colors.amber[200],
    scaffoldBackgroundColor: Colors.white,
    primaryColor: Colors.amber,
    textTheme: TextTheme(
    headline3: const TextStyle().copyWith(color: Colors.black),
      subtitle1: const TextStyle().copyWith(color: Colors.black)
  ),
  ),
};
