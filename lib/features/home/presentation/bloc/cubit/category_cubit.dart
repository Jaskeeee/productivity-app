import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:productivity_app/features/home/data/firebase_category_repo.dart';
import 'package:productivity_app/features/home/domain/model/category_model.dart';
import 'package:productivity_app/features/home/presentation/bloc/states/category_states.dart';

class CategoryCubit extends Cubit<CategoryStates>{
  final FirebaseCategoryRepo firebaseCategoryRepo;
  CategoryCubit({required this.firebaseCategoryRepo}):super(CategoryInit());

  Future<void> fetchCategories(String uid)async{
    try{
      final List<CategoryModel> categories = await firebaseCategoryRepo.fetchCategories(uid);
      emit(CategoryLoaded(categories: categories));
    }
    catch(e){
      emit(CategoryError(message: e.toString()));
    }
  }
  Future<void> addCategory(String uid,String title,int color,Map<String,dynamic>icon,DateTime? deadline,String? note)async{
    try{
      await firebaseCategoryRepo.addCategory(uid, title, color, icon, deadline,note);
      fetchCategories(uid);
    }
    catch(e){
      emit(CategoryError(message: e.toString()));
    }
  }
  Future<void> deleteCategory(String uid,String id)async{
    try{
      await firebaseCategoryRepo.deleteCategory(uid, id);
      fetchCategories(uid);
    }
    catch(e){
      emit(CategoryError(message: e.toString()));
    }
  }
  Future<void> editCategory(String uid,String id,String? newTitle,int? newcolor,Map<String,dynamic>?newIcon,DateTime? newDeadline,String? newNote)async{
    try{
      await firebaseCategoryRepo.editCategory(uid, id, newTitle, newcolor, newIcon, newDeadline,newNote);
      fetchCategories(uid);
    }
    catch(e){
      emit(CategoryError(message: e.toString()));
    }
  }
}