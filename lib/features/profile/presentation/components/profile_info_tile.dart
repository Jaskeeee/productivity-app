import 'package:flutter/material.dart';

class ProfileInfoTile extends StatelessWidget {
  final String title;
  final String value;
  const ProfileInfoTile({super.key, required this.title, required this.value});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          "$title:",
          style: TextStyle(
            color: Theme.of(context).colorScheme.inversePrimary,
            fontSize: 18,
          ),
        ),
        Spacer(),
        Text(
          value,
          style: TextStyle(
            color: Theme.of(context).colorScheme.primary,
            fontSize: 18,
          ),
        ),
      ],
    );
  }
}
