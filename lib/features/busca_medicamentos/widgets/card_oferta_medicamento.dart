import 'package:flutter/material.dart';

import '../../../app/theme.dart';
import '../models/oferta_medicamento.dart';

class CardOfertaMedicamento extends StatelessWidget {
  const CardOfertaMedicamento({
    super.key,
    required this.offer,
    required this.isBestOffer,
    required this.onViewMap,
  });

  final OfertaMedicamento offer;
  final bool isBestOffer;
  final VoidCallback onViewMap;

  String _formatarPreco(double price) {
    return 'R\$ ${price.toStringAsFixed(2).replaceAll('.', ',')}';
  }

  _PriorityColors _priorityColors(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return switch (offer.priority) {
      PrioridadeMedicamento.high => _PriorityColors(
          background:
              isDark ? const Color(0xFF3A1F1F) : const Color(0xFFFFE5E5),
          foreground:
              isDark ? const Color(0xFFFFB4AB) : const Color(0xFFB00020),
          border: isDark ? const Color(0xFFEF5350) : const Color(0xFFE53935),
        ),
      PrioridadeMedicamento.medium => _PriorityColors(
          background:
              isDark ? const Color(0xFF3A2F1A) : const Color(0xFFFFF3CD),
          foreground:
              isDark ? const Color(0xFFFFD580) : const Color(0xFF8A5A00),
          border: const Color(0xFFF59E0B),
        ),
      PrioridadeMedicamento.low => _PriorityColors(
          background:
              isDark ? const Color(0xFF163322) : const Color(0xFFE6F7EF),
          foreground:
              isDark ? const Color(0xFFA7F3D0) : const Color(0xFF116B3A),
          border: const Color(0xFF22C55E),
        ),
    };
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textColor = theme.colorScheme.onSurface;
    final secondaryColor = theme.textTheme.bodySmall?.color ?? textColor;
    final isDark = theme.brightness == Brightness.dark;
    final priorityColors = _priorityColors(context);
    final cardColor = isBestOffer
        ? (isDark ? SomaColors.darkField : const Color(0xFFD9F5FF))
        : theme.cardColor;

    return Container(
      margin: const EdgeInsets.only(bottom: 14),
      padding: EdgeInsets.all(isBestOffer ? 18 : 14),
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color: isBestOffer
              ? theme.colorScheme.primary.withValues(alpha: 0.4)
              : theme.dividerColor.withValues(alpha: 0.7),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: isDark ? 0.18 : 0.08),
            blurRadius: isBestOffer ? 8 : 4,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Wrap(
            spacing: 8,
            runSpacing: 8,
            crossAxisAlignment: WrapCrossAlignment.center,
            children: [
              if (isBestOffer)
                const Text(
                  'Melhor oferta',
                  style: TextStyle(
                    color: Color(0xFF2EAD5B),
                    fontSize: 15,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              _PriorityChip(
                label: offer.priorityLabel,
                colors: priorityColors,
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(
                Icons.local_pharmacy,
                color: theme.colorScheme.primary,
                size: isBestOffer ? 30 : 24,
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      offer.medicineName,
                      style: TextStyle(
                        color: textColor,
                        fontSize: isBestOffer ? 18 : 15,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      offer.pharmacyName,
                      style: TextStyle(
                        color: textColor,
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      offer.address,
                      style: TextStyle(
                        color: secondaryColor,
                        fontSize: 13,
                        height: 1.25,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 10),
              Text(
                _formatarPreco(offer.price),
                style: TextStyle(
                  color: theme.colorScheme.primary,
                  fontSize: isBestOffer ? 22 : 16,
                  fontWeight: FontWeight.w900,
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          Align(
            alignment: Alignment.centerRight,
            child: SizedBox(
              height: 34,
              child: ElevatedButton.icon(
                onPressed: onViewMap,
                icon: const Icon(Icons.map_outlined, size: 16),
                label: const Text('Ver no mapa'),
                style: ElevatedButton.styleFrom(
                  elevation: 2,
                  backgroundColor: theme.colorScheme.primary,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  textStyle: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w800,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _PriorityChip extends StatelessWidget {
  const _PriorityChip({required this.label, required this.colors});

  final String label;
  final _PriorityColors colors;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: colors.background,
        borderRadius: BorderRadius.circular(999),
        border: Border.all(color: colors.border, width: 1.1),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: colors.foreground,
          fontSize: 12,
          fontWeight: FontWeight.w900,
        ),
      ),
    );
  }
}

class _PriorityColors {
  const _PriorityColors({
    required this.background,
    required this.foreground,
    required this.border,
  });

  final Color background;
  final Color foreground;
  final Color border;
}
