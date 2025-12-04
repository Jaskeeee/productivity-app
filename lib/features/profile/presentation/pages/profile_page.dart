import 'package:dotted_decoration/dotted_decoration.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:productivity_app/core/ui/loading_animation.dart';
import 'package:productivity_app/core/ui/widgets/profile_avatar.dart';
import 'package:productivity_app/features/auth/domain/model/app_user.dart';
import 'package:productivity_app/features/profile/presentation/cubit/profile_cubit.dart';
import 'package:productivity_app/features/profile/presentation/cubit/profile_states.dart';

class ProfilePage extends StatefulWidget {
  final AppUser? user;
  const ProfilePage({
    super.key,
    required this.user,
  });

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  void initState() {
    context.read<ProfileCubit>().fetchProfile(widget.user!.uid);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Profile Page"),
      ),
      body: BlocBuilder<ProfileCubit,ProfileStates>(
        builder: (context,state){
          if(state is ProfileLoaded){
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    padding: EdgeInsets.all(10),
                    decoration: DottedDecoration(
                      shape: Shape.box,
                      borderRadius: BorderRadius.circular(15)
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ProfileAvatar(photoUrl: state.profile!.photoUrl),
                        SizedBox(
                          width: 200,
                          child: Text(
                            "Hello ${state.profile!.name}!",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Theme.of(context).colorScheme.inversePrimary,
                              fontSize: 20,
                              fontWeight: FontWeight.w600
                            ),
                          ),
                        )
                      ],
                    )
                  )
                ],
              ),
            );
          }else if(state is ProfileError){
            return Center(
              child: Text(
                state.message,
                style: TextStyle(
                  color: Theme.of(context).colorScheme.primary,
                  fontSize: 16
                ),
              ),
            );
          }
          else{
            return Center(child: LoadingAnimation());
          }
        }
      ),
    );
  }
}