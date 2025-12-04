import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:productivity_app/features/profile/data/firebase_profile_repo.dart';
import 'package:productivity_app/features/profile/domain/model/profile_model.dart';
import 'package:productivity_app/features/profile/presentation/cubit/profile_states.dart';

class ProfileCubit extends Cubit<ProfileStates>{
  final FirebaseProfileRepo firebaseProfileRepo;
  ProfileCubit({required this.firebaseProfileRepo}):super(ProfileInitial());

  Future<void> fetchProfile(String uid)async{
    emit(ProfileLoading());
    try{
      final ProfileModel? profileModel = await firebaseProfileRepo.fetchUserProfile(uid);
      emit(ProfileLoaded(profile: profileModel));
    }
    catch(e){
      emit(ProfileError(message: e.toString()));
    }
  }
}