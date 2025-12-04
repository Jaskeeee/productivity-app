
import 'package:flutter/material.dart';
import 'package:productivity_app/core/models/tab_item_model.dart';

final List<String> weekdayAbbreviations = [
  '',
  'Mon', 
  'Tue',
  'Wed',
  'Thu',
  'Fri',
  'Sat',
  'Sun',
];
final List<String> monthAbbreviations=[
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


final List<TabItemModel> tabitems = [
  // TabItemModel(title: "home", iconData: Icons.home_outlined),
  TabItemModel(title: "stats", iconData: Icons.query_stats_outlined,),
  TabItemModel(title: "profile", iconData: Icons.account_circle_outlined)
];