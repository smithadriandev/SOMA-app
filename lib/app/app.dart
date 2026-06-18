import 'package:flutter/material.dart';

import '../features/acessibilidade/controllers/controlador_acessibilidade.dart';
import 'routes.dart';
import 'theme.dart';
import 'controlador_tema.dart';

class SomaApp extends StatelessWidget {
  const SomaApp({super.key});

  @override
  Widget build(BuildContext context) {
    final acessibilidade = ControladorAcessibilidade.instance;

    return AnimatedBuilder(
      animation: Listenable.merge([
        ControladorTema.modoEscuroAtivo,
        acessibilidade,
      ]),
      builder: (context, _) {
        final modoEscuro = ControladorTema.modoEscuroAtivo.value;

        return MaterialApp(
          title: 'Soma',
          debugShowCheckedModeBanner: false,
          theme: SomaTheme.light,
          darkTheme: SomaTheme.dark,
          themeMode: modoEscuro ? ThemeMode.dark : ThemeMode.light,
          initialRoute: RotasApp.splash,
          routes: RotasApp.routes,
          builder: (context, child) {
            final mediaQuery = MediaQuery.of(context);
            final themedChild = acessibilidade.altoContraste
                ? Theme(
                    data: _temaAltoContraste(Theme.of(context)),
                    child: child ?? const SizedBox.shrink(),
                  )
                : child ?? const SizedBox.shrink();

            return MediaQuery(
              data: mediaQuery.copyWith(
                textScaler: TextScaler.linear(acessibilidade.escalaTexto),
              ),
              child: themedChild,
            );
          },
        );
      },
    );
  }

  ThemeData _temaAltoContraste(ThemeData theme) {
    final isDark = theme.brightness == Brightness.dark;
    final borderColor = isDark ? SomaColors.accentBlue : SomaColors.primaryBlue;
    final textColor = isDark ? Colors.white : SomaColors.textDark;
    final secondaryText =
        isDark ? const Color(0xFFE2E8F0) : const Color(0xFF1F2937);

    return theme.copyWith(
      colorScheme: theme.colorScheme.copyWith(
        primary: borderColor,
        onSurface: textColor,
      ),
      dividerColor: borderColor.withValues(alpha: 0.8),
      textTheme: theme.textTheme
          .apply(
            bodyColor: textColor,
            displayColor: textColor,
          )
          .copyWith(
            bodySmall:
                theme.textTheme.bodySmall?.copyWith(color: secondaryText),
          ),
      inputDecorationTheme: theme.inputDecorationTheme.copyWith(
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: borderColor, width: 2.2),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: borderColor.withValues(alpha: 0.85)),
        ),
      ),
      cardTheme: theme.cardTheme.copyWith(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
          side: BorderSide(
              color: borderColor.withValues(alpha: 0.85), width: 1.4),
        ),
      ),
    );
  }
}
