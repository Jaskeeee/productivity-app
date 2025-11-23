import 'package:flex_color_picker/flex_color_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconpicker/Models/icon_picker_icon.dart';
import 'package:flutter_iconpicker/Serialization/icondata_serialization.dart';
import 'package:productivity_app/core/components/action_button.dart';
import 'package:productivity_app/core/components/horizontal_date_selector.dart';
import 'package:productivity_app/core/utils.dart';
import 'package:productivity_app/features/auth/presentation/components/input_text_field.dart';
import 'package:productivity_app/features/home/presentation/bloc/cubit/category_cubit.dart';
import 'package:productivity_app/features/home/presentation/components/category/category_functions.dart';
import 'package:productivity_app/features/home/presentation/components/category/category_note_textfield.dart';
import 'package:productivity_app/features/home/presentation/components/category/deadline_selector.dart';
import 'package:productivity_app/features/home/presentation/components/category/selected_color_card.dart';

class CategoryAddBody extends StatefulWidget {
  final String uid;
  Color selectColor;
  final CategoryCubit categoryCubit;
  CategoryAddBody({
    super.key,
    required this.uid,
    required this.categoryCubit,
    required this.selectColor
  });

  @override
  State<CategoryAddBody> createState() => CategoryAddBodyState();
}

class CategoryAddBodyState extends State<CategoryAddBody> {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController noteController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final CategoryFunctions categoryFunctions = CategoryFunctions();
  int colorChange = 0;
  bool deadlineSelected = false;
  DateTime? selectedDeadline;
  IconPickerIcon? selectedIcon;
  //Error Control Variables
  bool hasIconError = false;
  bool hasColorError = false;
  bool hasError = false;

  @override
  void dispose() {
    titleController.dispose();
    noteController.dispose();
    super.dispose();
  }

    Future<void> colorPicker(BuildContext context,void Function(Color? color) onColorChanged) async {
      ColorPicker(
        title: Row(
          children: [
            Icon(
              Icons.color_lens_outlined,
              color: Theme.of(context).colorScheme.primary,
            ),
            Text(
              "Pick a Color",
              style: TextStyle(color: Theme.of(context).colorScheme.primary),
            ),
          ],
        ),
        onColorChanged: onColorChanged,
      ).showPickerDialog(context);
    }

