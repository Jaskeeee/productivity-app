import 'package:flutter/material.dart';

class InputTextField extends StatefulWidget {

  final String hintText;
  final TextEditingController controller;
  final bool obscureText;
  final IconData prefixIconData;
  final IconData? suffixIconData;
  final String label;
  final Color borderColor;
  final Color invertedBorderColor;
  final void Function()? toggleVisibility;
  final String? Function(String?)? validator;
  const InputTextField({
    super.key,
    required this.hintText,
    required this.controller,
    required this.obscureText,
    required this.prefixIconData,
    required this.label,
    required this.borderColor,
    required this.invertedBorderColor,
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
      style: TextStyle(
        color: widget.borderColor
      ),
      decoration: InputDecoration(
        labelText: widget.label,
        labelStyle: TextStyle(
          color: widget.borderColor,
        ),
        contentPadding: EdgeInsets.fromLTRB(10,20,25,20),
        hintText: widget.hintText,
        prefixIcon: Icon(
          widget.prefixIconData,
          color: widget.borderColor,
          size: 20,
        ),
        suffixIcon:widget.suffixIconData!=null
        ?IconButton(
          onPressed:widget.toggleVisibility, 
          icon:Icon(
            widget.suffixIconData,
            color: widget.borderColor,
            size: 20,
          )
        )
        :null,
        hintStyle: TextStyle(
          color:widget.borderColor
        ),
        enabledBorder: OutlineInputBorder( //enables border
          borderSide: BorderSide( 
            color: widget.borderColor,
            style: BorderStyle.solid,
            width: 2
          ),
          borderRadius: BorderRadius.circular(15)
        ),
        focusedBorder: OutlineInputBorder( // focused border
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide(
            color: widget.invertedBorderColor,
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