import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_iconpicker/Models/icon_picker_icon.dart';
import 'package:flutter_iconpicker/Serialization/icondata_serialization.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:productivity_app/core/constants/static_data.dart';
import 'package:productivity_app/core/ui/section/header_widget.dart';
import 'package:productivity_app/core/ui/loading_animation.dart';
import 'package:productivity_app/core/utils.dart';
import 'package:productivity_app/core/utils/math_utils.dart';
import 'package:productivity_app/features/home/presentation/components/dialog/show_category_sheet.dart';
import 'package:productivity_app/features/home/presentation/components/sections/category/category_add_body.dart';
import 'package:productivity_app/features/home/presentation/components/sections/category/category_functions.dart';
import 'package:productivity_app/features/auth/domain/model/app_user.dart';
import 'package:productivity_app/features/home/domain/model/category_model.dart';
import 'package:productivity_app/features/home/presentation/bloc/cubit/category_cubit.dart';
import 'package:productivity_app/features/home/presentation/bloc/states/category_states.dart';
import 'package:productivity_app/features/home/presentation/components/widgets/category/category_pie_chart.dart';
import 'package:productivity_app/features/home/presentation/components/widgets/category/category_tile.dart';
import 'package:productivity_app/features/home/presentation/pages/task_page.dart';
import 'package:productivity_app/features/profile/presentation/pages/profile_page.dart';

class HomePage extends StatefulWidget {
  final AppUser? user;
  const HomePage({super.key, required this.user});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with SingleTickerProviderStateMixin,RouteAware{
  final CategoryFunctions categoryFunc = CategoryFunctions();
  late int currentPage;
  late TabController tabController;

  @override
  void didChangeDependencies() {
    routeObserver.subscribe(this, ModalRoute.of(context)!);
    super.didChangeDependencies();
  }


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

  void doSomething(BuildContext context)=>print("help I am being touched");

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
          onPressed: ()=>Navigator.push(
            context, 
            MaterialPageRoute(builder: (context)=>ProfilePage(user: widget.user,))
          ), 
          icon: Icon(
            Icons.account_circle_outlined,
            color: Theme.of(context).colorScheme.inversePrimary,
          )
        ),
      ),
      body: RefreshIndicator.adaptive(
        color: Theme.of(context).colorScheme.inversePrimary,
        onRefresh: () => cubit.fetchCategories(widget.user!.uid),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal:25),
            child: Center(
              child: BlocBuilder<CategoryCubit, CategoryStates>(
                builder: (context, state) {
                  if (state is CategoryLoaded) {
                    if (state.categories.isNotEmpty) {
                      return SizedBox(
                        child: Center(
                          child: Column(
                            children: [
                              CategoryPieChart(user:widget.user,categories: state.categories),
                              SizedBox(height: 30,),
                              HeaderWidget(
                                title: "Categories", 
                                iconData: Icons.format_list_bulleted_outlined,
                                trailing: Text(
                                  state.categories.length.toString(),
                                  style: TextStyle(
                                    color: Theme.of(context).colorScheme.primary,
                                    fontSize: 14,
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
                                    final double categoryCompletion = completionValue(
                                      categoryModel.value.toDouble(),
                                      categoryModel.completed.toDouble(),
                                    );
                                    return Slidable(
                                      startActionPane:ActionPane(
                                        motion: StretchMotion(), 
                                        children:[
                                          SlidableAction(
                                            onPressed:doSomething,
                                            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                                            foregroundColor: Theme.of(context).colorScheme.inversePrimary,
                                            icon: Icons.edit_outlined,
                                          ),
                                        ]
                                      ),
                                      child: CategoryTile(
                                        title: categoryModel.title, 
                                        color: categoryColor, 
                                        iconData: categoryIcon, 
                                        completion: categoryCompletion, 
                                        onTap: ()=>Navigator.push(
                                          context, 
                                          MaterialPageRoute(builder: (context)=>TaskPage(categoryModel: categoryModel, user: widget.user, categoryIconData: categoryIcon))
                                        ), 
                                        deleteFunction: ()=>print("lmao bro pressed it")
                                      ),
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
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: ()=>showCategoryBottomSheet(widget.user!.uid, context,cubit,Theme.of(context).colorScheme.tertiary,null),
        child: Icon(
          Icons.add,
          color: Theme.of(context).colorScheme.inversePrimary,
          size: 20,
        ),
      ),
    );
  }
}