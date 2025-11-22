import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
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
  final GlobalKey<ScaffoldMessengerState> rootMessengerKey = GlobalKey<ScaffoldMessengerState>();
  final FirebaseUserRepo firebaseUserRepo = FirebaseUserRepo();
  final FirebaseCategoryRepo firebaseCategoryRepo = FirebaseCategoryRepo();
  final FirebaseTaskRepo firebaseTaskRepo = FirebaseTaskRepo();
  App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: darkTheme,
      debugShowCheckedModeBanner: false,
      home: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => AuthCubit(firebaseUserRepo)..getUser(),
          ),
          BlocProvider(
            create: (context) => CategoryCubit(firebaseCategoryRepo: firebaseCategoryRepo)
          ),
          BlocProvider(
            create: (context) => TaskCubit(firebaseTaskRepo: firebaseTaskRepo)
          )
        ],
        child: BlocConsumer<AuthCubit, AuthStates>(
          builder: (context, state) {
            if (state is Authenticated) {
              return HomePage(user: state.user);
            } else if (state is Unauthenticated) {
              return AuthPage();
            } else {
              return Center(
                child: LoadingAnimationWidget.inkDrop(
                  color: Theme.of(context).colorScheme.inversePrimary,
                  size: 25,
                ),
              );
            }
          },
          listener: (context, state) {
            if (state is AuthError) {
              print(state.message);
              WidgetsBinding.instance.addPostFrameCallback((_){
                rootMessengerKey.currentState?.showMaterialBanner(
                MaterialBanner(
                  backgroundColor: Theme.of(context).colorScheme.error,
                  dividerColor: Theme.of(context).colorScheme.error,
                  content: Text(
                    state.message,
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.inversePrimary,
                      fontSize: 16,
                    ),
                  ),
                  actions: [
                    IconButton(
                      onPressed: () => rootMessengerKey.currentState?.hideCurrentMaterialBanner(),
                      icon: Icon(
                        Icons.close,
                        color: Theme.of(context).colorScheme.inversePrimary,
                        size: 20,
                      ),
                    ),
                  ],
                ),
              );
              });
            }
          },
        ),
      ),
    );
  }
}
