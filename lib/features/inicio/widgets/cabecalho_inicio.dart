import 'package:flutter/material.dart';

import '../../../app/theme.dart';
import '../../../shared/widgets/logo_soma.dart';

class CabecalhoInicio extends StatelessWidget {
  const CabecalhoInicio({
    super.key,
    required this.onProfileTap,
  });

  final VoidCallback onProfileTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(22, 12, 18, 8),
      child: Row(
        children: [
          const LogoSoma(width: 42),
          const Spacer(),
          _BotaoMenuPerfil(onTap: onProfileTap),
        ],
      ),
    );
  }
}

class _BotaoMenuPerfil extends StatelessWidget {
  const _BotaoMenuPerfil({required this.onTap});

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final borderColor = isDark ? SomaColors.accentBlue : SomaColors.primaryBlue;
    final backgroundColor = isDark ? SomaColors.darkCard : SomaColors.cardBlue;
    final labelColor =
        theme.textTheme.bodySmall?.color ?? theme.colorScheme.onSurface;

    return Tooltip(
      message: 'Abrir menu',
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(16),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 44,
                  height: 44,
                  decoration: BoxDecoration(
                    color: backgroundColor,
                    shape: BoxShape.circle,
                    border: Border.all(color: borderColor, width: 1.6),
                    boxShadow: [
                      BoxShadow(
                        color:
                            borderColor.withValues(alpha: isDark ? 0.18 : 0.16),
                        blurRadius: 7,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Icon(
                    Icons.person_outline,
                    color: borderColor,
                    size: 28,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  'Menu',
                  style: TextStyle(
                    color: labelColor,
                    fontSize: 10,
                    fontWeight: FontWeight.w800,
                    height: 1,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
