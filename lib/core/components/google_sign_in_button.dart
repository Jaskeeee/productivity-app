import 'package:flutter/material.dart';
import 'package:productivity_app/core/utils.dart';

class GoogleSignInButton extends StatelessWidget {
  const GoogleSignInButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
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
    );
  }
}