import 'package:flutter/material.dart';
import 'package:flutter_iconpicker/Models/configuration.dart';
import 'package:flutter_iconpicker/flutter_iconpicker.dart';

class CategoryFunctions {
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
}
