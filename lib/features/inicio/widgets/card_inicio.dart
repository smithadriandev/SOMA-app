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
    final secondaryColor = theme.textTheme.bodySmall?.color ?? textColor;
    final cardColor = theme.brightness == Brightness.dark
        ? theme.cardColor
        : SomaColors.fieldBlue;

    return Material(
      color: cardColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(9),
        side: BorderSide(
          color: theme.dividerColor.withValues(alpha: 0.65),
        ),
      ),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(9),
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.fromLTRB(13, 12, 13, 13),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Acompanhamento m\u00E9dico',
                style: TextStyle(
                  color: textColor,
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  height: 1.08,
                ),
              ),
              const SizedBox(height: 8),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
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
                      'N\u00EDvel de sa\u00FAde do dia',
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: textColor,
                        fontSize: 13,
                        fontWeight: FontWeight.w700,
                        height: 1.1,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 9),
              Text(
                'Veja registros de sa\u00FAde, humor, sono e medica\u00E7\u00E3o.',
                style: TextStyle(
                  color: secondaryColor,
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  height: 1.25,
                ),
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
    final secondaryColor = theme.textTheme.bodySmall?.color ?? textColor;
    final cardColor = theme.brightness == Brightness.dark
        ? theme.cardColor
        : const Color(0xFFE8FAFF);

    return Material(
      color: cardColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(9),
        side: BorderSide(
          color: theme.dividerColor.withValues(alpha: 0.65),
        ),
      ),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(9),
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.fromLTRB(13, 12, 10, 12),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Tarefas\nDi\u00E1rias',
                      style: TextStyle(
                        color: textColor,
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                        height: 0.98,
                      ),
                    ),
                    const SizedBox(height: 9),
                    Text(
                      'Acompanhe a rotina do paciente',
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: secondaryColor,
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        height: 1.2,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 12),
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
              backgroundColor: Theme.of(context).dividerColor,
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
