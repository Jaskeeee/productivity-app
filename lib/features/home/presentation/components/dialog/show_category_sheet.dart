import 'package:flutter/material.dart';
import 'package:productivity_app/features/home/domain/model/category_model.dart';
import 'package:productivity_app/features/home/presentation/bloc/cubit/category_cubit.dart';
import 'package:productivity_app/features/home/presentation/components/sections/category/category_add_body.dart';

Future<void> showCategoryBottomSheet(String uid,BuildContext context,CategoryCubit categoryCubit,CategoryModel? categoryModel,bool editMode)async{
  final Color sheetColor =categoryModel!=null 
  ?Color(categoryModel.color)
  :Theme.of(context).colorScheme.tertiary;
  showModalBottomSheet(
    backgroundColor: Colors.transparent,
    isScrollControlled: true,
    context: context, 
    builder: (context)=>CategoryAddBody(uid: uid, categoryCubit: categoryCubit, sheetColor:sheetColor,editMode:editMode,categoryModel: categoryModel,)
  );
}
