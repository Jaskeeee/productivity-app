import 'package:flutter/material.dart';

ThemeData darkTheme = ThemeData(
  scaffoldBackgroundColor: Colors.black,
  colorScheme: ColorScheme.dark(
    primary: Colors.grey.shade800,
    secondary: Color.fromARGB(255,30,30,30),
    tertiary: Color.fromARGB(255,15,15,15),
    inversePrimary: Colors.white,
    error: Colors.red
  )
);