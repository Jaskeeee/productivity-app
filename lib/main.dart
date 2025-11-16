import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:productivity_app/core/app.dart';
import 'package:productivity_app/core/firebase/firebase_options.dart';

void main() async {
  Firebase.initializeApp(options:DefaultFirebaseOptions.currentPlatform);
  WidgetsFlutterBinding.ensureInitialized();
  runApp(App());
}
