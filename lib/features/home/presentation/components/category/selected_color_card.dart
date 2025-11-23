import 'package:flutter/material.dart';

class SelectedColorCard extends StatelessWidget {
  final Color color;
  final Color borderColor;
  final bool hasError;
  final void Function() onPressed;
  const SelectedColorCard({
    super.key,
    required this.borderColor,
    required this.hasError,
    this.color=Colors.blueAccent,
    required this.onPressed
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        padding: EdgeInsets.all(5),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Theme.of(context).scaffoldBackgroundColor,
          border: Border.all(
            color: hasError ?Theme.of(context).colorScheme.error:borderColor,
            style: BorderStyle.solid,
            width: 2
          )
        ),
        child: Container(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: color
          ),
          width: 30, 
          height: 30,
        ) 
      ),
    );
  }
}
