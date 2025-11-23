
import 'package:flutter/material.dart';

final String googleLogo =  "assets/logo/google_logo.png";
final List<String> weekdays = [
  '',
  'Mon',
  'Tue',
  'Wed',
  'Thu',
  'Fri',
  'Sat',
  'Sun',
];
final List<String> months=[
  "",
  "Jan",
  "Feb",
  "Mar",
  "Apr",
  "May",
  "Jun",
  "July",
  "Aug",
  "Sep",
  "Oct",
  "Nov",
  "Dec"
];


double colorLuminance(Color color){
  return color.computeLuminance();
}

