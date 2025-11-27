import 'package:easy_date_timeline/easy_date_timeline.dart';
import 'package:flutter/material.dart';

final ThemeData darkTheme = ThemeData(
  scaffoldBackgroundColor: Colors.black,
  colorScheme: ColorScheme.dark(
    primary: Colors.grey.shade800,
    secondary: Color.fromARGB(255, 30, 30, 30),
    tertiary: Color.fromARGB(255, 15, 15, 15),
    inversePrimary: Colors.white,
    error: Colors.red,
  ),
  fontFamily: 'IBMPlexMono',
  listTileTheme: ListTileThemeData(
    titleTextStyle: TextStyle(fontFamily: "IBMPlexMono"),
  ),
);
MonthYearThemeData monthYearThemeData = MonthYearThemeData(
  shape: RoundedRectangleBorder(
    borderRadius: BorderRadiusGeometry.circular(15),
  ),
  textStyle: TextStyle(color: darkTheme.colorScheme.inversePrimary),
);

// Add Cateogry Values are hardcoded as the behaviours remains the same despite the theme
final LinearGradient shader = LinearGradient(
  begin: Alignment.centerLeft,
  end: Alignment.centerRight,
  stops: [0.0, 0.1, 0.2, 0.8, 0.9, 1.0],
  colors: [
    Colors.black,
    Colors.transparent,
    Colors.transparent,
    Colors.transparent,
    Colors.transparent,
    Colors.black,
  ],
);

Color handleLuminance(Color color) {
  return color.computeLuminance() > 0.4 ? Colors.black : Colors.white;
}
Color handleSuggsetionsColor(Color color){
  return color.computeLuminance() >0.5 ?Colors.grey.shade800 :Colors.grey;
}
Color handleDefaultValueColor(Color color){
  return color.computeLuminance() > 0.5 ?Colors.black:Colors.white; 
}
Color invertedDefaultValue(Color color){
  return color.computeLuminance() > 0.5 ?Colors.black :Colors.white; 
}

Color handleCategoryTileElementColor(Color color){
  return color.computeLuminance() > 0.03
    ?Colors.black
    :Colors.white;
}
Color handleCategoryTileSubheaderColor(Color color){
  return color.computeLuminance() > 0.03
    ?Colors.grey.shade800
    :Colors.grey;
}

Color borderColorSelect(Color color) {
  final double lum = color.computeLuminance();
  if (lum < 0.03) {
    return Colors.grey.shade800;
  } else if (lum > 0.4) {
    return Colors.black;
  } else {
    return Colors.white;
  }
}