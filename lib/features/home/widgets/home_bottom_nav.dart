import 'package:flutter/material.dart';

import '../../../app/routes.dart';
import '../../../app/theme.dart';

class HomeBottomNav extends StatelessWidget {
  const HomeBottomNav({super.key});

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
          _BottomNavIcon(
            icon: Icons.settings_outlined,
            color: SomaColors.primaryBlue,
            onTap: () => Navigator.pushNamed(context, AppRoutes.settings),
          ),
          _BottomNavIcon(
            icon: Icons.public_outlined,
            color: iconColor,
            onTap: () => Navigator.pushNamed(context, AppRoutes.pharmaciesMap),
          ),
          _BottomNavIcon(icon: Icons.smart_toy_outlined, color: iconColor),
          _BottomNavIcon(icon: Icons.help_outline, color: iconColor),
        ],
      ),
    );
  }
}

class _BottomNavIcon extends StatelessWidget {
  const _BottomNavIcon({
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
