import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:productivity_app/features/home/domain/model/task_model.dart';
import 'package:productivity_app/features/home/domain/repo/task_repo.dart';

class FirebaseTaskRepo implements TaskRepo{
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
  @override
  Stream<List<TaskModel>> fetchTasks(String uid, String categoryId){
    try{
     return _firebaseFirestore
     .collection("users").doc(uid)
     .collection("categories").doc(categoryId)
     .collection("tasks").snapshots().map((snapshots){
      return snapshots.docs.map((doc){
        return TaskModel.fromJson(doc as Map<String,dynamic>);
      }).toList();
     });
    }catch(e){
      throw Exception("Failed to Fetch Categories : $e");
    }
  }
  @override
  Future<void> addTask(String uid, String categoryId, String title, String? occurrence, DateTime? deadline)async{
    try{
     final CollectionReference taskRef = _firebaseFirestore.collection("users").doc(uid).collection("categories").doc(categoryId).collection("tasks");
     final DateTime createdAt = DateTime.now().toUtc();
     final DocumentReference docRef = taskRef.doc();
     final TaskModel taskModel = TaskModel(
      id: docRef.id, 
      title: title, 
      occurrence: occurrence ?? "none", 
      createdAt: createdAt,
      deadline: deadline 
      );
      await taskRef.doc(docRef.id).set(taskModel.toJson());
    }catch(e){
      throw Exception("Failed to add Task : $e");
    }
  }
  @override
  Future<void> editTask(String uid, String categoryId, String taskId, String? newTitle, String? occurrence, DateTime? deadline)async{
    try{
      final CollectionReference taskRef = _firebaseFirestore.collection("users").doc(uid).collection("categories").doc(categoryId).collection("tasks");
      final DocumentSnapshot taskDoc = await taskRef.doc(taskId).get();
      final Map<String,dynamic> taskData = (taskDoc.data()as Map<String,dynamic>);
      final TaskModel taskModel = TaskModel(
        id: taskData["id"], 
        title: taskData["title"], 
        occurrence: occurrence ?? taskData["occurrence"], 
        createdAt: taskData["createdAt"],
        deadline: deadline ?? (taskData["deadline"]!=null ?(taskData["deadline"] as Timestamp).toDate():null)
      );
      await taskRef.doc(taskId).update(taskModel.toJson());

    }catch(e){
      throw Exception("Failed to Edit Task : $e");
    }
  }
  @override
  Future<void> deleteTask(String uid, String categoryId, String taskId)async{
    try{
     final CollectionReference taskRef = _firebaseFirestore.collection("users").doc(uid).collection("categories").doc(categoryId).collection("tasks");
     await taskRef.doc(taskId).delete();

    }catch(e){
      throw Exception("Failed to Delete Task: $e");
    }
  }
} 