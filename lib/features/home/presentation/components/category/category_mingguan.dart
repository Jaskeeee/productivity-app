import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:productivity_app/features/home/domain/model/category_model.dart';

class CategoryMingguan extends StatelessWidget {
  final List<CategoryModel> categories;
  const CategoryMingguan({
    super.key,
    required this.categories
  });

  @override
  Widget build(BuildContext context) {
    return BarChart(
      BarChartData(
        
      )
    );
  }
}