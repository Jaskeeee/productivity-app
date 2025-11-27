

import 'package:flutter/material.dart';
import 'package:productivity_app/core/models/tab_item_model.dart';

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

final List<String> taskOccurrences= [
  "none",
  "daily",
  "weekly",
  "monthly"
];

final List<TabItemModel> tabitems = [
  // TabItemModel(title: "home", iconData: Icons.home_outlined),
  TabItemModel(title: "stats", iconData: Icons.query_stats_outlined,),
  TabItemModel(title: "profile", iconData: Icons.account_circle_outlined)
];

double completionValue(double value,double completed) {
  if (value == 0) return 0.0;
  return (completed / value).toDouble();
}
