import 'package:flutter/material.dart';
import 'package:poets_paradise/cores/palette/app_palette.dart';

class AppTheme {
  static final _border = OutlineInputBorder(
    borderSide: const BorderSide(
      color: AppPallete.borderColor,
      width: 2,
    ),
    borderRadius: BorderRadius.circular(12),
  );

  static final _errorBorder = OutlineInputBorder(
    borderSide: const BorderSide(
      color: AppPallete.errorColor,
      width: 2,
    ),
    borderRadius: BorderRadius.circular(12),
  );
  static final lightThemeMode = ThemeData.light().copyWith(
    scaffoldBackgroundColor: AppPallete.backgroundColor,

    // theme for input decoration:
    inputDecorationTheme: InputDecorationTheme(
      contentPadding: const EdgeInsets.all(20),
      enabledBorder: _border,
      focusedBorder: _border,
      errorBorder: _errorBorder,
      focusedErrorBorder: _errorBorder,
      //hintStyle: TextStyle(color: Colors.black)
    ),
    chipTheme: const ChipThemeData(
      color: WidgetStatePropertyAll(AppPallete.backgroundColor),
      side: BorderSide.none,
    ),

    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ButtonStyle(
        padding: WidgetStateProperty.all<EdgeInsetsGeometry>(
            const EdgeInsets.fromLTRB(97, 18, 97, 18)),
        shape: WidgetStateProperty.all(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        // backgroundColor: WidgetStateProperty.all(AppPallete.purpleColor),
      ),
    ),
  );
}
