import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:productivity_app/core/components/google_sign_in_button.dart';
import 'package:productivity_app/core/components/section_divider.dart';
import 'package:productivity_app/features/auth/presentation/components/auth_buttons.dart';
import 'package:productivity_app/features/auth/presentation/components/input_text_field.dart';
import 'package:productivity_app/features/auth/presentation/cubit/auth_cubit.dart';

class RegisterPage extends StatefulWidget {
  final void Function() toggleLogin;
  const RegisterPage({
    super.key,
    required this.toggleLogin
  });

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController namecontroller = TextEditingController();
  final TextEditingController emailcontroller = TextEditingController();
  final TextEditingController passcontroller = TextEditingController();
  final TextEditingController confpasscontroller = TextEditingController();

  bool isObscure = true;
  bool isConfObscure = true;
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Form(
            key: _formKey,
            autovalidateMode: AutovalidateMode.onUnfocus,
            child: Padding(
              padding: EdgeInsetsGeometry.symmetric(horizontal:25),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 25,),
                  Text(
                    "Register Now",
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.inversePrimary,
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 5,),
                  Text(
                    "Let's get your started right away!",
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.primary,
                      fontSize: 16
                    ),
                  ),
                  SizedBox(height: 30,),
                  InputTextField(
                    hintText: "Name", 
                    controller:namecontroller, 
                    obscureText: false, 
                    prefixIconData: Icons.person_outline_rounded,
                    validator: (String? value){
                      if(value==null || value.isEmpty){
                        return 'Name cannot be empty';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 15,),
                  InputTextField(
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
                  SizedBox(height: 15,),
                  InputTextField(
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
                  SizedBox(height: 15,),
                  InputTextField(
                    hintText: "Confirm Password", 
                    controller: confpasscontroller,
                    obscureText: isConfObscure,
                    prefixIconData: Icons.password_outlined,
                    suffixIconData: isConfObscure 
                    ?Icons.visibility_off_outlined
                    :Icons.visibility_outlined,
                    toggleVisibility: ()=>setState((){
                      isConfObscure= !isConfObscure;
                    }),
                    validator:(String? value){
                      if(value==null || value.isEmpty){
                        return 'Password is required to login';
                      }
                      if(passcontroller.text!=confpasscontroller.text){
                        return "The Passwords don't match";
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 25,),
                  AuthButtons(
                    onPressed: (){
                      if(_formKey.currentState!.validate()){
                        final authCubit = context.read<AuthCubit>();
        
                        final String name = namecontroller.text;
                        final String email = emailcontroller.text;
                        final String passwd = passcontroller.text;
                        
                        authCubit.registerNewUser(name, email, passwd);
                      }
                    }, 
                    text: "Register"
                  ),
                  SizedBox(height:25),
                  SectionDivider(),
                  SizedBox(height: 25),
                  GoogleSignInButton(
                    onPressed: () => context.read<AuthCubit>().googleSignIn(),
                  ),
                  SizedBox(height: 25),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Already a member?",
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.primary,
                          fontSize: 15,
                        ),
                      ),
                      SizedBox(width: 10),
                      GestureDetector(
                        onTap: ()=>widget.toggleLogin(),
                        child: Text(
                          "Sign in instead!",
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.inversePrimary,
                            fontSize: 15,
                            fontWeight: FontWeight.bold
                          ),
                        )
                      )
                    ]
                  )
                ],
              ),
            ),
          )
        ),
      ),
    );
  }
}