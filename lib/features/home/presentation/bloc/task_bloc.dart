import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:productivity_app/features/home/data/firebase_task_repo.dart';
import 'package:productivity_app/features/home/presentation/bloc/events/task_events.dart';
import 'package:productivity_app/features/home/presentation/bloc/states/task_states.dart';

class TaskBloc extends Bloc<TaskEvents,TaskStates>{
  final FirebaseTaskRepo firebaseTaskRepo;
  TaskBloc({required this.firebaseTaskRepo}):super(TaskInitial()){
    on<LoadTask>((event, emit)async{
      emit.forEach(
        firebaseTaskRepo.fetchTasks(event.uid,event.categoryId), 
        onData:(tasks)=>TaskLoaded(tasks: tasks),
        onError: (error, stackTrace) => TaskError(message:error.toString()),
      );
    });

    on<AddTask>((event, emit)async{
      await firebaseTaskRepo.addTask(
        event.uid, 
        event.categoryId,
        event.title,
        event.occurrence,
        event.deadline
      );
    });
    
    on<EditTask>((event,emit)async{
      await firebaseTaskRepo.editTask(
        event.uid, 
        event.categoryId, 
        event.taskId, 
        event.newTitle, 
        event.occurrence, 
        event.deadline
      );
    });

    on<DeleteTask>((event,emit)async{
      await firebaseTaskRepo.deleteTask(
        event.uid, 
        event.categoryId, 
        event.taskId
      );
    });
  }
}