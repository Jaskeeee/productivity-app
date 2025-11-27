import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:productivity_app/core/components/loading_animation.dart';
import 'package:productivity_app/features/auth/domain/model/app_user.dart';
import 'package:productivity_app/features/home/domain/model/category_model.dart';
import 'package:productivity_app/features/home/domain/model/task_model.dart';
import 'package:productivity_app/features/home/presentation/bloc/cubit/category_cubit.dart';
import 'package:productivity_app/features/home/presentation/bloc/cubit/task_cubit.dart';
import 'package:productivity_app/features/home/presentation/bloc/states/task_states.dart';
import 'package:productivity_app/features/home/presentation/components/tasks/task_add_body.dart';
import 'package:productivity_app/features/home/presentation/components/tasks/task_tile.dart';

class TaskPage extends StatefulWidget {
  final AppUser? user;
  final CategoryModel categoryModel;
  const TaskPage({super.key, required this.categoryModel, required this.user});
  @override
  State<TaskPage> createState() => _TaskPageState();
}

class _TaskPageState extends State<TaskPage> {
  List<TaskModel> localTask = [];
  Set<String> updatedIds = {};
  bool initialized = false;

  String? calculatePrecentage(int length, int index) {
    final double percentage = length / (index + 1);
    if (index == 0) {
      return "0%";
    } else if (percentage == 0.25) {
      return "25%";
    } else if (percentage == 0.5) {
      return "50%";
    } else if (percentage == 0.75) {
      return "75%";
    } else if (percentage == 1) {
      return "100%";
    }
    return null;
  }

  @override
  void initState() {
    context.read<TaskCubit>().fetchTask(
      widget.user!.uid,
      widget.categoryModel.id,
    );
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Color categoryColor = Color(widget.categoryModel.color);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: categoryColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadiusGeometry.only(
            bottomLeft: Radius.circular(30),
            bottomRight: Radius.circular(30),
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pop(context);
              if (!mounted)
                context.read<CategoryCubit>().fetchCategories(widget.user!.uid);
            },
            icon: Icon(Icons.chevron_left_rounded),
          ),
        ],
        title: Text(widget.categoryModel.title, style: TextStyle(fontSize: 18)),
      ),
      body: BlocBuilder<TaskCubit, TaskStates>(
        builder: (context, state) {
          if (state is TaskLoaded) {
            localTask = state.tasks;
            if (localTask.isEmpty) {
              return Center(child: Text("No Tasks found!"));
            }
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: ListView.builder(
                shrinkWrap:true,
                itemCount: localTask.length,
                itemBuilder:(context,index){
                  final TaskModel taskModel = localTask[index];
                  return TaskTile(
                    title: taskModel.title, 
                    isCompleted: taskModel.isCompleted, 
                    onChanged: (value){
                      setState((){
                        taskModel.isCompleted = value!;
                      });
                      context.read<TaskCubit>().updateTask(widget.user!.uid,widget.categoryModel.id, updatedIds, localTask);
                    }
                  );
                } 
              )
            );
          } else if (state is TaskError) {
            return Center(child: Text(state.message));
          } else {
            return Center(child: LoadingAnimation());
          }
        },
      ),

      floatingActionButton: FloatingActionButton(
        backgroundColor: Theme.of(context).colorScheme.primary,
        onPressed: () => showModalBottomSheet(
          context: context,
          isScrollControlled: true,
          backgroundColor: Colors.transparent,
          builder: (context) {
            return TaskAddBody(
              user: widget.user,
              categoryModel: widget.categoryModel,
            );
          },
        ),
        child: Icon(
          Icons.add,
          color: Theme.of(context).colorScheme.inversePrimary,
          size: 25,
        ),
      ),
    );
  }
}
