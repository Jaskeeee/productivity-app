import 'package:flutter/material.dart';

class CalendarChild extends StatelessWidget {
  final bool isSelected;
  final bool isToday;
  final DateTime date;
  final String dayName;
  final String monthName;
  final Color selectedColor;
  final void Function() onPressed;
  const CalendarChild({
    super.key,
    required this.date,
    required this.dayName,
    required this.isSelected,
    required this.isToday,
    required this.monthName,
    required this.onPressed,
    required this.selectedColor
  });

  @override
  Widget build(BuildContext context) {
    final Color selectedChildColor= selectedColor.computeLuminance()>0.5
    ?Theme.of(context).scaffoldBackgroundColor
    :Theme.of(context).colorScheme.inversePrimary;
    final Color unSelectedChildColor = Theme.of(context).colorScheme.inversePrimary; 
    final TextStyle style = TextStyle(
      color: isSelected
      ?selectedChildColor
      :unSelectedChildColor,
      fontSize: 16,
      fontWeight: isSelected 
      ?FontWeight.w600
      :FontWeight.normal
    );
    final todayStyle = TextStyle(
      color: isSelected
      ?selectedChildColor
      :unSelectedChildColor,
      fontSize: 16,
      fontWeight: isSelected 
      ?FontWeight.bold
      :FontWeight.w600
    );
    return InkWell(
      onTap: onPressed,
      child: Container(
        padding: isSelected
        ?EdgeInsets.only(left:20,right:20)
        :EdgeInsets.zero,
        decoration: BoxDecoration(
          color: isSelected
          ?selectedColor
          :Theme.of(context).colorScheme.primary,
          borderRadius: BorderRadius.circular(60)
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "${date.day} ",
                    style:style,
                  ),
                  Text(
                    monthName,
                    style: style,
                  )
                ],
              ),
              if(isToday) 
              Text(
                "Today",
                style: todayStyle
              )  
            ],
          ),
        ),
      ),
    );
  }
}