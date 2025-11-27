import 'package:cloud_firestore/cloud_firestore.dart';

class TaskModel {
  final String id;
  final String title;
  bool isCompleted;
  final String occurrence;
  final DateTime createdAt;
  final DateTime? deadline;
  
  TaskModel({
    required this.id,
    required this.title,
    required this.occurrence,
    required this.createdAt,
    this.isCompleted=false,
    this.deadline
  });

  Map<String,dynamic> toJson(){
    return{
      "id":id,
      "title":title,
      "isCompleted":isCompleted,
      "occurrence": occurrence,
      "createdAt":createdAt,
      if(deadline!=null)"deadline":Timestamp.fromDate(deadline!)
    };
  }
  factory TaskModel.fromJson(Map<String,dynamic> json){
    return TaskModel(
      id: json["id"], 
      title: json["title"], 
      isCompleted: json["isCompleted"], 
      occurrence: json["occurrence"], 
      createdAt: (json["createdAt"] as Timestamp).toDate(),
      deadline:json["deadline"]!=null ?(json["deadline"]as Timestamp).toDate() :null
    );     
  }
}