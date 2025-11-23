import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_iconpicker/Serialization/icondata_serialization.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:productivity_app/features/home/presentation/components/category/category_add_body.dart';
import 'package:productivity_app/features/home/presentation/components/category/category_functions.dart';
import 'package:productivity_app/features/auth/domain/model/app_user.dart';
import 'package:productivity_app/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:productivity_app/features/home/domain/model/category_model.dart';
import 'package:productivity_app/features/home/presentation/bloc/cubit/category_cubit.dart';
import 'package:productivity_app/features/home/presentation/bloc/states/category_states.dart';
import 'package:productivity_app/features/home/presentation/components/category/category_section.dart';
import 'package:productivity_app/features/home/presentation/components/category/category_tile.dart';
import 'package:productivity_app/features/home/presentation/pages/task_page.dart';

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
    final CategoryCubit cubit= context.read<CategoryCubit>();
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
            onPressed: () => showModalBottomSheet(
              context: context,
              isScrollControlled: true,
              backgroundColor: Colors.transparent,
              builder: (context) {
                return CategoryAddBody(
                  uid: widget.user!.uid,
                  categoryCubit: cubit,
                  selectColor: Theme.of(context).colorScheme.tertiary,
                );
              },
            ),
            icon: Icon(
              Icons.add,
              color: Theme.of(context).colorScheme.inversePrimary,
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: BlocBuilder<CategoryCubit,CategoryStates>(
          builder: (context,state){
            if(state is CategoryLoaded){
              if(state.categories.isNotEmpty){
                return ListView.builder(
                  itemCount: state.categories.length,
                  itemBuilder: (context,index){
                    final CategoryModel categoryModel = state.categories[index];
                    final IconData iconData = deserializeIcon(categoryModel.icon)!.data;
                    final Color color = Color(categoryModel.color);
                    return CategoryTile(
                      title: categoryModel.title, 
                      value: categoryModel.value, 
                      color: color, 
                      iconData: iconData, 
                      onTap: ()=>Navigator.push(
                        context, 
                        MaterialPageRoute(builder: (context)=>TaskPage(categoryModel: categoryModel))
                      ), 
                      deleteFunction: ()=>cubit.deleteCategory(widget.user!.uid, categoryModel.id)
                    );
                  }
                );
              }else{
                return Text(
                  "No Categories Found!",
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.primary,
                    fontSize: 16
                  ),
                );
              }
            }else if(state is CategoryError){
              return Center(
                child: Text(
                  state.message,
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.primary,
                    fontSize: 18
                  ),
                ),
              );
            }else{
              return Center(
                child: LoadingAnimationWidget.stretchedDots(
                  color: Theme.of(context).colorScheme.inversePrimary, 
                  size: 60
                ),
              );
            }
          }
        )
      ),
    );
  }
}
