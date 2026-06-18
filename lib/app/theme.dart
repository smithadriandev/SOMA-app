import 'package:flutter/material.dart';

class SomaColors {
  static const primaryBlue = Color(0xFF4DA3D9);
  static const accentBlue = Color(0xFF63B7E6);

  static const fieldBlue = Color(0xFFDDF6FF);
  static const cardBlue = Color(0xFFE5F7FF);
  static const splashBackground = Color(0xFFFFFDF4);
  static const pageBackground = Color(0xFFF8FBFD);
  static const textDark = Color(0xFF111827);
  static const placeholder = Color(0xFF4B5563);
  static const lightDivider = Color(0xFFD1D5DB);

  static const darkBackground = Color(0xFF151A24);
  static const darkSurface = Color(0xFF202A36);
  static const darkCard = Color(0xFF1F2937);
  static const darkField = Color(0xFF263445);
  static const darkText = Color(0xFFF5F7FA);
  static const darkSecondary = Color(0xFFC7D0DD);
  static const darkDivider = Color(0xFF334155);
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
      colorScheme: const ColorScheme.light(
        primary: SomaColors.primaryBlue,
        secondary: SomaColors.accentBlue,
        surface: SomaColors.pageBackground,
        onSurface: SomaColors.textDark,
        error: Color(0xFFE53935),
      ),
      scaffoldBackgroundColor: SomaColors.pageBackground,
      cardColor: SomaColors.cardBlue,
      dividerColor: SomaColors.lightDivider,
      fontFamily: 'Roboto',
      textTheme: _lightTextTheme,
      iconTheme: const IconThemeData(color: SomaColors.textDark),
      cardTheme: CardThemeData(
        color: SomaColors.cardBlue,
        elevation: 1,
        shadowColor: SomaColors.primaryBlue.withValues(alpha: 0.08),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
          side: BorderSide(
            color: SomaColors.lightDivider.withValues(alpha: 0.55),
          ),
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: SomaColors.primaryBlue,
          foregroundColor: Colors.white,
          elevation: 5,
          shadowColor: SomaColors.primaryBlue.withValues(alpha: 0.25),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(
            color: SomaColors.lightDivider.withValues(alpha: 0.45),
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(
            color: SomaColors.primaryBlue,
            width: 1.4,
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: Color(0xFFE53935)),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: Color(0xFFE53935), width: 1.4),
        ),
        filled: true,
        fillColor: SomaColors.fieldBlue,
        hintStyle: const TextStyle(
          color: SomaColors.placeholder,
          fontSize: 16,
          fontWeight: FontWeight.w400,
        ),
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 18, vertical: 16),
      ),
      snackBarTheme: const SnackBarThemeData(
        behavior: SnackBarBehavior.floating,
        backgroundColor: SomaColors.textDark,
        contentTextStyle: TextStyle(color: Colors.white),
      ),
      drawerTheme: const DrawerThemeData(
        backgroundColor: SomaColors.cardBlue,
        scrimColor: Color(0x66000000),
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
      colorScheme: const ColorScheme.dark(
        primary: SomaColors.accentBlue,
        secondary: SomaColors.primaryBlue,
        surface: SomaColors.darkSurface,
        onSurface: SomaColors.darkText,
        error: Color(0xFFEF5350),
      ),
      scaffoldBackgroundColor: SomaColors.darkBackground,
      cardColor: SomaColors.darkCard,
      dividerColor: SomaColors.darkDivider,
      fontFamily: 'Roboto',
      textTheme: _darkTextTheme,
      iconTheme: const IconThemeData(color: SomaColors.darkText),
      cardTheme: CardThemeData(
        color: SomaColors.darkCard,
        elevation: 2,
        shadowColor: Colors.black.withValues(alpha: 0.28),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
          side: BorderSide(
            color: SomaColors.darkDivider.withValues(alpha: 0.7),
          ),
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: SomaColors.accentBlue,
          foregroundColor: Colors.white,
          elevation: 5,
          shadowColor: SomaColors.accentBlue.withValues(alpha: 0.22),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(
            color: SomaColors.darkDivider.withValues(alpha: 0.8),
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(
            color: SomaColors.accentBlue,
            width: 1.5,
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: Color(0xFFEF5350)),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: Color(0xFFEF5350), width: 1.5),
        ),
        filled: true,
        fillColor: SomaColors.darkField,
        hintStyle: const TextStyle(
          color: SomaColors.darkSecondary,
          fontSize: 16,
          fontWeight: FontWeight.w400,
        ),
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 18, vertical: 16),
      ),
      snackBarTheme: const SnackBarThemeData(
        behavior: SnackBarBehavior.floating,
        backgroundColor: SomaColors.darkSurface,
        contentTextStyle: TextStyle(color: SomaColors.darkText),
      ),
      drawerTheme: const DrawerThemeData(
        backgroundColor: SomaColors.darkCard,
        scrimColor: Color(0xAA000000),
      ),
      switchTheme: SwitchThemeData(
        thumbColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return Colors.white;
          }
          return const Color(0xFFC7D0DD);
        }),
        trackColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return const Color(0xFF4CAF50);
          }
          return const Color(0xFF526174);
        }),
      ),
    );
  }
}
