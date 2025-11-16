import 'package:flutter/material.dart';

class AuthButtons extends StatelessWidget {
  final String text;
  final void Function() onPressed;
  const AuthButtons({
    super.key,
    required this.onPressed,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        alignment: Alignment.center,
        margin: EdgeInsets.only(left:30,right:30),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.inversePrimary,
          borderRadius: BorderRadius.circular(30)
        ),
        padding: EdgeInsets.only(top:15,bottom: 15),
        child: Center(
          child: Text(
            text,
            style: TextStyle(
              color: Theme.of(context).scaffoldBackgroundColor,
              fontWeight: FontWeight.bold,
              fontSize: 25
            ),
          ),
        ),
      ),
    );
  }
}