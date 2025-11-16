import 'package:flutter/material.dart';

class SectionDivider extends StatelessWidget {
  const SectionDivider({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Divider(
          thickness: 1,
          color: Theme.of(context).colorScheme.primary,
        ),
        Container(
          padding: EdgeInsets.all(10),
          color: Theme.of(context).scaffoldBackgroundColor,
          child: Text(
            "or",
            style: TextStyle(
              color: Theme.of(context).colorScheme.primary,
              fontSize: 15
            ),
          ),
        )
      ]
    );
  }
}