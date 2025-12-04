import 'package:productivity_app/features/profile/domain/model/profile_model.dart';

abstract class ProfileRepo {
  Future<ProfileModel?> fetchUserProfile(String uid);
  Future<void> updateUserProfile(String uid,String? name,String? email);
}