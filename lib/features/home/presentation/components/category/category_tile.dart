import 'package:flutter/material.dart';
import 'package:productivity_app/core/utils.dart';

class CategoryTile extends StatelessWidget {
  final String title;
  final Color color;
  final IconData iconData;
  final int value;
  final void Function() onTap;
  final void Function() deleteFunction;
  const CategoryTile({
    super.key,
    required this.title,
    required this.value,
    required this.color,
    required this.iconData,
    required this.onTap,
    required this.deleteFunction
  });

  @override
  Widget build(BuildContext context) {
    final Color elementColor = colorLuminance(color) > 0.03
    ?Theme.of(context).scaffoldBackgroundColor
    :Theme.of(context).colorScheme.inversePrimary;
    final Color subtitleColor = colorLuminance(color)> 0.03
    ?Theme.of(context).colorScheme.primary
    :Colors.grey;
    return Padding(
      padding: const EdgeInsets.only(top:5,bottom:5),
      child: ListTile(
        onTap: onTap,
        tileColor: color,
        subtitle: Text(
          value.toString(),
          style:TextStyle(
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
            fontWeight: FontWeight.bold
          ),
        ),
        trailing: IconButton(
          onPressed: deleteFunction,
          icon: Icon(
            Icons.delete_outline_outlined,
            color: elementColor,
          ),
          iconSize: 25,
        ),
        leading: Icon(
          iconData,
          size: 25,
          color: elementColor,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadiusGeometry.circular(15)
        ),
      ),
    );
  }
}