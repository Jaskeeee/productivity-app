import 'package:flutter/material.dart';

class InputTextField extends StatefulWidget {

  final String hintText;
  final TextEditingController controller;
  final bool obscureText;
  final IconData prefixIconData;
  final IconData? suffixIconData;
  final void Function()? toggleVisibility;
  final String? Function(String?)? validator;
  const InputTextField({
    super.key,
    required this.hintText,
    required this.controller,
    required this.obscureText,
    required this.prefixIconData,
    this.validator,
    this.suffixIconData,
    this.toggleVisibility,
  });

  @override
  State<InputTextField> createState() => _InputTextFieldState();
}

class _InputTextFieldState extends State<InputTextField> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: widget.obscureText,
      controller: widget.controller,
      validator: widget.validator,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.fromLTRB(10,20,25,20),
        hintText: widget.hintText,
        prefixIcon: Icon(
          widget.prefixIconData,
          color: Theme.of(context).colorScheme.primary,
          size: 20,
        ),
        suffixIcon:widget.suffixIconData!=null
        ?IconButton(
          onPressed:widget.toggleVisibility, 
          icon:Icon(
            widget.suffixIconData,
            color: Theme.of(context).colorScheme.primary,
            size: 20,
          )
        )
        :null,
        hintStyle: TextStyle(
          color:Theme.of(context).colorScheme.primary
        ),
        enabledBorder: OutlineInputBorder( //enables border
          borderSide: BorderSide( 
            color: Theme.of(context).colorScheme.primary,
            style: BorderStyle.solid,
            width: 2
          ),
          borderRadius: BorderRadius.circular(15)
        ),
        focusedBorder: OutlineInputBorder( // focused border
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide(
            color: Theme.of(context).colorScheme.inversePrimary,
            style: BorderStyle.solid,
            width: 1
          )
        ),
        focusedErrorBorder: OutlineInputBorder( // focused error border
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide(
            color: Theme.of(context).colorScheme.error,
            style: BorderStyle.solid,
            width: 2
          )
        ),
        errorBorder: OutlineInputBorder( // error border
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide(
            color: Theme.of(context).colorScheme.error,
            style: BorderStyle.solid,
            width: 1
          )
        )
      ),
    );
  }
}