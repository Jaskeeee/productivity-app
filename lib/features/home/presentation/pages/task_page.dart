import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:implicitly_animated_reorderable_list_2/implicitly_animated_reorderable_list_2.dart';
import 'package:productivity_app/core/ui/widgets/filter_button.dart';
import 'package:productivity_app/core/ui/loading_animation.dart';
import 'package:productivity_app/core/constants/app_data.dart';
import 'package:productivity_app/core/utils.dart';
import 'package:productivity_app/core/utils/math_utils.dart';
import 'package:productivity_app/features/auth/domain/model/app_user.dart';
import 'package:productivity_app/features/home/domain/model/category_model.dart';
import 'package:productivity_app/features/home/domain/model/task_model.dart';
import 'package:productivity_app/features/home/presentation/bloc/cubit/category_cubit.dart';
import 'package:productivity_app/features/home/presentation/bloc/cubit/task_cubit.dart';
import 'package:productivity_app/features/home/presentation/bloc/states/task_states.dart';
import 'package:productivity_app/features/home/presentation/components/sections/tasks/task_add_body.dart';
import 'package:productivity_app/features/home/presentation/components/widgets/tasks/task_separator.dart';
import 'package:productivity_app/features/home/presentation/components/widgets/tasks/task_tile.dart';

class TaskPage extends StatefulWidget {
  final AppUser? user;
  final CategoryModel categoryModel;
  final IconData? categoryIconData;
  const TaskPage({super.key, required this.categoryModel, required this.user,required this.categoryIconData});
  @override
  State<TaskPage> createState() => _TaskPageState();
}

class _TaskPageState extends State<TaskPage> with RouteAware{
  List<TaskModel> localTask = [];
  Set<String> updatedIds = {};
  Set<String> activeFilters = {};
  bool initialized = false;
  int selectedButton = 0;
  

  @override
  void initState() {
    context.read<TaskCubit>().fetchTask(
      widget.user!.uid,
      widget.categoryModel.id,
    );
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    routeObserver.subscribe(this, ModalRoute.of(context)!);
  }

  // The core Idea here is that the tasks updates when only when the user pops the current page
  // to minimize the number of calls made to firebase 
  // and since the Categories need to be updated as their completion precentages depend on the
  // state of the Tasks they need to be updated as well. 

  @override //runs when the current page in the route is popped
  void didPop() {
    context.read<TaskCubit>().updateTask(widget.user!.uid,widget.categoryModel.id, updatedIds, localTask);
    context.read<CategoryCubit>().fetchCategories(widget.user!.uid);
    super.didPop();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Color categoryColor = Color(widget.categoryModel.color);
    // final IconData categoryIcon = deserializeIcon(widget.categoryModel.icon)!;
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
            onPressed: ()=>Navigator.pop(context),
            icon: Icon(Icons.chevron_left_rounded),
          ),
        ],
        title: Row(
          children: [
            Icon(
              widget.categoryIconData,
              color: Theme.of(context).colorScheme.inversePrimary,
              size: 20,
            ),
            Text(
              widget.categoryModel.title, 
              style: TextStyle(
                fontSize: 18
              )
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          SizedBox(
            height: 60,
            child:ImplicitlyAnimatedReorderableList<String>(
              scrollDirection: Axis.horizontal,
              items: filterOptions, 
              settleDuration: Duration(seconds: 2),
              areItemsTheSame: (a,b)=>a==b, 
              itemBuilder: (context,itemAnimation,item,index){
                final String title = filterOptions[index];
                return Reorderable(
                  key: ValueKey(item),
                  child:FilterButton(
                    isSelected:activeFilters.contains(title)?true:false, 
                    label: filterOptions[index], 
                    onTap: ()=>setState(() {
                      if(activeFilters.contains(title)){
                        filterOptions.removeAt(index);
                        filterOptions.add(item);
                        activeFilters.remove(item);
                      }else{
                        filterOptions.removeAt(index);
                        filterOptions.insert(0,item);
                        activeFilters.add(title);
                      }
                    })
                  ) 
                );
              }, 
              onReorderFinished: (item,from,to,newItems){
                setState(() {
                  filterOptions==newItems;
                });
              }
            ) ,
          ),
          BlocBuilder<TaskCubit, TaskStates>(
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
                      final String? precentage = calculatePercentage(localTask.length, index);
                      if(precentage!=null){
                        return Column(
                          children: [
                            TaskSeparator(title: precentage),
                            TaskTile(
                              title: taskModel.title, 
                              isCompleted: taskModel.isCompleted, 
                              onChanged: (value){
                                setState((){
                                  updatedIds.add(taskModel.id);
                                  taskModel.isCompleted = value!;
                                });
                              }
                            ),
                          ],
                        );
                      }
                      else{
                        return TaskTile(
                          title: taskModel.title, 
                          isCompleted: taskModel.isCompleted, 
                          onChanged: (value){
                            setState((){
                              updatedIds.add(taskModel.id);
                              taskModel.isCompleted = value!;
                            });
                          }
                        );
                      }
                      
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
        ],
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
