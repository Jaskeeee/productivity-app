import 'package:flutter/material.dart';
import 'package:productivity_app/core/themes/themes.dart';
import 'package:productivity_app/features/auth/presentation/pages/auth_page.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: darkTheme,
      debugShowCheckedModeBanner: false, 
      home:AuthPage()
    );
  }
}
