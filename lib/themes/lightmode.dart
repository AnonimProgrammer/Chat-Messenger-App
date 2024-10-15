import 'package:flutter/material.dart';

// Light Mode Theme
ThemeData lightmode = ThemeData(
  brightness: Brightness.light,
  colorScheme: ColorScheme.light(
    surface: Colors.grey.shade300,
    primary: const Color.fromARGB(255, 150, 150, 150),
    secondary: Colors.grey.shade200,
    tertiary: Colors.white,
    inverseSurface: Colors.grey.shade700,
    inversePrimary: Colors.grey.shade900,
  ),
);
