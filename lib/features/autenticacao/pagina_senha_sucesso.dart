import 'package:flutter/material.dart';

import '../../app/routes.dart';
import '../../shared/widgets/botao_principal.dart';

class PaginaSenhaSucesso extends StatelessWidget {
  const PaginaSenhaSucesso({super.key});

  void _goToLogin(BuildContext context) {
    Navigator.pushNamedAndRemoveUntil(
      context,
      RotasApp.login,
      (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    final textColor = Theme.of(context).colorScheme.onSurface;

    return Scaffold(
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            return Padding(
              padding: const EdgeInsets.fromLTRB(24, 50, 24, 22),
              child: Center(
                child: SizedBox(
                  width: 320,
                  child: Column(
                    children: [
                      SizedBox(height: constraints.maxHeight * 0.18),
                      Text(
                        'Sua senha foi\nalterada com\nsucesso!',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: textColor,
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                          height: 1.35,
                        ),
                      ),
                      const SizedBox(height: 20),
                      Container(
                        width: 74,
                        height: 74,
                        decoration: BoxDecoration(
                          color: const Color(0xFF2DBE78),
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withValues(alpha: 0.18),
                              blurRadius: 4,
                              offset: const Offset(0, 3),
                            ),
                          ],
                        ),
                        child: const Icon(
                          Icons.check,
                          color: Colors.white,
                          size: 46,
                        ),
                      ),
                      const Spacer(),
                      BotaoPrincipal(
                        text: 'Voltar a página\nde login',
                        width: 200,
                        height: 48,
                        fontSize: 14,
                        onPressed: () => _goToLogin(context),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
