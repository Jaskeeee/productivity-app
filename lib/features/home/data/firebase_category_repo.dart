import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:productivity_app/features/home/domain/model/category_model.dart';
import 'package:productivity_app/features/home/domain/repo/category_repo.dart';

class FirebaseCategoryRepo implements CategoryRepo{
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
  @override
  Future<List<CategoryModel>> fetchCategories(String uid)async{
    try{
      final CollectionReference categoryRef = _firebaseFirestore.collection("users").doc(uid).collection("categories");
      final QuerySnapshot categorydocSnap = await categoryRef.get();
      final List<CategoryModel> categories =  categorydocSnap.docs.map((doc){
        return CategoryModel.fromJson(doc.data() as Map<String,dynamic>);
      }).toList();
      return categories;
    }
    catch(e){
      throw Exception("Failed to fetch Categories: $e");
    }
  }
  @override
  Future<void> addCategory(String uid, String title, String color, Map<String, dynamic> icon, DateTime? deadline)async{
    try{
      final CollectionReference categoryRef = _firebaseFirestore.collection("users").doc(uid).collection("categories");
      final DocumentReference docRef = categoryRef.doc();
      final DateTime createdAt = DateTime.now().toUtc();
      final CategoryModel categoryModel = CategoryModel(
        id: docRef.id, 
        title: title, 
        color: color, 
        icon: icon, 
        createdAt: createdAt, 
        completed: 0,
        deadline: deadline 
      );
      await categoryRef.doc(docRef.id).set(categoryModel.toJson());
    }
    catch(e){
      throw Exception("Failed to add new Category $e");
    }
  }
  @override
  Future<void> deleteCategory(String uid,String id)async{
    try{
      final CollectionReference categoryRef = _firebaseFirestore.collection("users").doc(uid).collection("categories");
      await categoryRef.doc(id).delete();
    }
    catch(e){
      throw Exception("Failed to delete the Category: $e");
    }
  }
  @override
  Future<void> editCategory(String uid,String id, String? newTitle, String? newcolor, Map<String, dynamic>? newIcon, DateTime? newDeadline)async{
    try{
      final CollectionReference categoryRef = _firebaseFirestore.collection("users").doc(uid).collection("categories");
      final DocumentSnapshot selectedCategory = await categoryRef.doc(id).get();
      final Map<String,dynamic> categoryData = (selectedCategory.data()as Map<String,dynamic>);
      final CategoryModel editedCategoryModel = CategoryModel(
        id: id, 
        title: newTitle??categoryData["title"], 
        color: newcolor??categoryData["color"], 
        icon: newIcon??categoryData["icon"], 
        createdAt: (categoryData["createdAt"]as Timestamp).toDate(),
        completed: categoryData["completed"],
        deadline: newDeadline ?? (categoryData["deadline"]!=null ?(categoryData["deadline"]as Timestamp).toDate():null)
      );
      await categoryRef.doc(id).update(editedCategoryModel.toJson());
    }
    catch(e){
      throw Exception("Failed to Edit Category: $e");
    }
  }
}
