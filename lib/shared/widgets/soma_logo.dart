import 'package:flutter/material.dart';

import '../../app/theme.dart';

class SomaLogo extends StatelessWidget {
  const SomaLogo({super.key, this.width = 220, this.large = false});

  final double width;
  final bool large;

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      'assets/images/soma_logo.png',
      width: width,
      fit: BoxFit.contain,
      errorBuilder: (_, __, ___) => _FallbackLogo(large: large),
    );
  }
}

class _FallbackLogo extends StatelessWidget {
  const _FallbackLogo({required this.large});

  final bool large;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          'Soma',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: SomaColors.primaryBlue,
            fontSize: large ? 48 : 34,
            fontWeight: FontWeight.w800,
          ),
        ),
        const SizedBox(height: 6),
        SizedBox(
          width: large ? 280 : 210,
          child: const Text(
            'SISTEMA DE ORGANIZAÇÃO E MONITORAMENTO DO ALZHEIMER',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: SomaColors.primaryBlue,
              fontSize: 11,
              fontWeight: FontWeight.w700,
              height: 1.15,
            ),
          ),
        ),
      ],
    );
  }
}
