import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:password_manager/theme/colors.dart';

class AppTheme {
  static final light = ThemeData(
      brightness: Brightness.light,
      visualDensity: VisualDensity.adaptivePlatformDensity,
      colorScheme: AppColors.lightColorScheme,
      inputDecorationTheme: _AppInputTheme.light,
      fontFamily: GoogleFonts.lexend().fontFamily,
      textButtonTheme: _AppTextButtonTheme.light,
      textTheme: _AppTextTheme.light,
      scaffoldBackgroundColor: AppColors.lightColorScheme.surface);
}

class _AppInputTheme {
  static final light = InputDecorationTheme(
    isDense: true,
    contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 13),
    filled: true,
    fillColor: AppColors.lightColorScheme.secondary,
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(100),
      borderSide: BorderSide.none,
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(100),
      borderSide: BorderSide(
        color: AppColors.lightColorScheme.primary,
        width: 1.0,
      ),
    ),
    focusedErrorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(100),
      borderSide: BorderSide(
        color: AppColors.lightColorScheme.primary,
        width: 1.0,
      ),
    ),
    errorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(100),
      borderSide: BorderSide(
        color: AppColors.lightColorScheme.error,
        width: 1.0,
      ),
    ),
    hintStyle: TextStyle(
      color: AppColors.lightColorScheme.onSecondary,
    ),
  );
}

class _AppTextButtonTheme {
  static final light = TextButtonThemeData(
      style: ButtonStyle(
    padding: WidgetStatePropertyAll(
      EdgeInsets.symmetric(horizontal: 20, vertical: 13),
    ),
    shape: WidgetStatePropertyAll(
      RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(100),
      ),
    ),
    backgroundColor:
        WidgetStateProperty.resolveWith<Color?>((Set<WidgetState> states) {
      if (states.contains(WidgetState.disabled)) {
        return Color(0xffcbcbcb);
      }
      return AppColors.lightColorScheme.primary;
    }),
    foregroundColor:
        WidgetStatePropertyAll(AppColors.lightColorScheme.onPrimary),
  ));
}

class _AppTextTheme {
  static final light =
      TextTheme(bodyLarge: TextStyle(fontWeight: FontWeight.normal));
}
