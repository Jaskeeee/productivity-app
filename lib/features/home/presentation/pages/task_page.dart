import 'package:flutter/material.dart';
import 'package:productivity_app/features/home/domain/model/category_model.dart';

class TaskPage extends StatefulWidget {
  final CategoryModel categoryModel;
  const TaskPage({
    super.key,
    required this.categoryModel
  });

  @override
  State<TaskPage> createState() => _TaskPageState();
}

class _TaskPageState extends State<TaskPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Task Page"),
      ),
    );
  }
}