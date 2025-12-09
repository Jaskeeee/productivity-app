import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:productivity_app/core/constants/static_data.dart';
import 'package:productivity_app/core/utils.dart';
import 'package:productivity_app/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:productivity_app/features/home/presentation/bloc/states/category_states.dart';
import 'package:productivity_app/features/home/presentation/components/dialog/show_category_sheet.dart';
import 'package:productivity_app/features/home/presentation/components/sections/category/category_functions.dart';
import 'package:productivity_app/features/auth/domain/model/app_user.dart';
import 'package:productivity_app/features/home/presentation/bloc/cubit/category_cubit.dart';
import 'package:productivity_app/features/home/presentation/components/sections/category/cateogries_card_list.dart';
import 'package:productivity_app/features/profile/presentation/pages/profile_page.dart';

class HomePage extends StatefulWidget {
  final AppUser? user;
  const HomePage({super.key, required this.user});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin, RouteAware {
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

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final CategoryCubit cubit = context.read<CategoryCubit>();
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          actions: [
            IconButton(
              onPressed: () => context.read<AuthCubit>().signOut(),
              icon: Icon(
                Icons.logout,
                color: Theme.of(context).colorScheme.inversePrimary,
              ),
            ),
            IconButton(
              onPressed: () => Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => ProfilePage(user: widget.user!),
                ),
              ),
              icon: Icon(
                Icons.account_circle_outlined,
                color: Theme.of(context).colorScheme.inversePrimary,
              ),
            ),
          ],
        ),
        body: SizedBox(
          child: BlocBuilder<CategoryCubit, CategoryStates>(
            builder: (context, state) {
              if (state is CategoryLoaded) {
                return Column(
                  children: [
                    Text(
                      "Categories:",
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      height:400,child: CateogriesCardList(categories:state.categories)),
                  ],
                );
              } else if (state is CategoryError) {
                return Center(child: Text(state.message));
              } else {
                return Center(child: CircularProgressIndicator());
              }
            },
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () => showCategoryBottomSheet(
            widget.user!.uid,
            context,
            cubit,
            null,
            false,
          ),
          child: Icon(
            Icons.add,
            color: Theme.of(context).colorScheme.inversePrimary,
            size: 20,
          ),
        ),
      ),
    );
  }
}
