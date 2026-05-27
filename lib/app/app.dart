import 'package:flutter/material.dart';

import '../features/accessibility/controllers/accessibility_controller.dart';
import 'routes.dart';
import 'theme.dart';
import 'theme_controller.dart';

class SomaApp extends StatelessWidget {
  const SomaApp({super.key});

  @override
  Widget build(BuildContext context) {
    final accessibility = AccessibilityController.instance;

    return AnimatedBuilder(
      animation: Listenable.merge([
        ThemeController.isDarkMode,
        accessibility,
      ]),
      builder: (context, _) {
        final isDarkMode = ThemeController.isDarkMode.value;

        return MaterialApp(
          title: 'Soma',
          debugShowCheckedModeBanner: false,
          theme: SomaTheme.light,
          darkTheme: SomaTheme.dark,
          themeMode: isDarkMode ? ThemeMode.dark : ThemeMode.light,
          initialRoute: AppRoutes.splash,
          routes: AppRoutes.routes,
          builder: (context, child) {
            final mediaQuery = MediaQuery.of(context);
            return MediaQuery(
              data: mediaQuery.copyWith(
                textScaler: TextScaler.linear(accessibility.textScale),
              ),
              child: child ?? const SizedBox.shrink(),
            );
          },
        );
      },
    );
  }
}