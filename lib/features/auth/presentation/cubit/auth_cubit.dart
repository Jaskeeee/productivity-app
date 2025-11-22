import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:productivity_app/features/auth/data/firebase_user_repo.dart';
import 'package:productivity_app/features/auth/domain/model/app_user.dart';import 'package:productivity_app/features/auth/presentation/cubit/auth_states.dart';

class AuthCubit extends Cubit<AuthStates>{
  final FirebaseUserRepo firebaseUserRepo;
  AuthCubit(this.firebaseUserRepo):super(AuthInitial());

  Future<void> getUser()async{
    emit(AuthLoading());
    try{
      final AppUser? user = await firebaseUserRepo.getuser();
      if(user!=null){
        emit(Authenticated(user: user));
      }
      else{
        emit(Unauthenticated());
      }
    }catch(e){
      emit(AuthError(message: e.toString()));
      emit(Unauthenticated());
    }
  }
  Future<void> signIn(String email,String passwd)async{
    emit(AuthLoading());
    try{
      final AppUser? user = await firebaseUserRepo.userLogin(email, passwd);
      if(user!=null){
        emit(Authenticated(user: user));     
      }else{
        emit(Unauthenticated());
      }
    }
    catch(e){
      emit(AuthError(message:e.toString()));
      emit(Unauthenticated());
    }
  }

  Future<void> registerNewUser(String name, String email,String passwd)async{
    emit(AuthLoading());
    try{
      final AppUser? user = await firebaseUserRepo.userRegister(name, email, passwd);
      if(user!=null){
        emit(Authenticated(user: user));
      } 
      else{
        emit(Unauthenticated());
      }
    }
    catch(e){
      emit(AuthError(message: e.toString()));
      emit(Unauthenticated());
    }
  }
  
  Future<void> signOut()async{
    emit(AuthLoading());
    try{
      await firebaseUserRepo.logoutUser();
      emit(Unauthenticated());
    }catch(e){
      emit(AuthError(message: e.toString()));
      emit(Unauthenticated());
    }
  }
  
  Future<void> googleSignIn()async{
    emit(AuthLoading());
    try{
      final AppUser? user = await firebaseUserRepo.googleSignIn();
      if(user!=null){
        emit(Authenticated(user: user));
      }else{
        emit(Unauthenticated());
      }
    }catch(e){
      emit(AuthError(message:e.toString()));
      emit(Unauthenticated());
    }
  }
}