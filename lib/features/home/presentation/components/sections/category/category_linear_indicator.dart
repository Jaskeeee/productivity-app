import 'package:flutter/material.dart';

class CategoryLinearIndicator extends StatefulWidget {
  final double progress;
  final Color color;
  const CategoryLinearIndicator({
    super.key,
    required this.color,
    required this.progress
  });

  @override
  State<CategoryLinearIndicator> createState() => _CategoryLinearIndicatorState();
}

class _CategoryLinearIndicatorState extends State<CategoryLinearIndicator>with TickerProviderStateMixin{
  late AnimationController animationController;
  late Animation<double> animation;
  
  @override
  void initState() {
    animationController=AnimationController(vsync:this,duration: Duration(seconds: 2));
    animation=Tween<double>(begin:0,end:widget.progress).animate(animationController)..addListener(()=>setState(() {
    }));
    animationController.forward();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(5),
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
        borderRadius: BorderRadius.circular(20)      
      ),
      child: LinearProgressIndicator(
        backgroundColor:Theme.of(context).scaffoldBackgroundColor,
        borderRadius: BorderRadius.circular(20),
        value: animation.value,
        color: widget.color,
        trackGap:100,
        minHeight:10,
      ),
    );
  }
}