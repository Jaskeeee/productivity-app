import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:productivity_app/features/profile/domain/model/profile_model.dart';
import 'package:productivity_app/features/profile/domain/repo/profile_repo.dart';

class FirebaseProfileRepo implements ProfileRepo{
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Future<ProfileModel?> fetchUserProfile(String uid)async{
    try{
      final User? userCredential = _auth.currentUser;
      if(userCredential!=null){
        final DocumentSnapshot profile = await _firestore.collection("users").doc(uid).get();
        return ProfileModel(
          uid: profile["uid"],
          email: profile["email"],
          name: profile["name"],
          photoUrl: _auth.currentUser!.photoURL
        );  
      }
      return null;
    }
    catch(e){
      throw Exception("Failed to Fetch Profile: $e");
    }
  }
  
  @override
  Future<void> updateUserProfile(String uid, String? name, String? email)async{
    try{

    }
    catch(e){
      throw Exception("Failed to Update Profile: $e");
    }
  }
}