import 'package:flutter/material.dart';

class AttributeText extends StatelessWidget {
  final String text;
  final void Function() onPress;
  const AttributeText({
    super.key,
    required this.text,
    required this.onPress
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPress,
      child: Text(
        text,
        style: TextStyle(
          color: Theme.of(context).colorScheme.primary,
          fontSize: 14,
        fontWeight: FontWeight.w400
        ),
      ),
    );
  }
}