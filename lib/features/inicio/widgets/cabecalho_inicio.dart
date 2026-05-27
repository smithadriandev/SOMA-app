import 'package:flutter/material.dart';

import '../../../shared/widgets/logo_soma.dart';

class CabecalhoInicio extends StatelessWidget {
  const CabecalhoInicio({
    super.key,
    required this.onProfileTap,
  });

  final VoidCallback onProfileTap;

  @override
  Widget build(BuildContext context) {
    final textColor = Theme.of(context).colorScheme.onSurface;

    return Padding(
      padding: const EdgeInsets.fromLTRB(22, 14, 18, 10),
      child: Row(
        children: [
          const LogoSoma(width: 42),
          const Spacer(),
          IconButton(
            onPressed: onProfileTap,
            icon: Icon(
              Icons.account_circle_outlined,
              color: textColor,
              size: 31,
            ),
            padding: EdgeInsets.zero,
            constraints: const BoxConstraints(
              minWidth: 40,
              minHeight: 40,
            ),
          ),
        ],
      ),
    );
  }
}


