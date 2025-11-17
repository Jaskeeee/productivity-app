import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:productivity_app/features/auth/domain/app_user.dart';
import 'package:productivity_app/features/auth/presentation/cubit/auth_cubit.dart';

class HomePage extends StatefulWidget {
  final AppUser? user;
  const HomePage({
    super.key,
    required this.user
  });

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Home Screen"), 
        centerTitle: true,
        actions: [
          IconButton(
            onPressed:()=>context.read<AuthCubit>().signOut(), 
            icon: Icon(
              Icons.logout,
              size: 20,
              color: Theme.of(context).colorScheme.inversePrimary,
            )
          )
        ],
      ),
      body: Center(child: Text("Home Screen")),
    );
  }
}
