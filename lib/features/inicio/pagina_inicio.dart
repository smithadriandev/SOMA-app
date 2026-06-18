import 'package:flutter/material.dart';

import '../../app/routes.dart';
import '../tarefas_diarias/controllers/controlador_tarefas_diarias.dart';
import '../acompanhamento_medico/controllers/controlador_acompanhamento_medico.dart';
import 'widgets/barra_inferior_inicio.dart';
import 'widgets/card_inicio.dart';
import 'widgets/cabecalho_inicio.dart';
import 'widgets/menu_lateral_inicio.dart';

class PaginaInicio extends StatelessWidget {
  const PaginaInicio({super.key});

  static const _userName = 'Ana Mendes';

  void _openAccidentAlert(BuildContext context) {
    Navigator.pushNamed(context, RotasApp.alertaAcidente);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textColor = theme.colorScheme.onSurface;
    final secondaryColor = theme.textTheme.bodySmall?.color ?? textColor;
    final dailyTasksController = ControladorTarefasDiarias.instance;
    final medicalTrackingController = ControladorAcompanhamentoMedico.instance;

    return Scaffold(
      endDrawer: const MenuLateralInicio(),
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 420),
            child: Stack(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Builder(
                      builder: (context) {
                        return CabecalhoInicio(
                          onProfileTap: () =>
                              Scaffold.of(context).openEndDrawer(),
                        );
                      },
                    ),
                    Divider(height: 1, color: theme.dividerColor),
                    Expanded(
                      child: SingleChildScrollView(
                        padding: const EdgeInsets.fromLTRB(24, 34, 24, 24),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Bom dia, $_userName!',
                              style: TextStyle(
                                color: textColor,
                                fontSize: 16,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              'Organize a rotina, acompanhe a sa\u00FAde e acesse ajuda rapidamente.',
                              style: TextStyle(
                                color: secondaryColor,
                                fontSize: 13,
                                fontWeight: FontWeight.w500,
                                height: 1.35,
                              ),
                            ),
                            const SizedBox(height: 26),
                            AnimatedBuilder(
                              animation: medicalTrackingController,
                              builder: (context, _) {
                                return CardAcompanhamentoMedicoInicio(
                                  healthLevel:
                                      '${medicalTrackingController.textoNivelSaudeDia}/5',
                                  onTap: () => Navigator.pushNamed(
                                    context,
                                    RotasApp.acompanhamentoMedico,
                                  ),
                                );
                              },
                            ),
                            const SizedBox(height: 22),
                            AnimatedBuilder(
                              animation: dailyTasksController,
                              builder: (context, _) {
                                return CardTarefasDiariasInicio(
                                  progresso: dailyTasksController.progresso,
                                  onTap: () => Navigator.pushNamed(
                                    context,
                                    RotasApp.tarefasDiarias,
                                  ),
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
                Positioned(
                  right: 22,
                  bottom: 72,
                  child: _BotaoAlerta(onTap: () => _openAccidentAlert(context)),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _BotaoAlerta extends StatelessWidget {
  const _BotaoAlerta({required this.onTap});

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        customBorder: const CircleBorder(),
        child: Container(
          width: 58,
          height: 58,
          decoration: BoxDecoration(
            color: const Color(0xFFFF3B3B),
            shape: BoxShape.circle,
            border: Border.all(
              color: const Color(0xFF0069B8),
              width: 3,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.18),
                blurRadius: 5,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: Icon(
            Icons.campaign_outlined,
            color: Theme.of(context).colorScheme.onSurface,
            size: 34,
          ),
        ),
      ),
    );
  }
}
