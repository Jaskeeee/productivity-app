import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:productivity_app/core/components/google_sign_in_button.dart';
import 'package:productivity_app/core/components/section_divider.dart';
import 'package:productivity_app/features/auth/presentation/components/attribute_text.dart';
import 'package:productivity_app/features/auth/presentation/components/auth_buttons.dart';
import 'package:productivity_app/features/auth/presentation/components/input_text_field.dart';
import 'package:productivity_app/features/auth/presentation/cubit/auth_cubit.dart';

class LoginPage extends StatefulWidget {
  final void Function() toggleLogin;
  const LoginPage({
    super.key,
    required this.toggleLogin
  });

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController emailcontroller = TextEditingController();
  final TextEditingController passcontroller = TextEditingController();
  bool isObscure = true;

  @override
  void dispose(){
    emailcontroller.dispose();
    passcontroller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Form(
            key: _formKey,
            // autovalidateMode: AutovalidateMode.onUserInteraction,
            child: Padding(
              padding:EdgeInsetsGeometry.symmetric(horizontal: 25),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 50),
                  Text(
                    "Sign Up",
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.inversePrimary,
                      fontSize: 30,
                      fontWeight: FontWeight.bold
                    ),
                  ),
                  SizedBox(height: 5,),
                  Text(
                    "Welcome back! we're so glad you're here",
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.primary,
                      fontSize: 18
                    ),
                  ),
                  SizedBox(height: 30),
                  InputTextField(
                    borderColor: Theme.of(context).colorScheme.primary,
                    invertedBorderColor: Theme.of(context).colorScheme.inversePrimary,
                    label: "Email",
                    hintText: "Email", 
                    controller: emailcontroller,
                    obscureText: false,
                    prefixIconData: Icons.email_outlined,
                    validator: (String? value) {
                      if(value ==null || value.isEmpty){
                        return 'Email is required to login';
                      }
                      if(!value.contains("@")){
                        return 'Please enter a valid email address';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 25),
                  InputTextField(
                    borderColor: Theme.of(context).colorScheme.primary,
                    invertedBorderColor: Theme.of(context).colorScheme.inversePrimary,
                    label: "Password",
                    hintText: "Password", 
                    controller: passcontroller,
                    obscureText: isObscure,
                    prefixIconData: Icons.password_outlined,
                    suffixIconData: isObscure 
                    ?Icons.visibility_off_outlined
                    :Icons.visibility_outlined,
                    toggleVisibility: ()=>setState((){
                      isObscure = !isObscure;
                    }),
                    validator:(String? value){
                      if(value==null || value.isEmpty){
                        return 'Password is required to login';
                      }
                      if(!RegExp(r'[A-Z]').hasMatch(value)){
                        return 'Password must contain at least one Uppercase Letter';
                      }
                      if(!RegExp(r'[0-9]').hasMatch(value)){
                        return 'Password must contain at least one Number';
                      }
                      if(value.length<8){
                        return 'Password must be at least 8 characters';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 10),
                  AttributeText(text: "Forgot Password?", onPress:()=>print("pressed")),
                  SizedBox(height:25,),
                  AuthButtons(
                    onPressed:(){
                      final authCubit = context.read<AuthCubit>();
                      if(_formKey.currentState!.validate()){
                        final String email = emailcontroller.text;
                        final String passwd = passcontroller.text;
                        authCubit.signIn(email, passwd);
                      }
                    },
                    text: "Login",
                  ),
                  SizedBox(height:50),
                  SectionDivider(),
                  SizedBox(height: 25),
                  GoogleSignInButton(
                    onPressed: ()=>context.read<AuthCubit>().googleSignIn(),
                  ),
                  SizedBox(height: 25),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Not a member?",
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.primary,
                          fontSize: 15,
                        ),
                      ),
                      SizedBox(width: 10),
                      GestureDetector(
                        onTap: ()=>widget.toggleLogin(),
                        child: Text(
                          "Register Now!",
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.inversePrimary,
                            fontSize: 15,
                            fontWeight: FontWeight.bold
                          ),
                        )
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}