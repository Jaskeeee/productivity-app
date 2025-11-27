import 'package:easy_pie_chart/easy_pie_chart.dart';
import 'package:flutter/material.dart';
import 'package:productivity_app/features/home/domain/model/category_model.dart';

class CategoryPieChart extends StatefulWidget {
  final List<CategoryModel> categories;
  const CategoryPieChart({
    super.key,
    required this.categories
  });

  @override
  State<CategoryPieChart> createState() => _CategoryPieChartState();
}

class _CategoryPieChartState extends State<CategoryPieChart> with TickerProviderStateMixin{
  late AnimationController animationController;
  late Animation<double> animation;

  double computeOverallCompletion(){
    int completion=0; 
    int value=0;
    for(var category in widget.categories){
      completion+=category.completed;
      value+=category.value;
    }
    return (completion/value)*100;
  }


  @override
  void initState() {
    animationController = AnimationController(
      vsync: this,
      duration: Duration(seconds: 2)
    );
    animation= Tween<double>(begin:0.0,end:computeOverallCompletion()).animate(animationController)..addListener(
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

    return Container(
      height: 250,
      width: 250,
      margin: EdgeInsets.all(10),
      child: EasyPieChart(
        gap: 0.7,
        shouldAnimate: true,
        centerText: "${animation.value.toStringAsFixed(2)}%",
        centerStyle: TextStyle(
          color: Theme.of(context).colorScheme.inversePrimary,
          fontWeight: FontWeight.bold,
          fontSize: 30
        ),
        children:List.generate(
          widget.categories.length,
          (index){
            final double value = widget.categories[index].value.toDouble();
            final Color color = Color(widget.categories[index].color);
            return PieData(value: value, color: color);
          }
        ),
        showValue: false,
        borderWidth: 30,
        size: 100,
      ),
    );
  }
}