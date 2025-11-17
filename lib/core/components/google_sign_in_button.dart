import 'package:flutter/material.dart';
import 'package:productivity_app/core/utils.dart';

class GoogleSignInButton extends StatelessWidget {
  final void Function() onPressed;
  const GoogleSignInButton({
    super.key,
    required this.onPressed
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: GestureDetector(
        onTap: onPressed,
        child: Container(
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.secondary,
            borderRadius: BorderRadius.circular(15)
          ),
          child: Image.asset(
            googleLogo,
            width: 40,
            height: 40,
          )
        ),
      ),
    );
  }
}