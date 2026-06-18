import 'package:flutter/material.dart';

import '../../features/acessibilidade/controllers/controlador_acessibilidade.dart';

class BotaoPrincipal extends StatelessWidget {
  const BotaoPrincipal({
    super.key,
    required this.text,
    required this.onPressed,
    this.width,
    this.height = 52,
    this.fontSize = 20,
  });

  final String text;
  final VoidCallback onPressed;
  final double? width;
  final double height;
  final double fontSize;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final buttonColor = theme.colorScheme.primary;
    final acessibilidade = ControladorAcessibilidade.instance;

    return AnimatedBuilder(
      animation: acessibilidade,
      builder: (context, _) {
        final buttonHeight = acessibilidade.botoesMaiores
            ? (height < 58 ? 58.0 : height + 6)
            : height;
        final textSize = acessibilidade.botoesMaiores ? fontSize + 1 : fontSize;

        return SizedBox(
          width: width,
          height: buttonHeight,
          child: ElevatedButton(
            onPressed: onPressed,
            style: ElevatedButton.styleFrom(
              elevation: 6,
              shadowColor: buttonColor.withValues(alpha: 0.32),
              backgroundColor: buttonColor,
              foregroundColor: Colors.white,
              padding: EdgeInsets.symmetric(
                horizontal: acessibilidade.botoesMaiores ? 22 : 16,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(14),
                side: BorderSide(
                  color: Colors.white.withValues(
                    alpha: theme.brightness == Brightness.dark ? 0.16 : 0,
                  ),
                ),
              ),
            ),
            child: Text(
              text,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: textSize,
                fontWeight: FontWeight.w700,
                height: 1.1,
              ),
            ),
          ),
        );
      },
    );
  }
}
