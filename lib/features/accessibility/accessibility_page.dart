import 'package:flutter/material.dart';

import 'controllers/accessibility_controller.dart';

class AccessibilityPage extends StatelessWidget {
  const AccessibilityPage({super.key});

  AccessibilityController get _controller => AccessibilityController.instance;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textColor = theme.colorScheme.onSurface;

    return Scaffold(
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 520),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 18, 20, 12),
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
                          minWidth: 40,
                          minHeight: 40,
                        ),
                      ),
                      const SizedBox(width: 6),
                      Text(
                        'Acessibilidade',
                        style: TextStyle(
                          color: textColor,
                          fontSize: 22,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ],
                  ),
                ),
                Divider(height: 1, color: theme.dividerColor),
                Expanded(
                  child: AnimatedBuilder(
                    animation: _controller,
                    builder: (context, _) {
                      return ListView(
                        padding: const EdgeInsets.fromLTRB(22, 22, 22, 28),
                        children: [
                          _AccessibilityCard(
                            title: 'Tamanho do texto',
                            subtitle: 'Ajuste o tamanho das letras do aplicativo.',
                            child: Wrap(
                              spacing: 10,
                              runSpacing: 10,
                              children: [
                                _TextScaleChip(
                                  label: 'Pequeno',
                                  scale: 0.9,
                                  selectedScale: _controller.textScale,
                                  onSelected: _controller.setTextScale,
                                ),
                                _TextScaleChip(
                                  label: 'Médio',
                                  scale: 1.0,
                                  selectedScale: _controller.textScale,
                                  onSelected: _controller.setTextScale,
                                ),
                                _TextScaleChip(
                                  label: 'Grande',
                                  scale: 1.2,
                                  selectedScale: _controller.textScale,
                                  onSelected: _controller.setTextScale,
                                ),
                              ],
                            ),
                          ),
                        ],
                      );
                    },
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

class _AccessibilityCard extends StatelessWidget {
  const _AccessibilityCard({
    required this.title,
    required this.subtitle,
    required this.child,
  });

  final String title;
  final String subtitle;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textColor = theme.colorScheme.onSurface;
    final secondaryColor = theme.textTheme.bodySmall?.color ?? textColor;

    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: theme.cardColor,
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.07),
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              color: textColor,
              fontSize: 17,
              fontWeight: FontWeight.w800,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            subtitle,
            style: TextStyle(
              color: secondaryColor,
              fontSize: 14,
              height: 1.35,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 16),
          child,
        ],
      ),
    );
  }
}

class _TextScaleChip extends StatelessWidget {
  const _TextScaleChip({
    required this.label,
    required this.scale,
    required this.selectedScale,
    required this.onSelected,
  });

  final String label;
  final double scale;
  final double selectedScale;
  final ValueChanged<double> onSelected;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final selected = selectedScale == scale;

    return ChoiceChip(
      label: Text(label),
      selected: selected,
      onSelected: (_) => onSelected(scale),
      selectedColor: theme.colorScheme.primary,
      backgroundColor: theme.inputDecorationTheme.fillColor ?? theme.cardColor,
      side: BorderSide(
        color: selected ? theme.colorScheme.primary : theme.dividerColor,
      ),
      labelStyle: TextStyle(
        color: selected ? Colors.white : theme.colorScheme.onSurface,
        fontWeight: FontWeight.w800,
      ),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    );
  }
}