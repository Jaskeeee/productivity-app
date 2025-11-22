import 'package:flutter/material.dart';

class ActionButton extends StatelessWidget {
  final void Function() onPressed;
  final Alignment buttonAlignment;
  final IconData iconData;
  final String title;
  final Color color;
  final Color itemColor;
  const ActionButton({
    super.key,
    required this.onPressed,
    required this.title,
    required this.iconData,
    required this.color,
    required this.itemColor,
    required this.buttonAlignment
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        alignment:buttonAlignment,
        padding: EdgeInsets.fromLTRB(30,15,30,15),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(50),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              title,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: itemColor,
                fontSize: 25
              ),
            ),
            SizedBox(width: 20,),
            Icon(
              iconData,
              size: 25,
              color: itemColor,
            )
          ],
        ),
      ),
    );
  }
}