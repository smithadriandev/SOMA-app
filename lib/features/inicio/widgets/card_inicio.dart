import 'package:flutter/material.dart';

import '../../../app/theme.dart';

class CardAcompanhamentoMedicoInicio extends StatelessWidget {
  const CardAcompanhamentoMedicoInicio({
    super.key,
    required this.healthLevel,
    required this.onTap,
  });

  final String healthLevel;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textColor = theme.colorScheme.onSurface;
    final cardColor = theme.brightness == Brightness.dark
        ? theme.cardColor
        : SomaColors.fieldBlue;

    return Material(
      color: cardColor,
      borderRadius: BorderRadius.circular(9),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(9),
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.fromLTRB(12, 10, 12, 11),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Acompanhamento médico',
                style: TextStyle(
                  color: textColor,
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                  height: 1.05,
                ),
              ),
              const SizedBox(height: 6),
              Row(
                children: [
                  Icon(
                    Icons.fingerprint,
                    size: 42,
                    color: textColor,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    healthLevel,
                    style: TextStyle(
                      color: textColor,
                      fontSize: 28,
                      fontWeight: FontWeight.w800,
                      height: 1,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      'Nível de saúde do dia',
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: textColor,
                        fontSize: 13,
                        fontWeight: FontWeight.w700,
                        height: 1.05,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CardTarefasDiariasInicio extends StatelessWidget {
  const CardTarefasDiariasInicio({
    super.key,
    required this.progresso,
    required this.onTap,
  });

  final double progresso;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textColor = theme.colorScheme.onSurface;
    final cardColor = theme.brightness == Brightness.dark
        ? theme.cardColor
        : const Color(0xFFE8FAFF);

    return Material(
      color: cardColor,
      borderRadius: BorderRadius.circular(9),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(9),
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.fromLTRB(12, 9, 10, 9),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Tarefas\nDiárias',
                      style: TextStyle(
                        color: textColor,
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        height: 0.95,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Acompanhe',
                      style: TextStyle(
                        color: textColor,
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
              ),
              _ProgressoCircularTarefas(progresso: progresso),
            ],
          ),
        ),
      ),
    );
  }
}

class _ProgressoCircularTarefas extends StatelessWidget {
  const _ProgressoCircularTarefas({required this.progresso});

  final double progresso;

  @override
  Widget build(BuildContext context) {
    final percentage = (progresso * 100).round();
    final textColor = Theme.of(context).colorScheme.onSurface;

    return SizedBox(
      width: 66,
      height: 66,
      child: Stack(
        alignment: Alignment.center,
        children: [
          SizedBox(
            width: 60,
            height: 60,
            child: CircularProgressIndicator(
              value: progresso,
              strokeWidth: 11,
              strokeCap: StrokeCap.round,
              backgroundColor: const Color(0xFFD8D1CD),
              valueColor: const AlwaysStoppedAnimation<Color>(
                Color(0xFF61BCEB),
              ),
            ),
          ),
          Text(
            '$percentage%',
            style: TextStyle(
              color: textColor,
              fontSize: 14,
              fontWeight: FontWeight.w800,
            ),
          ),
        ],
      ),
    );
  }
}