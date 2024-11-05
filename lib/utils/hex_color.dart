import 'package:flutter/material.dart';

class HexColor extends Color {

  static int _getColorFromHex(String hexColor) {
    hexColor = hexColor.toUpperCase().replaceAll("#", "");
    if (hexColor.length == 6) {
      hexColor = "FF$hexColor";
    }

    final hexNum = int.parse(hexColor, radix: 16);

    return (hexNum == 0) ? 0xff000000 : hexNum;
  }

  HexColor(final String hexColor) : super(_getColorFromHex(hexColor));
}

class ColorToHex extends Color {

  /// convert material colors to hex color
  static int _convertColorTHex(Color color) {
    var hex = '${color.value}';
    return int.parse(
      hex,
    );
  }

  ColorToHex(final Color color) : super(_convertColorTHex(color));
}
