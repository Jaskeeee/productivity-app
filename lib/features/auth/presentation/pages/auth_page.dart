import 'package:flutter/material.dart';
import 'package:productivity_app/features/auth/presentation/pages/login_page.dart';
import 'package:productivity_app/features/auth/presentation/pages/register_page.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({
    super.key,
  });

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  bool isLogin = true;
  void toggleLogin(){
    setState(() {
      isLogin = !isLogin;
    });
  }
  @override
  Widget build(BuildContext context) {
    if(isLogin){
      return LoginPage(toggleLogin: toggleLogin);
    }else{
      return RegisterPage(toggleLogin: toggleLogin);
    }
  }
}