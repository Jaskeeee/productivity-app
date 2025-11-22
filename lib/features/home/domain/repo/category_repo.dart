import 'package:productivity_app/features/home/domain/model/category_model.dart';

abstract class CategoryRepo {
  Future<List<CategoryModel>> fetchCategories(String uid);
  Future<void> addCategory(String uid,String title,String color,Map<String,dynamic>icon,DateTime? deadline,String? note);
  Future<void> editCategory(String uid,String id,String? newTitle,String? newcolor,Map<String,dynamic>?newIcon,DateTime? newDeadline,String? newNote);
  Future<void>deleteCategory(String uid,String id);
}