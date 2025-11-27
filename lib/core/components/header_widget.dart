import 'package:flutter/material.dart';

class HeaderWidget extends StatelessWidget {
  final String title;
  final Widget trailing;
  final IconData iconData;
  const HeaderWidget({
    super.key,
    required this.title,
    required this.iconData,
    required this.trailing
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          iconData,
          color: Theme.of(context).colorScheme.inversePrimary,
          size: 25,
        ),
        SizedBox(width: 10),
        Text(
          title,
          style: TextStyle(
            color: Theme.of(context).colorScheme.inversePrimary,
            fontWeight: FontWeight.bold,
            fontSize: 25,
          ),
        ),
        Spacer(),
        trailing,
        SizedBox(width:10)
      ],
    );
  }
}