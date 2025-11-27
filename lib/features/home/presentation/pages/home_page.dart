import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_iconpicker/Models/icon_picker_icon.dart';
import 'package:flutter_iconpicker/Serialization/icondata_serialization.dart';
import 'package:productivity_app/core/components/header_widget.dart';
import 'package:productivity_app/core/components/loading_animation.dart';
import 'package:productivity_app/core/utils.dart';
import 'package:productivity_app/features/home/presentation/components/category/category_add_body.dart';
import 'package:productivity_app/features/home/presentation/components/category/category_functions.dart';
import 'package:productivity_app/features/auth/domain/model/app_user.dart';
import 'package:productivity_app/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:productivity_app/features/home/domain/model/category_model.dart';
import 'package:productivity_app/features/home/presentation/bloc/cubit/category_cubit.dart';
import 'package:productivity_app/features/home/presentation/bloc/states/category_states.dart';
import 'package:productivity_app/features/home/presentation/components/category/category_pie_chart.dart';
import 'package:productivity_app/features/home/presentation/components/category/category_tile.dart';
import 'package:productivity_app/features/home/presentation/pages/task_page.dart';

class HomePage extends StatefulWidget {
  final AppUser? user;
  const HomePage({super.key, required this.user});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  final CategoryFunctions categoryFunc = CategoryFunctions();
  late int currentPage;
  late TabController tabController;

  void changePage(int newPage) {
    setState(() {
      currentPage = newPage;
    });
  }





  @override
  void initState() {
    context.read<CategoryCubit>().fetchCategories(widget.user!.uid);
    currentPage = 0;
    tabController = TabController(length: tabitems.length, vsync: this);
    tabController.animation?.addListener(() {
      final value = tabController.animation!.value.round();
      if (value != currentPage && mounted) {
        changePage(value);
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final CategoryCubit cubit = context.read<CategoryCubit>();
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: ()=>cubit.fetchCategories(widget.user!.uid), 
          icon: Icon(Icons.refresh_outlined,color: Theme.of(context).colorScheme.inversePrimary,size:20,)
        ),
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        title: Text("Home Screen"),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () async => context.read<AuthCubit>().signOut(),
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
      body: RefreshIndicator.adaptive(
        color: Theme.of(context).colorScheme.inversePrimary,
        onRefresh: () => cubit.fetchCategories(widget.user!.uid),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: BlocBuilder<CategoryCubit, CategoryStates>(
              builder: (context, state) {
                if (state is CategoryLoaded) {
                  if (state.categories.isNotEmpty) {
                    return SizedBox(
                      child: Center(
                        child: Column(
                          children: [
                            CategoryPieChart(categories: state.categories),
                            SizedBox(height: 30,),
                            HeaderWidget(
                              title: "Categories", 
                              iconData: Icons.format_list_bulleted_outlined,
                              trailing: Text(
                                state.categories.length.toString(),
                                style: TextStyle(
                                  color: Theme.of(context).colorScheme.primary,
                                  fontSize: 16,
                                ),
                              ),
                            ),
                            SizedBox(height: 10,),
                            SizedBox(
                              child: ListView.builder(
                                shrinkWrap: true,
                                physics: ScrollPhysics(),
                                scrollDirection: Axis.vertical,
                                itemCount: state.categories.length,
                                itemBuilder: (context, index) {
                                  final CategoryModel categoryModel=state.categories[index];
                                  final Color categoryColor=Color(categoryModel.color);
                                  final IconPickerIcon? deserializedIcon=deserializeIcon(categoryModel.icon);
                                  final IconData categoryIcon=deserializedIcon!.data;
                                  final int value=categoryModel.value;
                                  return CategoryTile(
                                    completed: categoryModel.completed, 
                                    title: categoryModel.title, 
                                    value: value, 
                                    color: categoryColor, 
                                    iconData: categoryIcon, 
                                    onTap: ()=>Navigator.push(
                                      context, 
                                      MaterialPageRoute(builder: (context)=>TaskPage(categoryModel: categoryModel, user:widget.user))
                                    ), 
                                    deleteFunction: ()=>cubit.deleteCategory(widget.user!.uid,categoryModel.id)
                                  );
                                },
                              ),
                            ),
                            SizedBox(height: 50),
                          ],
                        ),
                      ),
                    );
                  } else {
                    return Text(
                      "No Categories Found!",
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.primary,
                        fontSize: 16,
                      ),
                    );
                  }
                } else if (state is CategoryError) {
                  return Center(
                    child: Text(
                      state.message,
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.primary,
                        fontSize: 18,
                      ),
                    ),
                  );
                } else {
                  return Center(child: LoadingAnimation());
                }
              },
            ),
          ),
        ),
      ),
    );
  }
}