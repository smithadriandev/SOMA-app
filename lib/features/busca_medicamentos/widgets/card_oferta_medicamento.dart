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

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textColor = theme.colorScheme.onSurface;
    final secondaryColor = theme.textTheme.bodySmall?.color ?? textColor;
    final isDark = theme.brightness == Brightness.dark;
    final cardColor = isBestOffer
        ? (isDark ? SomaColors.darkField : const Color(0xFFD9F5FF))
        : theme.cardColor;

    return Container(
      margin: const EdgeInsets.only(bottom: 14),
      padding: EdgeInsets.all(isBestOffer ? 18 : 14),
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(14),
        border: isBestOffer
            ? Border.all(
                color: theme.colorScheme.primary.withValues(alpha: 0.35),
              )
            : null,
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
          if (isBestOffer) ...[
            const Text(
              'Melhor oferta',
              style: TextStyle(
                color: Color(0xFF2EAD5B),
                fontSize: 15,
                fontWeight: FontWeight.w800,
              ),
            ),
            const SizedBox(height: 10),
          ],
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
                  backgroundColor: SomaColors.primaryBlue,
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