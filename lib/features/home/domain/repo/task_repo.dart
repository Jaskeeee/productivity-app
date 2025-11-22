import 'package:productivity_app/features/home/domain/model/task_model.dart';

abstract class TaskRepo {
  Stream<List<TaskModel>> fetchTasks(String uid,String categoryId);
  Future<void> addTask(String uid,String categoryId,String title,String? occurrence,DateTime? deadline);
  Future<void> editTask(String uid,String categoryId,String taskId,String? newTitle,String? occurrence,DateTime? deadline);
  Future<void>deleteTask(String uid,String categoryId,String taskId);
}