import 'package:flutter/material.dart';

import '../../../app/theme.dart';
import '../models/connection.dart';

class ConnectionCard extends StatelessWidget {
  const ConnectionCard({
    super.key,
    required this.connection,
  });

  final Connection connection;

  String _formatCpf(String cpf) {
    final digits = cpf.replaceAll(RegExp(r'\D'), '');
    if (digits.length != 11) {
      return cpf;
    }

    return '${digits.substring(0, 3)}.${digits.substring(3, 6)}.${digits.substring(6, 9)}-${digits.substring(9)}';
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textColor = theme.colorScheme.onSurface;
    final secondaryColor = theme.textTheme.bodySmall?.color ?? Colors.grey;
    final cardColor = theme.brightness == Brightness.dark
        ? theme.cardColor
        : const Color(0xFFE8FAFF);

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: theme.dividerColor),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 42,
            height: 42,
            decoration: BoxDecoration(
              color: SomaColors.primaryBlue.withValues(alpha: 0.16),
              borderRadius: BorderRadius.circular(10),
            ),
            child: const Icon(
              Icons.family_restroom_outlined,
              color: SomaColors.primaryBlue,
              size: 24,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  connection.name,
                  style: TextStyle(
                    color: textColor,
                    fontSize: 16,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(height: 6),
                _ConnectionInfoLine(
                  label: 'Parentesco',
                  value: connection.relationship,
                  color: secondaryColor,
                ),
                _ConnectionInfoLine(
                  label: 'Telefone',
                  value: connection.phone,
                  color: secondaryColor,
                ),
                if (connection.secondPhone.trim().isNotEmpty)
                  _ConnectionInfoLine(
                    label: 'Segundo contato',
                    value: connection.secondPhone,
                    color: secondaryColor,
                  ),
                _ConnectionInfoLine(
                  label: 'CPF',
                  value: _formatCpf(connection.cpf),
                  color: secondaryColor,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _ConnectionInfoLine extends StatelessWidget {
  const _ConnectionInfoLine({
    required this.label,
    required this.value,
    required this.color,
  });

  final String label;
  final String value;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 3),
      child: Text(
        '$label: $value',
        style: TextStyle(
          color: color,
          fontSize: 13,
          fontWeight: FontWeight.w600,
          height: 1.25,
        ),
      ),
    );
  }
}
