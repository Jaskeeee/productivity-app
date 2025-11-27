import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:productivity_app/core/components/loading_animation.dart';
import 'package:productivity_app/core/themes/themes.dart';
import 'package:productivity_app/features/auth/data/firebase_user_repo.dart';
import 'package:productivity_app/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:productivity_app/features/auth/presentation/cubit/auth_states.dart';
import 'package:productivity_app/features/auth/presentation/pages/auth_page.dart';
import 'package:productivity_app/features/home/data/firebase_category_repo.dart';
import 'package:productivity_app/features/home/data/firebase_task_repo.dart';
import 'package:productivity_app/features/home/presentation/bloc/cubit/category_cubit.dart';
import 'package:productivity_app/features/home/presentation/bloc/cubit/task_cubit.dart';
import 'package:productivity_app/features/home/presentation/pages/home_page.dart';

class App extends StatelessWidget {
  final FirebaseUserRepo firebaseUserRepo = FirebaseUserRepo();
  final FirebaseCategoryRepo firebaseCategoryRepo = FirebaseCategoryRepo();
  final FirebaseTaskRepo firebaseTaskRepo = FirebaseTaskRepo();
  App({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers:<BlocProvider> [
        BlocProvider<AuthCubit>(
          create:(context)=>AuthCubit(firebaseUserRepo)..getUser()
        ),
        BlocProvider<CategoryCubit>(
          create:(context)=>CategoryCubit(firebaseCategoryRepo: firebaseCategoryRepo)
        ),
        BlocProvider<TaskCubit>(
          create: (context)=>TaskCubit(firebaseTaskRepo: firebaseTaskRepo)
        )
      ],
      child: MaterialApp(
        theme: darkTheme,
        debugShowCheckedModeBanner: false,
        home: BlocBuilder<AuthCubit, AuthStates>(
          builder: (context, state) {
            if (state is Authenticated) {
              return HomePage(user: state.user);
            } else if (state is Unauthenticated) {
              return AuthPage();
            } else {
              return LoadingAnimation();
            }
          },
        ),
      ),
    );
  }
}
