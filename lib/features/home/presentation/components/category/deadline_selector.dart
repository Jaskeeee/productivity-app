import 'package:flutter/material.dart';
import 'package:productivity_app/core/themes/themes.dart';
import 'package:productivity_app/core/utils.dart';

class DeadlineSelector extends StatelessWidget {
  final DateTime? selectedDeadline;
  final void Function() deleteDeadline;
  final Color optionalColor;
  final Color selectColor;
  final TextStyle subheaderStyle;
  final String title;
  final bool deadlineSelected;
  const DeadlineSelector({
    super.key,
    required this.title,
    required this.selectedDeadline,
    required this.deadlineSelected,
    required this.subheaderStyle,
    required this.deleteDeadline,
    required this.optionalColor,
    required this.selectColor,
  });

  @override
  Widget build(BuildContext context) {
    final Color iconColor = handleDefaultValueColor(selectColor);
    final Color dateTextColor = handleDefaultValueColor(selectColor);
    return Row(
      mainAxisAlignment: deadlineSelected
        ? MainAxisAlignment.spaceBetween
        : MainAxisAlignment.start,
      children: [
        Text(title, style: subheaderStyle),
        !deadlineSelected
        ?Text(
          "(Optional)",
          style: TextStyle(
            color: optionalColor,
            fontWeight: FontWeight.w400,
            fontSize: 16,
          ),
        )
        :SizedBox(
          child: Row(
            children: [
              Text(
                "${selectedDeadline!.day} ${months[selectedDeadline!.month]},${selectedDeadline!.year}",
                style: TextStyle(
                  color: dateTextColor,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              IconButton(
                onPressed: deleteDeadline,
                icon: Icon(
                  Icons.delete_outline_outlined,
                  color:iconColor,
                  size: 25,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
