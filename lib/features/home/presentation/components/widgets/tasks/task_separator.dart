import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';

class TaskSeparator extends StatelessWidget {
  final String title;
  const TaskSeparator({
    super.key,
    required this.title
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          title,
          style: TextStyle(
            color: Theme.of(context).colorScheme.primary,
            fontSize: 16
          ),
        ),
        SizedBox(width: 10),
        Expanded(
          child: DottedLine(
            dashColor: Theme.of(context).colorScheme.primary,
            lineThickness: 1.0,
            direction: Axis.horizontal,
          ),
        )
      ],
    );
  }
}