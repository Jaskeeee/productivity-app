import 'package:productivity_app/features/auth/domain/model/app_user.dart';

abstract class AppUserRepo {
  //firebase
  Future<AppUser?> getuser();
  Future<AppUser?> userLogin(String email,String passwd);
  Future<AppUser?> userRegister(String name,String email,String passwd);
  Future<void> logoutUser();
  //google
  Future<AppUser?> googleSignIn();
}