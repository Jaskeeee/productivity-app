import 'package:productivity_app/features/auth/domain/model/app_user.dart';

class ProfileModel extends AppUser{
  final String? photoUrl;
  ProfileModel({
    required super.uid,
    required super.name,
    required super.email,
    required this.photoUrl,
  });
  Map<String,dynamic> toJson(){
    return {
      "uid": uid,
      "name": name,
      "email": email,
      "photoUrl":photoUrl 
    };
  }
  factory ProfileModel.fromJson(Map<String,dynamic>json){
    return ProfileModel(
      uid: json["uid"], 
      name: json["name"], 
      email: json["email"], 
      photoUrl: json["photoUrl"], 
    );
  }
}