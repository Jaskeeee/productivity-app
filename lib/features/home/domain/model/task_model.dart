import 'package:cloud_firestore/cloud_firestore.dart';

class TaskModel {
  final String id;
  final String title;
  final bool isCompleted;
  final String occurrence;
  final DateTime createdAt;
  final DateTime? deadline;
  
  TaskModel({
    required this.id,
    required this.title,
    required this.occurrence,
    required this.createdAt,
    required this.isCompleted,
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

  TaskModel copyWith({String? title,String? occurrence,bool? isCompleted,DateTime? deadline}){
    return TaskModel(
      id: id, 
      title: title ?? this.title, 
      occurrence: occurrence ?? this.occurrence, 
      isCompleted: isCompleted ?? this.isCompleted,
      createdAt: createdAt,
      deadline: deadline?? this.deadline
    );
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