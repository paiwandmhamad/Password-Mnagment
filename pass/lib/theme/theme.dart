import 'package:flutter/material.dart';

ThemeData lightMode = ThemeData(
  brightness: Brightness.light,
  colorScheme: ColorScheme.light(
    background: const Color.fromARGB(173, 252, 250, 250),
    primary: const Color.fromARGB(255, 82, 81, 81),
    secondary: Colors.orange.shade800,
  ),
);

ThemeData darkMode = ThemeData(
    brightness: Brightness.dark,
    colorScheme: const ColorScheme.dark(
        background: Color.fromARGB(0, 24, 24, 24),
        primary: Color.fromARGB(255, 243, 242, 242),
        secondary: Color.fromARGB(80, 158, 158, 158)));
