import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:productivity_app/features/home/presentation/components/category_functions.dart';
import 'package:productivity_app/features/auth/domain/model/app_user.dart';
import 'package:productivity_app/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:productivity_app/features/home/domain/model/category_model.dart';
import 'package:productivity_app/features/home/presentation/bloc/cubit/category_cubit.dart';
import 'package:productivity_app/features/home/presentation/bloc/states/category_states.dart';

class HomePage extends StatefulWidget {
  final AppUser? user;
const HomePage({super.key, required this.user});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final CategoryFunctions categoryFunc = CategoryFunctions();

  @override
  void initState() {
    context.read<CategoryCubit>().fetchCategories(widget.user!.uid);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Color bottomSheetColor = Theme.of(context).colorScheme.secondary;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        title: Text("Home Screen"),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () => context.read<AuthCubit>().signOut(),
            icon: Icon(
              Icons.logout,
              size: 20,
              color: Theme.of(context).colorScheme.inversePrimary,
            ),
          ),
          IconButton(
            onPressed: () => categoryFunc.showAddCategoryBottomSheet(context,widget.user!.uid),
            icon: Icon(
              Icons.add,
              color: Theme.of(context).colorScheme.inversePrimary,
            ),
          ),
        ],
      ),
      body:BlocBuilder<CategoryCubit,CategoryStates>(
        builder: (context,state){
          if(state is CategoryLoaded){
            if(state.categories.isEmpty){
              return Center(
                child: Text(
                  "No Categories Found!",
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.primary,
                    fontSize: 16,
                  )
                ),
              );
            }
            else{
              return ListView.builder(
                itemCount: state.categories.length,
                itemBuilder: (context,index){
                  final CategoryModel categoryModel = state.categories[index];
                  return ListTile(
                    title: Text(
                      categoryModel.title,
                    ),
                  );
                }
              );
            }
          }
          else if(state is CategoryError){
            return Text(
              state.message,
              style: TextStyle(
                color: Theme.of(context).colorScheme.primary,
                fontSize: 16,
              ),
            );
          }
          else{
            return Center(
              child: LoadingAnimationWidget.stretchedDots(
                color: Theme.of(context).colorScheme.inversePrimary, 
                size: 60
              )
            );
          }
        }
      ),
    );
  }
}
