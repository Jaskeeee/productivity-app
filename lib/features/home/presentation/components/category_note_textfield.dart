import 'package:flutter/material.dart';

class CategoryNoteTextfield extends StatefulWidget {
  final TextEditingController controller;
  final String label;
  final String? Function(String?)? validator;
  final IconData prefixIconData;
  final String hintText;
  final Color borderColor;
  final Color labelColor;
  final Color invertedBorderColor;
  const CategoryNoteTextfield({
    super.key,
    required this.controller,
    required this.hintText,
    required this.prefixIconData,
    required this.label,
    required this.borderColor,
    required this.invertedBorderColor,
    required this.labelColor,
    this.validator
  });

  @override
  State<CategoryNoteTextfield> createState() => _CategoryNoteTextfieldState();
}

class _CategoryNoteTextfieldState extends State<CategoryNoteTextfield> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      maxLines: 5,
      controller: widget.controller,
      validator: widget.validator,
      decoration: InputDecoration(
        labelText: widget.label,
        alignLabelWithHint: true,
        labelStyle: TextStyle(
          color: widget.labelColor
        ),
        contentPadding: EdgeInsets.fromLTRB(10,20,25,20),
        hintText: widget.hintText,
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
            color: widget.borderColor,
            style: BorderStyle.solid,
            width: 2
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