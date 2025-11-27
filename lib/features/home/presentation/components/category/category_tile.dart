import 'package:flutter/material.dart';
import 'package:productivity_app/core/themes/themes.dart';
import 'package:productivity_app/core/utils.dart';

class CategoryTile extends StatelessWidget {
  final String title;
  final Color color;
  final int completed;
  final IconData iconData;
  final int value;
  final void Function() onTap;
  final void Function() deleteFunction;
  const CategoryTile({
    super.key,
    required this.completed,
    required this.title,
    required this.value,
    required this.color,
    required this.iconData,
    required this.onTap,
    required this.deleteFunction,
  });
  @override
  Widget build(BuildContext context) {
    final Color elementColor = handleCategoryTileElementColor(color);
    final Color subtitleColor = handleCategoryTileSubheaderColor(color);
    final double categoryCompletion = completionValue(
      value.toDouble(),
      completed.toDouble(),
    );
    return Padding(
      padding: const EdgeInsets.only(top: 5, bottom: 5),
      child: ListTile(
        onTap: onTap,
        tileColor: color,
        subtitle: Text(
          "value :$value completed: $completed",
          style: TextStyle(
            color: subtitleColor,
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
        contentPadding: EdgeInsets.fromLTRB(20, 10, 20, 10),
        title: Text(
          title,
          style: TextStyle(
            color: elementColor,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        trailing: Text(
          "${(categoryCompletion * 100).round()}%",
          style: TextStyle(
            color: elementColor,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        leading: Icon(iconData, size: 30, color: elementColor),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadiusGeometry.circular(15),
        ),
      ),
    );
  }
}
