import 'package:flex_color_picker/flex_color_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_iconpicker/Models/configuration.dart';
import 'package:flutter_iconpicker/flutter_iconpicker.dart';
import 'package:productivity_app/core/components/action_button.dart';
import 'package:productivity_app/core/components/horizontal_date_selector.dart';
import 'package:productivity_app/core/utils.dart';
import 'package:productivity_app/features/auth/presentation/components/input_text_field.dart';
import 'package:productivity_app/features/home/presentation/bloc/cubit/category_cubit.dart';
import 'package:productivity_app/features/home/presentation/components/category_note_textfield.dart';
import 'package:productivity_app/features/home/presentation/components/deadline_selector.dart';
import 'package:productivity_app/features/home/presentation/components/selected_color_card.dart';

class CategoryFunctions {
  Future<IconPickerIcon?> iconPickerDialog(BuildContext context) async {
    return await showIconPicker(
      context,
      configuration: SinglePickerConfiguration(
        iconPickerShape: RoundedRectangleBorder(
          borderRadius: BorderRadiusGeometry.circular(15),
        ),
        backgroundColor: Theme.of(context).colorScheme.secondary,
        iconPackModes: [IconPack.cupertino, IconPack.material],
      ),
    );
  }

  Future<void> colorPicker(
    BuildContext context,
    void Function(Color? color) onColorChanged,
  ) async {
    ColorPicker(onColorChanged: onColorChanged).showPickerDialog(context);
  }

  void addCategory(
    BuildContext context,
    String uid,
    TextEditingController titleController,
    TextEditingController noteController,
    Color? color,
    Map<String, dynamic> icon,
    DateTime? deadline,
  ) {
    final CategoryCubit categoryCubit = context.read<CategoryCubit>();
    final String title = titleController.text;
    final String note = noteController.text;
    if (title.isNotEmpty) {
      if (note.isNotEmpty) {
        categoryCubit.addCategory(
          uid,
          title,
          color.toString(),
          icon,
          deadline,
          note,
        );
      } else {
        categoryCubit.addCategory(
          uid,
          title,
          color.toString(),
          icon,
          null,
          null,
        );
      }
    }
  }

  Color borderColorSelect(BuildContext context, Color color) {
    final double lum = color.computeLuminance();

    if (lum < 0.03) {
      return Theme.of(context).colorScheme.primary;
    } else if (lum > 0.5) {
      return Theme.of(context).scaffoldBackgroundColor;
    } else {
      return Theme.of(context).colorScheme.inversePrimary;
    }
  }

  void showAddCategoryBottomSheet(BuildContext context, String uid) {
    int colorChange = 0;
    bool deadlineSelected = false;
    DateTime? selectedDeadline;
    //category variable
    // DateTime? deadline;
    IconPickerIcon? selectedIcon;

    Color selectColor = Theme.of(context).colorScheme.tertiary;
    final TextEditingController titleController = TextEditingController();
    final TextEditingController noteController = TextEditingController();
    final GlobalKey<FormState> formKey = GlobalKey<FormState>();

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            final TextStyle subheaderStyle = TextStyle(
              color: colorLuminance(selectColor) > 0.5
                  ? Theme.of(context).scaffoldBackgroundColor
                  : Theme.of(context).colorScheme.inversePrimary,
              fontSize: 16,
              fontWeight: FontWeight.w600,
            );
            final Color borderColor = borderColorSelect(context, selectColor);

            final Color invertedBorderColor = colorLuminance(selectColor) > 0.5
                ? Theme.of(context).scaffoldBackgroundColor
                : Theme.of(context).colorScheme.inversePrimary;

            final Color optionalColor = colorLuminance(selectColor) > 0.5
                ? Theme.of(context).colorScheme.primary
                : Colors.grey;
            return Container(
              decoration: BoxDecoration(
                color: selectColor,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                ),
              ),
              child: Form(
                key: formKey,
                autovalidateMode: AutovalidateMode.onUnfocus,
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
                            style: TextStyle(
                              color: colorLuminance(selectColor) > 0.5
                                  ? Theme.of(context).scaffoldBackgroundColor
                                  : Theme.of(
                                      context,
                                    ).colorScheme.inversePrimary,
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SelectedColorCard(
                            borderColor: borderColor,
                            color: selectColor,
                            onPressed: () => colorPicker(context, (color) {
                              setState(() {
                                selectColor = color!;
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
                        borderColor: borderColor,
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
                            color: borderColor,
                            style: BorderStyle.solid,
                            width: 2,
                          ),
                        ),
                        child: ListTile(
                          onTap: () async {
                            final IconPickerIcon? icon = await iconPickerDialog(
                              context,
                            );
                            if (icon != null) {
                              setState(() {
                                selectedIcon = icon;
                              });
                            }
                          },
                          leading: Icon(
                            Icons.insert_emoticon_outlined,
                            color: borderColor,
                            size: 24,
                          ),
                          title: Text("Select Icon"),
                          titleTextStyle: TextStyle(
                            color: borderColor,
                            fontSize: 16,
                          ),
                          trailing: Icon(
                            selectedIcon?.data ?? Icons.question_mark,
                            color: colorLuminance(selectColor) > 0.5
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
                        borderColor: borderColor,
                        invertedBorderColor: invertedBorderColor,
                        label: "(Optional)",
                        controller: noteController,
                        hintText:
                            "You can add a note for the Category here....",
                        prefixIconData: Icons.font_download_outlined,
                      ),
                      SizedBox(height: 15),
                      DeadlineSelector(
                        dateTextColor: colorLuminance(selectColor) > 0.5
                          ? Theme.of(context).scaffoldBackgroundColor
                          : Theme.of(context).colorScheme.inversePrimary,
                        iconColor: colorLuminance(selectColor) > 0.5
                          ? Theme.of(context).scaffoldBackgroundColor
                          : Theme.of(context).colorScheme.inversePrimary,
                        selectedDeadline: selectedDeadline,
                        deadlineSelected: deadlineSelected,
                        subheaderStyle: subheaderStyle,
                        deleteDeadline: () => setState(() {
                          deadlineSelected = false;
                          selectedDeadline = null;
                        }),
                        optionalColor: optionalColor,
                        selectColor: selectColor,
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
                                  : selectColor,
                              selectedDate: selectedDeadline??DateTime.now(),
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
                        color: colorLuminance(selectColor) > 0.5
                            ? Colors.black
                            : Colors.white,
                        itemColor: colorLuminance(selectColor) > 0.5
                            ? Colors.white
                            : Colors.black,
                        onPressed: () {
                          if (formKey.currentState!.validate()) {
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
          },
        );
      },
    );
  }
}
