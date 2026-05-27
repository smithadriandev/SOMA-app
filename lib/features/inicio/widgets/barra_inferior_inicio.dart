import 'package:flutter/material.dart';

import '../../../app/routes.dart';
import '../../../app/theme.dart';

class BarraInferiorInicio extends StatelessWidget {
  const BarraInferiorInicio({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final iconColor = theme.colorScheme.onSurface;

    return Container(
      height: 56,
      decoration: BoxDecoration(
        color: theme.scaffoldBackgroundColor,
        border: Border(
          top: BorderSide(color: theme.dividerColor, width: 1),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _IconeBarraInferior(
            icon: Icons.home_outlined,
            color: SomaColors.primaryBlue,
            onTap: () => Navigator.pushNamedAndRemoveUntil(
              context,
              RotasApp.inicio,
              (route) => false,
            ),
          ),
          _IconeBarraInferior(
            icon: Icons.public_outlined,
            color: iconColor,
            onTap: () => Navigator.pushNamed(context, RotasApp.mapaFarmacias),
          ),
          _IconeBarraInferior(
            icon: Icons.medication_outlined,
            color: iconColor,
            onTap: () => Navigator.pushNamed(context, RotasApp.buscarMedicamento),
          ),
          _IconeBarraInferior(
            icon: Icons.help_outline,
            color: iconColor,
            onTap: () => Navigator.pushNamed(context, RotasApp.ajuda),
          ),
        ],
      ),
    );
  }
}

class _IconeBarraInferior extends StatelessWidget {
  const _IconeBarraInferior({
    required this.icon,
    required this.color,
    this.onTap,
  });

  final IconData icon;
  final Color color;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: onTap,
      icon: Icon(
        icon,
        size: 30,
        color: color,
      ),
    );
  }
}


