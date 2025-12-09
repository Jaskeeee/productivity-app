import 'package:flutter/material.dart';

class TextCountUp extends StatefulWidget {
  final Color color;
  final double endValue;
  final double size;
  const TextCountUp({
    super.key,
    required this.endValue,
    required this.size,
    required this.color
  });

  @override
  State<TextCountUp> createState() => _TextCountUpState();
}

class _TextCountUpState extends State<TextCountUp>with TickerProviderStateMixin{
  late AnimationController animationController;
  late Animation<double> animation;

  @override
  void initState() {
    animationController=AnimationController(vsync: this,duration: Duration(seconds: 2));
    animation=Tween<double>(begin:0,end:widget.endValue).animate(animationController)..addListener(()=>setState(() {
    }));
    animationController.forward();
    super.initState();
  }
  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Text(
      "${animation.value.toStringAsFixed(0)}%",
      style: TextStyle(
        color: widget.color,
        fontSize: widget.size,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}