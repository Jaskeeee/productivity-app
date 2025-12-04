import 'package:flutter/material.dart';
import 'package:productivity_app/core/themes/themes.dart';

class CategoryTile extends StatefulWidget {
  final String title;
  final Color color;
  final double completion;
  final IconData iconData;
  final void Function() onTap;
  final void Function() deleteFunction;
  const CategoryTile({
    super.key,
    required this.title,
    required this.color,
    required this.iconData,
    required this.completion,
    required this.onTap,
    required this.deleteFunction,
  });

  @override
  State<CategoryTile> createState() => _CategoryTileState();
}

class _CategoryTileState extends State<CategoryTile> with TickerProviderStateMixin {
  late AnimationController animationController;
  late Animation<double> animation;


  @override
  void initState() {
    animationController = AnimationController(
      duration: Duration(seconds: 2),
      vsync: this,
    );
    animation = Tween<double>(begin:0,end: widget.completion).animate(animationController)..addListener(
      ()=>setState(() {
      })
    );
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
    final Color elementColor = handleCategoryTileElementColor(widget.color);
    final Color subtitleColor = handleCategoryTileSubheaderColor(widget.color);

    return Padding(
      padding: const EdgeInsets.only(top: 5, bottom: 5),
      child: ListTile(
        onTap: widget.onTap,
        tileColor: widget.color,
        subtitle: Text(
          "completed: ${(widget.completion*100).round()}",
          style: TextStyle(
            color: subtitleColor,
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
        contentPadding: EdgeInsets.fromLTRB(20, 10, 20, 10),
        title: Text(
          widget.title,
          style: TextStyle(
            color: elementColor,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        trailing: Text(
          "${(animation.value*100).round()}%",
          style: TextStyle(
            color: elementColor,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        leading: Icon(widget.iconData, size: 30, color: elementColor),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadiusGeometry.circular(15),
        ),
      ),
    );
  }
}
