import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:productivity_app/core/ui/loading_animation.dart';
import 'package:productivity_app/core/ui/widgets/profile_avatar.dart';
import 'package:productivity_app/features/auth/domain/model/app_user.dart';
import 'package:productivity_app/features/profile/presentation/components/profile_info_tile.dart';
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
                    decoration:BoxDecoration(
                      color: Theme.of(context).colorScheme.secondary,
                      borderRadius: BorderRadius.circular(15)
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ProfileAvatar(photoUrl: state.profile!.photoUrl),
                        SizedBox(width:25,),
                        Expanded(
                          child: SizedBox(
                            child: Text(
                              "${state.profile!.name}!",
                              textAlign: TextAlign.start,
                              style: TextStyle(
                                color: Theme.of(context).colorScheme.inversePrimary,
                                fontSize: 20,
                                fontWeight: FontWeight.w600
                              ),
                            ),
                          ),
                        )
                      ],
                    )
                  ),
                  SizedBox(height: 20),
                  Container(
                    padding: EdgeInsets.fromLTRB(25, 10, 25, 10),
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.secondary,
                      borderRadius: BorderRadius.circular(15)
                    ),
                    child: Column(
                      children: [
                        ProfileInfoTile(title:"Name", value:state.profile!.name),
                        ProfileInfoTile(title:"Email", value:state.profile!.email),
                      ],
                    ),
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