
import 'package:cloud_firestore/cloud_firestore.dart';

class CategoryModel {
  final String id;
  final String title;
  final String color;
  final Map<String,dynamic> icon;
  final DateTime createdAt;
  final String? note;
  final DateTime? deadline;
  final double completed;


  CategoryModel({
    required this.id,
    required this.title,
    required this.color,
    required this.icon,
    required this.createdAt,
    required this.completed,
    this.note,
    this.deadline,
  });

  Map<String,dynamic> toJson(){
    return{
      "id":id,
      "title":title,
      "color":color,
      "icon":icon,
      "createdAt":Timestamp.fromDate(createdAt),
      "completed":completed,
      if(note!=null) "note":note,
      if(deadline!=null)"deadline": Timestamp.fromDate(deadline!)
    };
  }
  factory CategoryModel.fromJson(Map<String,dynamic> json){
    return CategoryModel(
      id: json["id"], 
      title: json["title"], 
      color: json["color"], 
      icon: json["icon"], 
      createdAt: (json["createdAt"] as Timestamp).toDate(), 
      completed: json["completed"], 
      note: json["note"],
      deadline: json["deadline"]!=null ?(json["deadline"]as Timestamp).toDate():null
    );
  }
}