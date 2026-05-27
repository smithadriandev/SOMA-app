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
            return MediaQuery(
              data: mediaQuery.copyWith(
                textScaler: TextScaler.linear(acessibilidade.escalaTexto),
              ),
              child: child ?? const SizedBox.shrink(),
            );
          },
        );
      },
    );
  }
}