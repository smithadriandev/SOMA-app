import 'package:flutter/material.dart';

import 'controllers/controlador_acessibilidade.dart';

class PaginaAcessibilidade extends StatelessWidget {
  const PaginaAcessibilidade({super.key});

  ControladorAcessibilidade get _controller =>
      ControladorAcessibilidade.instance;

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
                          _CardAcessibilidade(
                            title: 'Tamanho do texto',
                            subtitle:
                                'Ajuste o tamanho das letras do aplicativo.',
                            child: Wrap(
                              spacing: 10,
                              runSpacing: 10,
                              children: [
                                _ChipEscalaTexto(
                                  label: 'Pequeno',
                                  scale: 0.9,
                                  selectedScale: _controller.escalaTexto,
                                  onSelected: _controller.definirEscalaTexto,
                                ),
                                _ChipEscalaTexto(
                                  label: 'M\u00E9dio',
                                  scale: 1.0,
                                  selectedScale: _controller.escalaTexto,
                                  onSelected: _controller.definirEscalaTexto,
                                ),
                                _ChipEscalaTexto(
                                  label: 'Grande',
                                  scale: 1.2,
                                  selectedScale: _controller.escalaTexto,
                                  onSelected: _controller.definirEscalaTexto,
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 16),
                          _CardAcessibilidade(
                            title: 'Alto contraste',
                            subtitle:
                                'Refor\u00E7a bordas, cores e leitura dos textos.',
                            child: SwitchListTile(
                              contentPadding: EdgeInsets.zero,
                              title: const Text('Ativar alto contraste'),
                              value: _controller.altoContraste,
                              onChanged: _controller.alternarAltoContraste,
                            ),
                          ),
                          const SizedBox(height: 16),
                          _CardAcessibilidade(
                            title: 'Bot\u00F5es maiores',
                            subtitle:
                                'Aumenta os bot\u00F5es principais para facilitar o toque.',
                            child: SwitchListTile(
                              contentPadding: EdgeInsets.zero,
                              title: const Text('Usar bot\u00F5es maiores'),
                              value: _controller.botoesMaiores,
                              onChanged: _controller.alternarBotoesMaiores,
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

class _CardAcessibilidade extends StatelessWidget {
  const _CardAcessibilidade({
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
        border: Border.all(color: theme.dividerColor.withValues(alpha: 0.75)),
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

class _ChipEscalaTexto extends StatelessWidget {
  const _ChipEscalaTexto({
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
