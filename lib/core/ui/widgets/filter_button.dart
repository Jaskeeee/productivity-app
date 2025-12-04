import 'package:flutter/material.dart';

class FilterButton extends StatelessWidget {
  final bool isSelected;
  final String label;
  final void Function() onTap;
  const FilterButton({
    super.key,
    required this.isSelected,
    required this.label,
    required this.onTap
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.all(10),
        padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
        decoration: BoxDecoration(
          color: isSelected
          ?Theme.of(context).colorScheme.inversePrimary
          :Theme.of(context).colorScheme.secondary,
          borderRadius: BorderRadius.circular(15)
        ),
        child: Text(
          label,
          style: TextStyle(
            color: isSelected
            ?Theme.of(context).scaffoldBackgroundColor
            :Theme.of(context).colorScheme.inversePrimary,
            fontWeight: FontWeight.w600
          ),
        ),
      )
    );
  }
}