import 'package:flutter/material.dart';

extension StringExtension on String {
  String capitalize() => [substring(0, 1).toUpperCase(), substring(1)].join();
  bool get isValidEmail => RegExp(
          r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
      .hasMatch(this);

  Color? stringToColor() {
    var hexColor = replaceAll("#", "");
    if (hexColor.length == 6) {
      hexColor = "FF$hexColor";
    }
    if (hexColor.length == 8) {
      return Color(int.parse("0x$hexColor"));
    }
    return null;
  }

  ThemeMode toThemeMode() => ThemeMode.values
      .firstWhere((mode) => mode.name.toLowerCase() == toLowerCase());
}
