import 'package:productivity_app/features/home/domain/model/task_model.dart';

sealed class TaskStates {}
class TaskInitial extends TaskStates{}
class TaskLoaded extends TaskStates{
  final Stream<List<TaskModel>> tasks;
  TaskLoaded({required this.tasks});
}
class TaskError extends TaskStates{
  final String message;
  TaskError({required this.message});
}