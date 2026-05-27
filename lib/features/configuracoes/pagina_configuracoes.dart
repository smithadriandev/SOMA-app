import 'package:flutter/material.dart';

import '../../app/controlador_tema.dart';
import '../../shared/widgets/logo_soma.dart';
import '../inicio/widgets/barra_inferior_inicio.dart';

class PaginaConfiguracoes extends StatefulWidget {
  const PaginaConfiguracoes({super.key});

  @override
  State<PaginaConfiguracoes> createState() => _PaginaConfiguracoesState();
}

class _PaginaConfiguracoesState extends State<PaginaConfiguracoes> {
  bool _locationEnabled = true;
  bool _notificationsEnabled = true;
  bool _cameraEnabled = true;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textColor = theme.colorScheme.onSurface;
    final secondaryColor = theme.textTheme.bodySmall?.color ?? Colors.grey;
    final fieldColor = theme.inputDecorationTheme.fillColor ?? theme.cardColor;

    return Scaffold(
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 420),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 14, 18, 8),
                  child: Row(
                    children: [
                      const LogoSoma(width: 38),
                      const Spacer(),
                      Icon(
                        Icons.account_circle_outlined,
                        color: textColor,
                        size: 27,
                      ),
                    ],
                  ),
                ),
                Divider(height: 1, color: theme.dividerColor),
                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.fromLTRB(24, 10, 24, 24),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            IconButton(
                              onPressed: () => Navigator.pop(context),
                              icon: Icon(
                                Icons.arrow_back,
                                color: textColor,
                                size: 25,
                              ),
                              padding: EdgeInsets.zero,
                              constraints: const BoxConstraints(
                                minWidth: 32,
                                minHeight: 32,
                              ),
                            ),
                            Text(
                              'Configurações',
                              style: TextStyle(
                                color: textColor,
                                fontSize: 15,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 12),
                        Text(
                          'Localização',
                          style: TextStyle(
                            color: textColor,
                            fontSize: 15,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        const SizedBox(height: 2),
                        _LinhaSwitchConfiguracoes(
                          label: 'Use minha localização',
                          value: _locationEnabled,
                          onChanged: (value) {
                            setState(() => _locationEnabled = value);
                          },
                        ),
                        const SizedBox(height: 8),
                        Container(
                          height: 38,
                          width: double.infinity,
                          padding: const EdgeInsets.symmetric(horizontal: 14),
                          decoration: BoxDecoration(
                            color: fieldColor,
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: Row(
                            children: [
                              Text(
                                'Cidade atual',
                                style: TextStyle(
                                  color: secondaryColor,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              const Spacer(),
                              Text(
                                'Aracaju – BR',
                                style: TextStyle(
                                  color: secondaryColor,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 18),
                        _DivisorConfiguracoes(color: theme.dividerColor),
                        _LinhaSwitchConfiguracoes(
                          label: 'Notificações',
                          value: _notificationsEnabled,
                          onChanged: (value) {
                            setState(() => _notificationsEnabled = value);
                          },
                        ),
                        _DivisorConfiguracoes(color: theme.dividerColor),
                        _LinhaValorConfiguracoes(
                          label: 'Idioma',
                          value: 'PT',
                          color: textColor,
                        ),
                        _DivisorConfiguracoes(color: theme.dividerColor),
                        _LinhaSwitchConfiguracoes(
                          label: 'Camera',
                          value: _cameraEnabled,
                          onChanged: (value) {
                            setState(() => _cameraEnabled = value);
                          },
                        ),
                        _DivisorConfiguracoes(color: theme.dividerColor),
                        ValueListenableBuilder<bool>(
                          valueListenable: ControladorTema.modoEscuroAtivo,
                          builder: (context, isDarkMode, _) {
                            return _LinhaSwitchConfiguracoes(
                              label: 'Tema escuro',
                              value: isDarkMode,
                              onChanged: ControladorTema.alternarTema,
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ),
                const BarraInferiorInicio(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _LinhaSwitchConfiguracoes extends StatelessWidget {
  const _LinhaSwitchConfiguracoes({
    required this.label,
    required this.value,
    required this.onChanged,
  });

  final String label;
  final bool value;
  final ValueChanged<bool> onChanged;

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme.onSurface;

    return SizedBox(
      height: 32,
      child: Row(
        children: [
          Expanded(
            child: Text(
              label,
              style: TextStyle(
                color: color,
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          Transform.scale(
            scale: 0.7,
            child: Switch(
              value: value,
              onChanged: onChanged,
            ),
          ),
        ],
      ),
    );
  }
}

class _LinhaValorConfiguracoes extends StatelessWidget {
  const _LinhaValorConfiguracoes({
    required this.label,
    required this.value,
    required this.color,
  });

  final String label;
  final String value;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 38,
      child: Row(
        children: [
          Expanded(
            child: Text(
              label,
              style: TextStyle(
                color: color,
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          Text(
            value,
            style: TextStyle(
              color: color,
              fontSize: 12,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}

class _DivisorConfiguracoes extends StatelessWidget {
  const _DivisorConfiguracoes({required this.color});

  final Color color;

  @override
  Widget build(BuildContext context) {
    return Divider(height: 1, color: color);
  }
}
