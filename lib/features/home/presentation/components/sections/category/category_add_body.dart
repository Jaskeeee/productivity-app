import 'package:flex_color_picker/flex_color_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconpicker/flutter_iconpicker.dart';
import 'package:productivity_app/core/ui/widgets/action_button.dart';
import 'package:productivity_app/core/ui/section/horizontal_date_selector.dart';
import 'package:productivity_app/core/themes/themes.dart';
import 'package:productivity_app/features/auth/presentation/components/input_text_field.dart';
import 'package:productivity_app/features/home/domain/model/category_model.dart';
import 'package:productivity_app/features/home/presentation/bloc/cubit/category_cubit.dart';
import 'package:productivity_app/features/home/presentation/components/sections/category/category_functions.dart';
import 'package:productivity_app/features/home/presentation/components/widgets/category/category_note_textfield.dart';
import 'package:productivity_app/features/home/presentation/components/widgets/deadline_selector.dart';
import 'package:productivity_app/core/ui/widgets/selected_color_card.dart';

class CategoryAddBody extends StatefulWidget {
  final String uid;
  late Color sheetColor;
  final CategoryCubit categoryCubit;
  final CategoryModel? categoryModel;
  final bool editMode;
  CategoryAddBody({
    super.key,
    required this.uid,
    required this.categoryCubit,
    required this.sheetColor,
    required this.editMode,
    this.categoryModel,
  });

  @override
  State<CategoryAddBody> createState() => CategoryAddBodyState();
}

class CategoryAddBodyState extends State<CategoryAddBody> {
  late TextEditingController titleController = TextEditingController(text:widget.categoryModel?.title ?? "");
  late TextEditingController noteController = TextEditingController(text:widget.categoryModel?.note ?? "");
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final CategoryFunctions categoryFunctions = CategoryFunctions();
  
  late int colorChange = 0;
  late bool hasIconError = false;
  late bool hasColorError = false;
  late bool hasError = false;
  late bool deadlineSelected = widget.categoryModel?.deadline!=null ?true:false;
  late DateTime? selectedDeadline = widget.categoryModel?.deadline;
  IconPickerIcon? selectedIcon;
  //Error Control Variables

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

    final Color invertedBorderColor = handleLuminance(widget.sheetColor); 
    final TextStyle headerStyle =  TextStyle(
      color:handleLuminance(widget.sheetColor),
      fontSize: 24,
      fontWeight: FontWeight.bold,
    ); //header style

    final TextStyle subheaderStyle = TextStyle(
      color:handleLuminance(widget.sheetColor),
      fontSize: 16,
      fontWeight: FontWeight.w600,
    );//subheader style

    final Color optionalColor=handleSuggsetionsColor(widget.sheetColor);
    return Container(  
      decoration: BoxDecoration(
        color: widget.sheetColor,
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
                  Expanded(
                    child: Text(
                      widget.editMode
                      ?widget.categoryModel!.title
                      :"Add Category!",
                      style: headerStyle,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  SelectedColorCard(
                    hasError: hasColorError,
                    borderColor: borderColorSelect(widget.sheetColor),
                    color: widget.sheetColor,
                    onPressed:()=>colorPicker(context, (color){
                      setState(() {
                        widget.sheetColor = color!;
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
                borderColor: borderColorSelect(widget.sheetColor),
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
              Text("Category Icon", style: subheaderStyle),
              SizedBox(height: 15),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  border: Border.all(
                    color: hasIconError
                    ?Theme.of(context).colorScheme.error
                    :borderColorSelect(widget.sheetColor),
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
                    color: borderColorSelect(widget.sheetColor),
                    size: 24,
                  ),
                  title: Text("Select Icon"),
                  titleTextStyle: TextStyle(color:borderColorSelect(widget.sheetColor), fontSize: 16),
                  trailing: Icon(
                    widget.editMode
                    ?(deserializeIcon(widget.categoryModel!.icon)!.data)
                    :(selectedIcon?.data ?? Icons.question_mark),
                    color:handleLuminance(widget.sheetColor),
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
                borderColor: borderColorSelect(widget.sheetColor),
                invertedBorderColor: invertedBorderColor,
                label: "(Optional)",
                controller: noteController,
                hintText: "You can add a note for the Category here....",
                prefixIconData: Icons.font_download_outlined,
              ),
              SizedBox(height: 15),
              DeadlineSelector(
                title: "Category Deadline",
                selectedDeadline: selectedDeadline ?? DateTime.now(), 
                deadlineSelected: deadlineSelected,
                subheaderStyle: subheaderStyle,
                deleteDeadline: () => setState(() {
                  deadlineSelected = false;
                  selectedDeadline = null;
                }),
                optionalColor: optionalColor,
                selectColor: widget.sheetColor,
              ),
              SizedBox(height: 15),
              Container(
                padding: EdgeInsets.only(top: 10, bottom: 10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  color: Theme.of(context).scaffoldBackgroundColor,
                ),
                child: ShaderMask(
                  shaderCallback: (Rect bounds)=>shader.createShader(bounds),
                  blendMode: BlendMode.dstOut,
                  child: Center(
                    child: HorizontalDateSelector(
                      selectedColor: colorChange == 0
                        ? Theme.of(context).colorScheme.inversePrimary
                        : widget.sheetColor,
                      selectedDate: widget.editMode 
                      ?(widget.categoryModel?.deadline??DateTime.now())
                      :(selectedDeadline ?? DateTime.now()),
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
                selectColor: widget.sheetColor,
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
                    final Map<String, dynamic> icon = serializeIcon(selectedIcon!);
                    final String title = titleController.text;
                    final String? note = noteController.text.isEmpty?null: noteController.text;
                    final int color = widget.sheetColor.toARGB32();
                    widget.categoryCubit.addCategory(widget.uid,title,color,icon,selectedDeadline,note,);
                    Navigator.of(context).pop();
                  }
                },
                title:widget.editMode?"Save":"Create",
                iconData:widget.editMode?Icons.save_outlined:Icons.add,
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
