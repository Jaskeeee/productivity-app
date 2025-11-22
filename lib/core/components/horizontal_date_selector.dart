import 'package:easy_date_timeline/easy_date_timeline.dart';
import 'package:flutter/material.dart';
import 'package:productivity_app/core/components/calendar_child.dart';
import 'package:productivity_app/core/components/cancel_button.dart';
import 'package:productivity_app/core/components/confirm_button.dart';
import 'package:productivity_app/core/utils.dart';

class HorizontalDateSelector extends StatefulWidget {
final DateTime selectedDate; 
  final Color? selectedColor;
  final void Function(DateTime)? onDateChange;
  const HorizontalDateSelector({
    super.key,
    required this.selectedDate,
    required this.onDateChange,
    required this.selectedColor
  });

  @override
  State<HorizontalDateSelector> createState() => _HorizontalDateSelectorState();
}

class _HorizontalDateSelectorState extends State<HorizontalDateSelector> {
  // DateTime selecteDate = DateTime.now();
  @override
  Widget build(BuildContext context) {
    final DateTime today = DateTime.now(); 
    return EasyDateTimeLinePicker.itemBuilder(
      firstDate: DateTime(today.year,today.month,(today.month-10)), 
      lastDate: DateTime(2099), 
      focusedDate: widget.selectedDate, 
      itemExtent: 120, 
      headerOptions: HeaderOptions(
        headerType: HeaderType.picker
      ),
      monthYearPickerOptions: MonthYearPickerOptions(
        
        confirmButtonBuilder: (context, handleConfirm, confirmText)=>ConfirmButton(text: confirmText, onPressed: handleConfirm),
        cancelButtonBuilder: (context, handleCancel, cancelText) => CancelButton(text: cancelText, onPressed: handleCancel),
        cancelText: "Cancel",
        cancelTextStyle:TextStyle(
          color: Theme.of(context).colorScheme.inversePrimary,
          fontWeight: FontWeight.bold
        ),
        confirmText: "Confirm",
        confirmTextStyle: TextStyle(
          color: Theme.of(context).colorScheme.inversePrimary,
          fontWeight: FontWeight.bold
        )
      ),
      timelineOptions: TimelineOptions(
        height: 50
      ),
      itemBuilder: (BuildContext context, DateTime date, bool isSelected, bool isDisabled, bool isToday, void Function() onTap) {
        final String dayName = weekdays[date.weekday];
        final String monthName = months[date.month];
        return CalendarChild(
          isToday: isToday,
          date: date, 
          selectedColor: widget.selectedColor ?? Theme.of(context).colorScheme.inversePrimary,
          isSelected: isSelected, 
          dayName: dayName,
          monthName: monthName, 
          onPressed: onTap
        );
      }, 
      onDateChange: widget.onDateChange,
    );
  }
}