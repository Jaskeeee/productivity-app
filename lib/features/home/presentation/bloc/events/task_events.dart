abstract class TaskEvents {}
class LoadTask extends TaskEvents{
  final String uid;
  final String categoryId;
  LoadTask({
    required this.uid,
    required this.categoryId
  });
}
class AddTask extends TaskEvents{
  final String uid;
  final String categoryId;
  final String title;
  final String? occurrence;
  final DateTime? deadline;
  AddTask({
    required this.uid,
    required this.categoryId,
    required this.title,
    required this.occurrence,
    required this.deadline
  });
}
class EditTask extends TaskEvents{
  final String uid;
  final String categoryId;
  final String taskId;
  final String? newTitle;
  final String? occurrence;
  final DateTime? deadline;
  EditTask({
    required this.uid,
    required this.categoryId,
    required this.taskId,
    required this.newTitle,
    required this.deadline,
    required this.occurrence
  });
}
class DeleteTask extends TaskEvents{
  final String uid;
  final String categoryId;
  final String taskId;
  DeleteTask({
    required this.uid,
    required this.taskId,
    required this.categoryId
  });
}