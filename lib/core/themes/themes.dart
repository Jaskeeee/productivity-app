import 'package:easy_date_timeline/easy_date_timeline.dart';
import 'package:flutter/material.dart';

ThemeData darkTheme = ThemeData(
  scaffoldBackgroundColor: Colors.black,
  colorScheme: ColorScheme.dark(
    primary: Colors.grey.shade800,
    secondary: Color.fromARGB(255,30,30,30),
    tertiary: Color.fromARGB(255,15,15,15),
    inversePrimary: Colors.white,
    error: Colors.red
  ),
  fontFamily: 'IBMPlexMono',
  listTileTheme: ListTileThemeData(
    titleTextStyle: TextStyle(fontFamily: "IBMPlexMono")
  ),
);
MonthYearThemeData monthYearThemeData = MonthYearThemeData(
  shape: RoundedRectangleBorder(
    borderRadius: BorderRadiusGeometry.circular(15),
  ),
  textStyle: TextStyle(
    color: darkTheme.colorScheme.inversePrimary,
  )
);