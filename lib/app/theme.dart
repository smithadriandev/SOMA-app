import 'package:flutter/material.dart';

class SomaColors {
  static const primaryBlue = Color(0xFF4DA3D9);
  static const fieldBlue = Color(0xFFC8F0FF);
  static const darkField = Color(0xFF263238);
  static const darkSurface = Color(0xFF1E1E1E);
  static const splashBackground = Color(0xFFFFFDF4);
  static const pageBackground = Color(0xFFFFFFFF);
  static const textDark = Color(0xFF20252B);
  static const placeholder = Color(0xFF6F7479);
  static const darkText = Color(0xFFFFFFFF);
  static const darkSecondary = Color(0xFFBDBDBD);
  static const lightDivider = Color(0xFFDDDDDD);
  static const darkDivider = Color(0xFF333333);
}

class SomaTheme {
  static const _lightTextTheme = TextTheme(
    bodyLarge: TextStyle(color: SomaColors.textDark),
    bodyMedium: TextStyle(color: SomaColors.textDark),
    bodySmall: TextStyle(color: SomaColors.placeholder),
    titleLarge: TextStyle(color: SomaColors.textDark),
    titleMedium: TextStyle(color: SomaColors.textDark),
    titleSmall: TextStyle(color: SomaColors.textDark),
  );

  static const _darkTextTheme = TextTheme(
    bodyLarge: TextStyle(color: SomaColors.darkText),
    bodyMedium: TextStyle(color: SomaColors.darkText),
    bodySmall: TextStyle(color: SomaColors.darkSecondary),
    titleLarge: TextStyle(color: SomaColors.darkText),
    titleMedium: TextStyle(color: SomaColors.darkText),
    titleSmall: TextStyle(color: SomaColors.darkText),
  );

  static ThemeData get light {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      colorScheme: ColorScheme.fromSeed(
        seedColor: SomaColors.primaryBlue,
        primary: SomaColors.primaryBlue,
        surface: SomaColors.pageBackground,
        onSurface: SomaColors.textDark,
      ),
      scaffoldBackgroundColor: SomaColors.pageBackground,
      cardColor: SomaColors.fieldBlue,
      dividerColor: SomaColors.lightDivider,
      fontFamily: 'Roboto',
      textTheme: _lightTextTheme,
      inputDecorationTheme: const InputDecorationTheme(
        border: InputBorder.none,
        enabledBorder: InputBorder.none,
        focusedBorder: InputBorder.none,
        errorBorder: InputBorder.none,
        focusedErrorBorder: InputBorder.none,
        filled: true,
        fillColor: SomaColors.fieldBlue,
        hintStyle: TextStyle(
          color: SomaColors.placeholder,
          fontSize: 16,
          fontWeight: FontWeight.w400,
        ),
        contentPadding: EdgeInsets.symmetric(horizontal: 18, vertical: 16),
      ),
      snackBarTheme: const SnackBarThemeData(
        behavior: SnackBarBehavior.floating,
        backgroundColor: SomaColors.textDark,
      ),
      switchTheme: SwitchThemeData(
        thumbColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return Colors.white;
          }
          return const Color(0xFF9EA4A9);
        }),
        trackColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return const Color(0xFF4CAF50);
          }
          return const Color(0xFFD4D8DB);
        }),
      ),
    );
  }

  static ThemeData get dark {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      colorScheme: ColorScheme.fromSeed(
        brightness: Brightness.dark,
        seedColor: SomaColors.primaryBlue,
        primary: SomaColors.primaryBlue,
        surface: SomaColors.darkSurface,
        onSurface: SomaColors.darkText,
      ),
      scaffoldBackgroundColor: const Color(0xFF121212),
      cardColor: SomaColors.darkSurface,
      dividerColor: SomaColors.darkDivider,
      fontFamily: 'Roboto',
      textTheme: _darkTextTheme,
      inputDecorationTheme: const InputDecorationTheme(
        border: InputBorder.none,
        enabledBorder: InputBorder.none,
        focusedBorder: InputBorder.none,
        errorBorder: InputBorder.none,
        focusedErrorBorder: InputBorder.none,
        filled: true,
        fillColor: SomaColors.darkField,
        hintStyle: TextStyle(
          color: SomaColors.darkSecondary,
          fontSize: 16,
          fontWeight: FontWeight.w400,
        ),
        contentPadding: EdgeInsets.symmetric(horizontal: 18, vertical: 16),
      ),
      snackBarTheme: const SnackBarThemeData(
        behavior: SnackBarBehavior.floating,
        backgroundColor: SomaColors.darkSurface,
      ),
      drawerTheme: const DrawerThemeData(
        backgroundColor: SomaColors.darkSurface,
        scrimColor: Color(0x99000000),
      ),
      switchTheme: SwitchThemeData(
        thumbColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return Colors.white;
          }
          return const Color(0xFF9EA4A9);
        }),
        trackColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return const Color(0xFF4CAF50);
          }
          return const Color(0xFF555C61);
        }),
      ),
    );
  }
}
