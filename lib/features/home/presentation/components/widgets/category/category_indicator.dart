import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:productivity_app/core/themes/themes.dart';
import 'package:productivity_app/core/utils/math_utils.dart';

class CategoryIndicator extends StatefulWidget {
  final String uid;
  final String title;
  final void Function() onPressed;
  final Color categoryColor;
  final int completed;
  final int value;
  final IconData categoryIcon;
  final void Function() deleteFunction;
  const CategoryIndicator({
    super.key,
    required this.value,
    required this.title,
    required this.uid,
    required this.onPressed,
    required this.completed,
    required this.deleteFunction,
    required this.categoryIcon,
    required this.categoryColor,
  });

  @override
  State<CategoryIndicator> createState() => _CategoryIndicatorState();
}

class _CategoryIndicatorState extends State<CategoryIndicator> with TickerProviderStateMixin{
  late AnimationController animationController;
  late Animation<double> animation;
  
  @override
  void initState() {
    super.initState();
    animationController = AnimationController(
      vsync: this,
      duration: Duration(seconds:2)
    );
    animation = Tween<double>(begin:0.0,end: completionValue(widget.value.toDouble(),widget.completed.toDouble())).animate(animationController)..addListener(()=>setState((){}));
    animationController.forward();
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Color color = handleLuminance(widget.categoryColor); //header style
    return Slidable(
      endActionPane: ActionPane(
        motion: ScrollMotion(), 
        children: [
          SlidableAction(
            autoClose: true,
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            foregroundColor: Theme.of(context).colorScheme.inversePrimary,
            alignment: Alignment.center,
            onPressed:(context) => widget.deleteFunction,
            icon: Icons.delete_outline,

          )
        ]
      ),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(15, 10, 15, 10),
        child: InkWell(
          onTap: widget.onPressed,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: EdgeInsets.all(5),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: widget.categoryColor,
                ),
                child: Icon(widget.categoryIcon, color: color, size: 30),
              ),
              SizedBox(width: 20),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: 160,
                      child: Text(
                        widget.title,
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.inversePrimary,
                          fontWeight: FontWeight.w700,
                          overflow: TextOverflow.ellipsis
                        ),
                      ),
                    ),
                    SizedBox(height:15,),
                    LinearProgressIndicator(
                      // value: value.toDouble(),
                      minHeight: 10,
                      value: animation.value,
                      borderRadius: BorderRadius.circular(15),
                      backgroundColor: Theme.of(context).colorScheme.primary,
                      color: widget.categoryColor,
                    ),
                  ],
                ),
              ),
              SizedBox(width: 30),
              SizedBox(
                width: 90,
                child: Text(
                  "${(animation.value*100).toStringAsFixed(2)} %",
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.inversePrimary,
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
