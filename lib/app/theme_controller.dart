import 'package:flutter/material.dart';

class ThemeController {
  const ThemeController._();

  static final ValueNotifier<bool> isDarkMode = ValueNotifier<bool>(false);

  static ThemeMode get themeMode =>
      isDarkMode.value ? ThemeMode.dark : ThemeMode.light;

  static void toggleTheme(bool value) {
    isDarkMode.value = value;
  }
}
