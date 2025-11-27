import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:productivity_app/features/home/data/firebase_task_repo.dart';
import 'package:productivity_app/features/home/domain/model/task_model.dart';
import 'package:productivity_app/features/home/presentation/bloc/states/task_states.dart';

class TaskCubit extends Cubit<TaskStates>{
  final FirebaseTaskRepo firebaseTaskRepo;
  TaskCubit({required this.firebaseTaskRepo}):super(TaskInitial());

  Future<void>fetchTask(String uid,String categoryId)async{
    emit(TaskInitial());
    try{
      final Stream<List<TaskModel>> stream = firebaseTaskRepo.fetchTasks(uid, categoryId);
      stream.first.then((tasks)=>emit(TaskLoaded(tasks: tasks)));
    }
    catch(e){
      emit(TaskError(message:e.toString()));
    }
  }
  Future<void>addTask(String uid,String categoryId,String title,String? occurrence,DateTime? deadline)async{
    try{
      await firebaseTaskRepo.addTask(uid, categoryId, title, occurrence, deadline);
      fetchTask(uid, categoryId);
    }
    catch(e){
      emit(TaskError(message: e.toString()));
    }
  }
  Future<void>editTask(String uid,String categoryId,String taskId,String? newTitle,String? occurrence,DateTime? deadline)async{
    try{
      await firebaseTaskRepo.editTask(uid, categoryId, taskId, newTitle, occurrence, deadline);
      fetchTask(uid, categoryId);
    }
    catch(e){
      emit(TaskError(message:e.toString()));
    }
  }
  Future<void>deleteTask(String uid,String categoryId,String taskId)async{
    try{
      await firebaseTaskRepo.deleteTask(uid, categoryId, taskId);
      fetchTask(uid, categoryId);
    }
    catch(e){
      emit(TaskError(message: e.toString()));
    }
  }
  Future<void> updateTask(String uid,String categoryId,Set<String> updatedIds,List<TaskModel> localTask)async{
    try{
      await firebaseTaskRepo.updateTasks(uid, categoryId, updatedIds, localTask);
      fetchTask(uid, categoryId);
    }
    catch(e){
      emit(TaskError(message: e.toString()));
    }
  }
}