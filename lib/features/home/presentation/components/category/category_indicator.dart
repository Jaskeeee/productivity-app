import 'package:flutter/material.dart';
import 'package:productivity_app/core/themes/themes.dart';
import 'package:productivity_app/core/utils.dart';

class CategoryIndicator extends StatefulWidget {
  final String uid;
  final void Function() onPressed;
  final Color categoryColor;
  final int completed;
  final int value;
  final IconData categoryIcon;
  const CategoryIndicator({
    super.key,
    required this.value,
    required this.uid,
    required this.onPressed,
    required this.completed,
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
    return Padding(
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
              child: LinearProgressIndicator(
                // value: value.toDouble(),
                minHeight: 10,
                value: animation.value,
                borderRadius: BorderRadius.circular(15),
                backgroundColor: Theme.of(context).colorScheme.primary,
                color: widget.categoryColor,
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
    );
  }
}
