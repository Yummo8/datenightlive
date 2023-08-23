import 'package:flutter/material.dart';

class ThemeColors {
  static const Color background = Color(0xffe0e1dd);
  static const Color primary = Color(0xFFf95F80);
  static const Color onPrimary = Color(0x1Ff95F80);
  static const Color secondary = Color(0xffffffff);
  static const Color onSecondary = Color(0xff000000);
  static const Color input = Color(0xFFF6F7F9);
  static const Color label = Color(0xFFACADAF);
  static const Color border = Color(0xFF3E3E3E);
  static const Gradient gradient = LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      colors: [
        Color.fromRGBO(251, 104, 94, 0.82),
        Color.fromRGBO(247, 84, 162, 0.82),
      ],
      stops: [
        0,
        1
      ]);
}
