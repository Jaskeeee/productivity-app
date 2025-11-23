import 'package:flutter/material.dart';
import 'package:flutter_iconpicker/Models/configuration.dart';
import 'package:flutter_iconpicker/flutter_iconpicker.dart';

class CategoryFunctions {
  Color borderColorSelect(BuildContext context, Color color) {
    final double lum = color.computeLuminance();
    if (lum < 0.03) {
      return Theme.of(context).colorScheme.primary;
    } else if (lum > 0.4) {
      return Theme.of(context).scaffoldBackgroundColor;
    } else {
      return Theme.of(context).colorScheme.inversePrimary;
    }
  }



  Future<IconPickerIcon?> iconPickerDialog(BuildContext context) async {
    return await showIconPicker(
      context,
      configuration: SinglePickerConfiguration(
        iconPickerShape: RoundedRectangleBorder(
          borderRadius: BorderRadiusGeometry.circular(15),
        ),
        backgroundColor: Theme.of(context).colorScheme.secondary,
        iconPackModes: [IconPack.cupertino, IconPack.material],
      ),
    );
  }

  Future<void> _handleIconPIcker(BuildContext context,void Function() setState,)async {
    final IconPickerIcon? icon = await iconPickerDialog(context);
    if (icon != null) {}
  }
}
