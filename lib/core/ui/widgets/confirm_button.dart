import 'package:flutter/material.dart';

class ConfirmButton extends StatelessWidget {
  final String text;
  final void Function() onPressed;
  const ConfirmButton({
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
          color: Theme.of(context).colorScheme.inversePrimary,
        ),
        child: Text(
          text,
          style: TextStyle(
            color: Theme.of(context).scaffoldBackgroundColor,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
