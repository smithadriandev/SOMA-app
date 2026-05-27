import 'package:flutter/material.dart';

import '../../../app/routes.dart';

class MenuLateralInicio extends StatelessWidget {
  const MenuLateralInicio({super.key});

  void _sair(BuildContext context) {
    Navigator.pushNamedAndRemoveUntil(
      context,
      RotasApp.login,
      (route) => false,
    );
  }

  void _abrirRota(BuildContext context, String route) {
    Navigator.pop(context);
    Navigator.pushNamed(context, route);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textColor = theme.colorScheme.onSurface;
    final width = MediaQuery.sizeOf(context).width * 0.75;

    return Drawer(
      width: width.clamp(250.0, 340.0),
      backgroundColor: theme.cardColor,
      shape: const RoundedRectangleBorder(),
      child: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(8, 14, 16, 10),
              child: Row(
                children: [
                  IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: Icon(
                      Icons.arrow_back,
                      color: textColor,
                      size: 29,
                    ),
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(
                      minWidth: 38,
                      minHeight: 38,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Icon(
                    Icons.account_circle_outlined,
                    color: textColor,
                    size: 32,
                  ),
                  const SizedBox(width: 28),
                  Text(
                    'Usu\u00E1rio',
                    style: TextStyle(
                      color: textColor,
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ],
              ),
            ),
            Divider(height: 1, color: theme.dividerColor),
            _ItemMenuLateral(
              label: 'Sobre n\u00F3s',
              icon: Icons.groups_2_outlined,
              onTap: () => _abrirRota(context, RotasApp.sobre),
            ),
            _ItemMenuLateral(
              label: 'Conex\u00F5es',
              icon: Icons.contact_phone_outlined,
              onTap: () => _abrirRota(context, RotasApp.conexoes),
            ),
            _ItemMenuLateral(
              label: 'Configura\u00E7\u00F5es',
              icon: Icons.settings,
              onTap: () => _abrirRota(context, RotasApp.configuracoes),
            ),
            _ItemMenuLateral(
              label: 'Acessibilidade',
              icon: Icons.accessibility_new,
              onTap: () => _abrirRota(context, RotasApp.acessibilidade),
            ),
            const Spacer(),
            Padding(
              padding: const EdgeInsets.fromLTRB(18, 0, 18, 24),
              child: InkWell(
                onTap: () => _sair(context),
                borderRadius: BorderRadius.circular(8),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'Sair',
                        style: TextStyle(
                          color: Color(0xFFD41717),
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(width: 14),
                      Icon(
                        Icons.logout,
                        color: textColor,
                        size: 18,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ItemMenuLateral extends StatelessWidget {
  const _ItemMenuLateral({
    required this.label,
    required this.icon,
    required this.onTap,
  });

  final String label;
  final IconData icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textColor = theme.colorScheme.onSurface;

    return InkWell(
      onTap: onTap,
      child: Container(
        height: 46,
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(color: theme.dividerColor, width: 1),
          ),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 18),
        child: Row(
          children: [
            Expanded(
              child: Text(
                label,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: textColor,
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            Icon(
              icon,
              color: textColor,
              size: 20,
            ),
          ],
        ),
      ),
    );
  }
}