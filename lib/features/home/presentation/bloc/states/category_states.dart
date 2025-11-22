import 'package:productivity_app/features/home/domain/model/category_model.dart';

sealed class CategoryStates {}
class CategoryInit extends CategoryStates{}
class CategoryLoading extends CategoryStates{}
class CategoryLoaded extends CategoryStates{
  final List<CategoryModel> categories;
  CategoryLoaded({required this.categories});
}
class CategoryError extends CategoryStates{
  final String message;
  CategoryError({required this.message});
}
