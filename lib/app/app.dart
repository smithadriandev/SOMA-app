import 'package:flutter/material.dart';

import 'routes.dart';
import 'theme.dart';
import 'theme_controller.dart';

class SomaApp extends StatelessWidget {
  const SomaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<bool>(
      valueListenable: ThemeController.isDarkMode,
      builder: (context, isDarkMode, _) {
        return MaterialApp(
          title: 'Soma',
          debugShowCheckedModeBanner: false,
          theme: SomaTheme.light,
          darkTheme: SomaTheme.dark,
          themeMode: ThemeController.themeMode,
          initialRoute: AppRoutes.splash,
          routes: AppRoutes.routes,
        );
      },
    );
  }
}
