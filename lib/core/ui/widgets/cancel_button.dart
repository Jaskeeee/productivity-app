import 'package:flutter/material.dart';

class CancelButton extends StatelessWidget {
  final String text;
  final void Function() onPressed;
  const CancelButton({
    super.key,
    required this.text,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        margin: EdgeInsets.fromLTRB(20, 10, 20, 10),
        padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Theme.of(context).colorScheme.primary,
        ),
        child: Text(
          text,
          style: TextStyle(
            color: Theme.of(context).colorScheme.inversePrimary,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
