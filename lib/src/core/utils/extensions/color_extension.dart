import 'dart:ui';

extension ColorExtension on Color {
  String colorToHex() => value.toRadixString(16).substring(2, 8);
}
