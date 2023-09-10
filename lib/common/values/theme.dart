import 'package:flutter/material.dart';
import 'package:DNL/common/values/colors.dart';

class AlwaysActiveBorderSide extends MaterialStateBorderSide {
  @override
  BorderSide? resolve(states) => const BorderSide(color: ThemeColors.border);
}

class AppTheme {
  static ThemeData lightTheme() => ThemeData(
      fontFamily: 'Manrope',
      colorScheme: ColorScheme.fromSeed(
          seedColor: ThemeColors.primary,
          brightness: Brightness.light,
          primary: ThemeColors.primary,
          onPrimary: ThemeColors.onPrimary,
          secondary: ThemeColors.secondary,
          onSecondary: ThemeColors.onSecondary,
          outline: ThemeColors.border,
          onSurface: ThemeColors.label,
          background: ThemeColors.background,
          onBackground: ThemeColors.input),
      checkboxTheme: CheckboxThemeData(
          checkColor:
              MaterialStateProperty.resolveWith((_) => ThemeColors.onSecondary),
          fillColor:
              MaterialStateProperty.resolveWith((_) => ThemeColors.secondary),
          side: AlwaysActiveBorderSide(),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(4))),
      scaffoldBackgroundColor: ThemeColors.background,
      useMaterial3: true,
      brightness: Brightness.light);
}
