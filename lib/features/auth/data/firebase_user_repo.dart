
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:productivity_app/core/utils.dart';
import 'package:productivity_app/features/auth/domain/app_user.dart';
import 'package:productivity_app/features/auth/domain/repo/app_user_repo.dart';

class FirebaseUserRepo implements AppUserRepo{
  final _firebaseauth = FirebaseAuth.instance;
  final _firestore = FirebaseFirestore.instance;
  final _googleSignin = GoogleSignIn.instance;
  bool isInit = false;
  
  Future<void> _ensureGoogleInit()async{
    try{
      await _googleSignin.initialize();
      isInit = true;
    }
    catch(e){
      throw Exception("Failed to initialize Google Sign in: $e");
    }
  }
  
  FirebaseUserRepo(){
    _ensureGoogleInit();  
  }
  
  @override
  Future<AppUser?> getuser()async{
    try{
      final User? currUser =  _firebaseauth.currentUser;
      if(currUser!=null){
        return AppUser(
          uid: currUser.uid, 
          name: currUser.displayName!, 
          email: currUser.email!,
        );
      }else{
        return null;
      }

    }catch(e){
      throw Exception("Failed to fetch User!: $e");
    }
  }
  @override
  Future<AppUser?> userLogin(String email, String passwd)async{
    try{
      final UserCredential userCreds = await _firebaseauth.signInWithEmailAndPassword(
        email: email, 
        password: passwd
      );
      final AppUser appUser = AppUser(
        uid: userCreds.user!.uid, 
        name: userCreds.user!.displayName!, 
        email: userCreds.user!.email!
      );
      return appUser;
    }catch(e){
      throw Exception("Failed login user!: $e");
    }
  }
  @override
  Future<AppUser?> userRegister(String name, String email, String passwd)async{
    try{
      final UserCredential userCreds = await _firebaseauth.createUserWithEmailAndPassword(email: email, password: passwd);
      final AppUser newUser = AppUser(
        uid: userCreds.user!.uid, 
        name: name, 
        email: email
      );
      final CollectionReference userCollection = _firestore.collection("users");
      userCollection.doc(newUser.uid).set(newUser.toJson());
      return newUser;
    }catch(e){
      throw Exception("Failed to Register User!: $e");
    }
  }
  @override
  Future<void> logoutUser()async{
    try{
      await _firebaseauth.signOut();
    }
    catch(e){
      throw Exception("Failed to Login User!:$e");
    }
  }

  @override
  Future<AppUser?> googleSignIn()async{
    try{
      if(!isInit){
        await _ensureGoogleInit();
      }
      final GoogleSignInAccount appUser = await _googleSignin.authenticate(
        scopeHint: ['email']
      );
      final authClient = _googleSignin.authorizationClient;
      final authorization = await authClient.authorizationForScopes(['emails']);
      final GoogleSignInAuthentication googleSignInAuthentication = appUser.authentication;
      final CollectionReference userCollection = _firestore.collection("users");
      final credential = GoogleAuthProvider.credential(
        accessToken: authorization?.accessToken,
        idToken: googleSignInAuthentication.idToken
      );
      final UserCredential userCredential = await _firebaseauth.signInWithCredential(credential);
      final AppUser user = AppUser(
        uid: userCredential.user!.uid, 
        name: userCredential.user!.displayName ?? "User", 
        email: userCredential.user!.email!
      );
      userCollection.doc(user.uid).set(user.toJson());
      return user;
    }
    on GoogleSignInException catch(e){
      throw Exception("Google Sign In Exception: ${e.code} ${e.description} ${e.details}");
    }
    catch(e){
      throw Exception("Failed to Sign User in using google: $e");
    }
  }
}