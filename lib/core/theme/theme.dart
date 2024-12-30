import 'package:flutter/material.dart';
import 'app_pallete.dart';

class AppTheme {
  static _border([Color color = AppPallete.borderColor]) => OutlineInputBorder(
        borderSide: BorderSide(color: color, width: 3),
        borderRadius: BorderRadius.circular(15),
      );

  static final darkThemeMode = ThemeData.dark().copyWith(
      scaffoldBackgroundColor: AppPallete.backgroundColor,
      inputDecorationTheme: InputDecorationTheme(
        contentPadding: const EdgeInsets.all(25),
        enabledBorder: _border(),
        focusedBorder: _border(AppPallete.gradient2),
        errorBorder: _border(AppPallete.errorColor),
        border: _border(),
      ),
      chipTheme: const ChipThemeData(
        selectedColor: AppPallete.gradient1,
        disabledColor: AppPallete.borderColor,
      ),
      appBarTheme: const AppBarTheme(color: AppPallete.backgroundColor));
}