  @override
  Widget build(BuildContext context) {

    final Color invertedBorderColor = colorLuminance(widget.selectColor) > 0.5
      ? Theme.of(context).scaffoldBackgroundColor
      : Theme.of(context).colorScheme.inversePrimary;
    
    final TextStyle headerStyle =  TextStyle(
      color: colorLuminance(widget.selectColor) > 0.4
      ?Theme.of(context).scaffoldBackgroundColor
      :Theme.of(context).colorScheme.inversePrimary,
      fontSize: 24,
      fontWeight: FontWeight.bold,
    ); //header style

    final TextStyle subheaderStyle = TextStyle(
      color: colorLuminance(widget.selectColor) > 0.4
      ?Theme.of(context).scaffoldBackgroundColor
      :Theme.of(context).colorScheme.inversePrimary,
      fontSize: 16,
      fontWeight: FontWeight.w600,
    );//subheader style

    final Color optionalColor = colorLuminance(widget.selectColor) > 0.5
      ? Theme.of(context).colorScheme.primary
      : Colors.grey;

    return Container(  
      decoration: BoxDecoration(
        color: widget.selectColor,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
      ),
      child: Form(
        key: formKey,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Add Category!",
                    style: headerStyle
                  ),
                  SelectedColorCard(
                    hasError: hasColorError,
                    borderColor: categoryFunctions.borderColorSelect(context,widget.selectColor),
                    color: widget.selectColor,
                    onPressed:()=>colorPicker(context, (color){
                      setState(() {
                        widget.selectColor = color!;
                        colorChange += 1;
                      });
                    }),
                  ),
                ],
              ),
              SizedBox(height: 20),
              Text("Category title", style: subheaderStyle),
              SizedBox(height: 15),
              InputTextField(
                invertedBorderColor: invertedBorderColor,
                borderColor: categoryFunctions.borderColorSelect(context,widget.selectColor),
                label: "Title",
                hintText: "Title",
                controller: titleController,
                obscureText: false,
                prefixIconData: Icons.text_fields_sharp,
                validator: (String? value) {
                  if (value == null || value.isEmpty) {
                    return "A Title is required to create a Category.";
                  }
                  return null;
                },
              ),
              SizedBox(height: 15),
              Text("Category Icons", style: subheaderStyle),
              SizedBox(height: 15),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  border: Border.all(
                    color: hasIconError
                    ?Theme.of(context).colorScheme.error
                    :categoryFunctions.borderColorSelect(context,widget.selectColor),
                    style: BorderStyle.solid,
                    width: 2,
                  ),
                ),
                child: ListTile(
                  onTap: ()async{
                    final IconPickerIcon? icon = await categoryFunctions.iconPickerDialog(context);
                    if (icon != null) {
                      setState(() {
                        selectedIcon = icon;
                      });
                    }
                  },
                  leading: Icon(
                    Icons.insert_emoticon_outlined,
                    color: categoryFunctions.borderColorSelect(context,widget.selectColor),
                    size: 24,
                  ),
                  title: Text("Select Icon"),
                  titleTextStyle: TextStyle(color:categoryFunctions.borderColorSelect(context,widget.selectColor), fontSize: 16),
                  trailing: Icon(
                    selectedIcon?.data ?? Icons.question_mark,
                    color: colorLuminance(widget.selectColor) > 0.5
                        ? Theme.of(context).scaffoldBackgroundColor
                        : Theme.of(context).colorScheme.inversePrimary,
                    size: 24,
                  ),
                ),
              ),
              SizedBox(height: 15),
              Row(
                children: [
                  Text("Category Note", style: subheaderStyle),
                  Text(
                    "(Optional)",
                    style: TextStyle(
                      color: optionalColor,
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 15),
              CategoryNoteTextfield(
                labelColor: optionalColor,
                borderColor: categoryFunctions.borderColorSelect(context,widget.selectColor),
                invertedBorderColor: invertedBorderColor,
                label: "(Optional)",
                controller: noteController,
                hintText: "You can add a note for the Category here....",
                prefixIconData: Icons.font_download_outlined,
              ),
              SizedBox(height: 15),
              DeadlineSelector(
                selectedDeadline: selectedDeadline,
                deadlineSelected: deadlineSelected,
                subheaderStyle: subheaderStyle,
                deleteDeadline: () => setState(() {
                  deadlineSelected = false;
                  selectedDeadline = null;
                }),
                optionalColor: optionalColor,
                selectColor: widget.selectColor,
              ),
              SizedBox(height: 15),
              Container(
                padding: EdgeInsets.only(top: 10, bottom: 10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  color: Theme.of(context).scaffoldBackgroundColor,
                ),
                child: ShaderMask(
                  shaderCallback: (Rect bounds) {
                    return const LinearGradient(
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                      stops: [0.0, 0.1, 0.2, 0.8, 0.9, 1.0],
                      colors: [
                        Colors.black,
                        Colors.transparent,
                        Colors.transparent,
                        Colors.transparent,
                        Colors.transparent,
                        Colors.black,
                      ],
                    ).createShader(bounds);
                  },
                  blendMode: BlendMode.dstOut,
                  child: Center(
                    child: HorizontalDateSelector(
                      selectedColor: colorChange == 0
                          ? Theme.of(context).colorScheme.inversePrimary
                          : widget.selectColor,
                      selectedDate: selectedDeadline ?? DateTime.now(),
                      onDateChange: (date) {
                        setState(() {
                          selectedDeadline = date;
                          deadlineSelected = true;
                        });
                      },
                    ),
                  ),
                ),
              ),
              SizedBox(height: 30),
              ActionButton(
                selectColor: widget.selectColor,
                onPressed: () {
                  if (formKey.currentState!.validate()) {
                    setState(() {
                      hasError = false;
                      hasIconError = false;
                      hasColorError = false;
                    });
                    if (selectedIcon == null) {
                      setState(() {
                        hasIconError = true;
                      });
                      hasError = true;
                    }
                    if (colorChange == 0) {
                      setState(() {
                        hasColorError = true;
                      });
                      hasError = true;
                    }
                    if (hasError) return;
                    final Map<String, dynamic> icon = serializeIcon(
                      selectedIcon!,
                    );
                    final String title = titleController.text;
                    final String? note = noteController.text.isEmpty
                        ? null
                        : noteController.text;
                    final int color = widget.selectColor.toARGB32();
                    widget.categoryCubit.addCategory(
                      widget.uid,
                      title,
                      color,
                      icon,
                      selectedDeadline,
                      note,
                    );
                    Navigator.of(context).pop();
                  }
                },
                title: "Save",
                iconData: Icons.save_outlined,
                buttonAlignment: Alignment.center,
              ),
              SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }
}
