import 'package:flutter/material.dart';
import 'package:DNL/common/values/colors.dart';

class CustomTextStyle {
  const CustomTextStyle();

  /// fontSize: 64
  static TextStyle getHeaderStyle([
    Color textColor = ThemeColors.onSecondary,
    double fontSize = 64,
    FontWeight fontWeight = FontWeight.w800,
  ]) =>
      TextStyle(
          color: textColor,
          fontWeight: fontWeight,
          fontSize: fontSize,
          letterSpacing: 0.44);

  /// fontSize: 22
  static TextStyle getTitleStyle([
    Color textColor = ThemeColors.onSecondary,
    double fontSize = 22,
    FontWeight fontWeight = FontWeight.w700,
  ]) =>
      TextStyle(
          color: textColor,
          fontWeight: fontWeight,
          fontSize: fontSize,
          letterSpacing: 0.44);

  /// fontSize: 20
  static TextStyle getInputStyle([
    Color textColor = ThemeColors.onSecondary,
    double fontSize = 20,
    FontWeight fontWeight = FontWeight.w500,
  ]) =>
      TextStyle(color: textColor, fontWeight: fontWeight, fontSize: fontSize);

  /// fontSize: 18
  static TextStyle getSubtitleStyle([
    Color textColor = ThemeColors.onSecondary,
    double fontSize = 18,
    FontWeight fontWeight = FontWeight.w500,
  ]) =>
      TextStyle(
        color: textColor,
        fontSize: fontSize,
        fontWeight: fontWeight,
      );

  /// fontSize: 16
  static TextStyle getDescStyle([
    Color textColor = ThemeColors.onSecondary,
    double fontSize = 16,
    FontWeight fontWeight = FontWeight.w600,
  ]) =>
      TextStyle(
        color: textColor,
        fontSize: fontSize,
        fontWeight: fontWeight,
      );

  /// fontSize: 14
  static TextStyle getSpanStyle([
    Color textColor = ThemeColors.onSecondary,
    double fontSize = 14,
    FontWeight fontWeight = FontWeight.w500,
  ]) =>
      TextStyle(
        color: textColor,
        fontSize: fontSize,
        fontWeight: fontWeight,
      );
}
