import 'package:flutter/material.dart';

class TaskTile extends StatefulWidget {
  final String title;
  final bool isCompleted;
  final void Function(bool?) onChanged;
  const TaskTile({
    super.key, 
    required this.title,
    required this.isCompleted,
    required this.onChanged
  });
  @override
  State<TaskTile> createState() => _TaskTileState();
}

class _TaskTileState extends State<TaskTile>{

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top:5,bottom: 5),
      child: ListTile(
        title: Text(widget.title),
        titleTextStyle: TextStyle(
          fontFamily: 'IBMPlexMono',
          color: Theme.of(context).colorScheme.inversePrimary,
          decoration: widget.isCompleted? TextDecoration.lineThrough :TextDecoration.none,
          fontSize: 16,
        ),
        leading: Checkbox(
          value: widget.isCompleted,
          checkColor: Colors.green, 
          shape: CircleBorder(
            side: BorderSide(
              color: Theme.of(context).colorScheme.secondary
            )
          ),
          onChanged: widget.onChanged
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
