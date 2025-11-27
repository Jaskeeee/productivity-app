import 'package:flutter/material.dart';

class TaskTile extends StatelessWidget {
  final String title;
  final bool isCompleted;
  final void Function(bool?) onChanged;
  TaskTile({
    super.key, 
    required this.title,
    required this.isCompleted,
    required this.onChanged
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top:5,bottom: 5),
      child: ListTile(
        title: Text(title),
        titleTextStyle: TextStyle(
          fontFamily: 'IBMPlexMono',
          color: Theme.of(context).colorScheme.inversePrimary,
          decoration: isCompleted? TextDecoration.lineThrough :TextDecoration.none,
          fontSize: 16,
        ),
        leading: Checkbox(
          value: isCompleted,
          checkColor: Colors.green, 
          shape: CircleBorder(
            side: BorderSide(
              color: Theme.of(context).colorScheme.inversePrimary
            )
          ),
          onChanged: onChanged
        ),
        shape: RoundedRectangleBorder(
          side: BorderSide(
            color: Theme.of(context).colorScheme.primary,
            width: 1
          ),
          borderRadius: BorderRadius.circular(15),
        ),
      ),
    );
  }
}
