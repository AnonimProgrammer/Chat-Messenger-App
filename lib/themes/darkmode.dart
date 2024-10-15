import 'package:flutter/material.dart';

// Dark Mode Theme
ThemeData darkmode = ThemeData(
  brightness: Brightness.dark,
  colorScheme: ColorScheme.dark(
    surface: Colors.grey.shade900,
    primary: const Color.fromARGB(255, 150, 150, 150),
    secondary: Colors.grey.shade800,
    tertiary: Colors.black,
    inverseSurface: Colors.grey.shade300,
    inversePrimary: Colors.grey.shade200,
  ),
);
