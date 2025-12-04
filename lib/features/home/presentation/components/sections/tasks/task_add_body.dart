import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:multi_dropdown/multi_dropdown.dart';
import 'package:productivity_app/core/ui/widgets/action_button.dart';
import 'package:productivity_app/core/ui/section/horizontal_date_selector.dart';
import 'package:productivity_app/core/constants/app_data.dart';
import 'package:productivity_app/core/themes/themes.dart';
import 'package:productivity_app/features/auth/domain/model/app_user.dart';
import 'package:productivity_app/features/auth/presentation/components/input_text_field.dart';
import 'package:productivity_app/features/home/domain/model/category_model.dart';
import 'package:productivity_app/features/home/presentation/bloc/cubit/task_cubit.dart';
import 'package:productivity_app/features/home/presentation/components/widgets/deadline_selector.dart';

class TaskAddBody extends StatefulWidget {
  final AppUser? user;
  final CategoryModel categoryModel;
  const TaskAddBody({
    super.key,
    required this.user,
    required this.categoryModel
  });

  @override
  State<TaskAddBody> createState() => _TaskAddBodyState();
}

class _TaskAddBodyState extends State<TaskAddBody> {
  final GlobalKey<FormState> key = GlobalKey<FormState>();
  final TextEditingController titleController = TextEditingController();

  DateTime? selectedDeadline;
  bool deadlineSelected = false;
  @override
  void dispose() {
    titleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Color categoryColor = Color(widget.categoryModel.color);
    final Color invertedBorderColor = handleLuminance(categoryColor);
    final TextStyle headerStyle =  TextStyle(
      fontFamily: Theme.of(context).textTheme.bodyMedium!.fontFamily,
      color:handleLuminance(categoryColor),
      fontSize: 24,
      fontWeight: FontWeight.bold,
    ); //header style

    final TextStyle subheaderStyle = TextStyle(
      color:handleLuminance(categoryColor),
      fontSize: 16,
      fontWeight: FontWeight.w600,
    );//subhead

    final Color optionalColor =handleSuggsetionsColor(categoryColor);

    return Container(
      decoration: BoxDecoration(
        color: categoryColor,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30)
        )
      ),
      child: Form(
        key: key,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 20,),
              Text(
                "Add Task",
                style: headerStyle,
              ),
              SizedBox(height:15),
              Text(
                "Task title",
                style: subheaderStyle,
              ),
              SizedBox(height:15),
              InputTextField(
                hintText: "Title", 
                controller: titleController, 
                obscureText: false, 
                prefixIconData: Icons.text_fields_sharp, 
                label: "Title", 
                borderColor: borderColorSelect(categoryColor),
                invertedBorderColor: invertedBorderColor,
                validator: (value){
                  if(value==null || value.isEmpty){
                    return "A Title is required for a title";
                  }
                  return null;
                },
              ),     
              SizedBox(height:15),
              Text(
                "Task Occurence",
                style:subheaderStyle,
              ),
              SizedBox(height:15),
              MultiDropdown(
                singleSelect: true,
                closeOnBackButton: true,
                fieldDecoration: FieldDecoration(
                  errorBorder: OutlineInputBorder(
                    borderRadius:BorderRadius.circular(15),
                    borderSide: BorderSide(
                      width: 2,
                      style: BorderStyle.solid,
                      color: Theme.of(context).colorScheme.error
                    )                   
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: BorderSide(
                      color: invertedBorderColor,
                      style: BorderStyle.solid,
                      width: 2
                    ),                 
                  )
                ),
                dropdownDecoration: DropdownDecoration(
                  backgroundColor: Theme.of(context).scaffoldBackgroundColor
                ),
                dropdownItemDecoration: DropdownItemDecoration(
                  textColor: Colors.white,
                  selectedBackgroundColor: categoryColor
                ),
                items:List.generate(
                  taskOccurrences.length, (index)=>DropdownItem(
                    label: taskOccurrences[index], 
                    value: taskOccurrences[index],
                  )
                )
              ),
              SizedBox(height:15),
              DeadlineSelector(
                title: "Task Deadline",
                selectedDeadline: selectedDeadline,
                deadlineSelected: deadlineSelected,
                subheaderStyle: subheaderStyle,
                deleteDeadline: () => setState(() {
                  deadlineSelected = false;
                  selectedDeadline = null;
                }),
                optionalColor: optionalColor,
                selectColor: categoryColor,
              ),
              SizedBox(height: 15),
              Container(
                padding: EdgeInsets.only(top: 10,bottom: 10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  color: Theme.of(context).scaffoldBackgroundColor
                ),
                child: ShaderMask(
                  shaderCallback: (Rect bounds)=>shader.createShader(bounds),
                  blendMode: BlendMode.dstOut,
                  child: Center(
                    child: HorizontalDateSelector(
                      selectedColor: categoryColor,
                      selectedDate: selectedDeadline ?? DateTime.now(), 
                      onDateChange: (date){
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
                onPressed: (){
                  if(key.currentState!.validate()){
                    final String title= titleController.text;
                    final TaskCubit cubit = context.read<TaskCubit>();
                    if(title.isNotEmpty){
                      cubit.addTask(widget.user!.uid,widget.categoryModel.id, title,null, null);
                      Navigator.of(context).pop();
                    }
                  }
                },
                title: "Add Task",
                iconData: Icons.post_add_sharp, 
                selectColor: categoryColor, 
                buttonAlignment: Alignment.center
              ),
              SizedBox(height: 30),

            ],
          ),
        )
      ),
    );
  }
}