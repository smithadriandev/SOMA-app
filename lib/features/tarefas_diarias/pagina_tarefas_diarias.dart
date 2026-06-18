import 'package:flutter/material.dart';

import '../../shared/widgets/botao_principal.dart';
import '../../shared/widgets/campo_texto_customizado.dart';
import 'controllers/controlador_tarefas_diarias.dart';
import 'models/tarefa_diaria.dart';

class PaginaTarefasDiarias extends StatelessWidget {
  const PaginaTarefasDiarias({super.key});

  void _mostrarDetalhes(
    BuildContext context,
    ControladorTarefasDiarias controller,
    int index,
  ) {
    final task = controller.tarefas[index];
    final theme = Theme.of(context);
    final textColor = theme.colorScheme.onSurface;
    final secondaryColor = theme.textTheme.bodySmall?.color ?? textColor;

    showModalBottomSheet<void>(
      context: context,
      backgroundColor: theme.cardColor,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(18)),
      ),
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.fromLTRB(20, 20, 20, 22),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Detalhes da tarefa',
                style: TextStyle(
                  color: textColor,
                  fontSize: 20,
                  fontWeight: FontWeight.w800,
                ),
              ),
              const SizedBox(height: 16),
              _LinhaDetalhe(label: 'Nome', value: task.title),
              _LinhaDetalhe(label: 'Categoria', value: task.category),
              _LinhaDetalhe(label: 'Hor\u00E1rio', value: task.time),
              _LinhaDetalhe(
                label: 'Status',
                value: task.isCompleted ? 'Conclu\u00EDda' : 'Pendente',
              ),
              const SizedBox(height: 12),
              Text(
                task.descriptionText,
                style: TextStyle(
                  color: secondaryColor,
                  fontSize: 14,
                  height: 1.35,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 18),
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () => Navigator.pop(context),
                      style: OutlinedButton.styleFrom(
                        minimumSize: const Size.fromHeight(48),
                        side: BorderSide(color: theme.dividerColor),
                      ),
                      child: const Text('Fechar'),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: BotaoPrincipal(
                      text: task.isCompleted
                          ? 'Marcar pendente'
                          : 'Marcar conclu\u00EDda',
                      height: 48,
                      fontSize: 14,
                      onPressed: () {
                        controller.atualizarTarefa(
                          index,
                          task.copyWith(isCompleted: !task.isCompleted),
                        );
                        Navigator.pop(context);
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  Future<void> _editarTarefa(
    BuildContext context,
    ControladorTarefasDiarias controller,
    int index,
  ) async {
    final task = controller.tarefas[index];
    final updatedTask = await showModalBottomSheet<TarefaDiaria>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Theme.of(context).cardColor,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(18)),
      ),
      builder: (context) => _EditarTarefaSheet(task: task),
    );

    if (updatedTask == null) return;

    controller.atualizarTarefa(index, updatedTask);

    if (!context.mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Tarefa atualizada com sucesso')),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textColor = theme.colorScheme.onSurface;
    final secondaryColor = theme.textTheme.bodySmall?.color ?? textColor;
    final controller = ControladorTarefasDiarias.instance;

    return Scaffold(
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 520),
            child: Column(
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
                        'Tarefas Di\u00E1rias',
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
                    animation: controller,
                    builder: (context, _) {
                      return ListView.builder(
                        padding: const EdgeInsets.fromLTRB(18, 18, 18, 22),
                        itemCount: controller.tarefas.length + 1,
                        itemBuilder: (context, index) {
                          if (index == 0) {
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                _CardProgressoDiario(
                                  progresso: controller.progresso,
                                  percentualProgresso:
                                      controller.percentualProgresso,
                                  totalConcluidas: controller.totalConcluidas,
                                  totalTarefas: controller.totalTarefas,
                                ),
                                const SizedBox(height: 14),
                                _CardComoUsar(
                                  textColor: textColor,
                                  secondaryColor: secondaryColor,
                                ),
                                const SizedBox(height: 18),
                                Text(
                                  'Rotina de hoje',
                                  style: TextStyle(
                                    color: textColor,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w800,
                                  ),
                                ),
                                const SizedBox(height: 14),
                              ],
                            );
                          }

                          final taskIndex = index - 1;
                          final task = controller.tarefas[taskIndex];

                          return _TarefaDiariaCard(
                            task: task,
                            onToggle: () =>
                                controller.alternarTarefa(taskIndex),
                            onDetails: () => _mostrarDetalhes(
                                context, controller, taskIndex),
                            onEdit: () => _editarTarefa(
                              context,
                              controller,
                              taskIndex,
                            ),
                          );
                        },
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

class _CardComoUsar extends StatelessWidget {
  const _CardComoUsar({
    required this.textColor,
    required this.secondaryColor,
  });

  final Color textColor;
  final Color secondaryColor;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: theme.cardColor,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: theme.dividerColor),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Marque as tarefas conclu\u00EDdas e acompanhe o progresso da rotina do paciente.',
            style: TextStyle(
              color: textColor,
              fontSize: 14,
              height: 1.35,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Toque em uma tarefa para ver detalhes ou use o \u00EDcone de l\u00E1pis para editar.',
            style: TextStyle(
              color: secondaryColor,
              fontSize: 12,
              height: 1.35,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}

class _CardProgressoDiario extends StatelessWidget {
  const _CardProgressoDiario({
    required this.progresso,
    required this.percentualProgresso,
    required this.totalConcluidas,
    required this.totalTarefas,
  });

  final double progresso;
  final int percentualProgresso;
  final int totalConcluidas;
  final int totalTarefas;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textColor = theme.colorScheme.onSurface;
    final secondaryColor = theme.textTheme.bodySmall?.color ?? textColor;
    final cardColor = theme.brightness == Brightness.dark
        ? theme.cardColor
        : const Color(0xFFE8FAFF);

    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: theme.dividerColor),
      ),
      child: Row(
        children: [
          SizedBox(
            width: 78,
            height: 78,
            child: Stack(
              alignment: Alignment.center,
              children: [
                SizedBox(
                  width: 70,
                  height: 70,
                  child: CircularProgressIndicator(
                    value: progresso,
                    strokeWidth: 10,
                    strokeCap: StrokeCap.round,
                    backgroundColor: theme.dividerColor,
                    valueColor: AlwaysStoppedAnimation<Color>(
                      theme.colorScheme.primary,
                    ),
                  ),
                ),
                Text(
                  '$percentualProgresso%',
                  style: TextStyle(
                    color: textColor,
                    fontSize: 16,
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Progresso de hoje',
                  style: TextStyle(
                    color: textColor,
                    fontSize: 18,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  '$percentualProgresso% conclu\u00EDdo',
                  style: TextStyle(
                    color: secondaryColor,
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 8),
                LinearProgressIndicator(
                  value: progresso,
                  minHeight: 7,
                  borderRadius: BorderRadius.circular(10),
                  backgroundColor: theme.dividerColor,
                  valueColor: AlwaysStoppedAnimation<Color>(
                    theme.colorScheme.primary,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  '$totalConcluidas de $totalTarefas tarefas conclu\u00EDdas',
                  style: TextStyle(
                    color: secondaryColor,
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _TarefaDiariaCard extends StatelessWidget {
  const _TarefaDiariaCard({
    required this.task,
    required this.onToggle,
    required this.onDetails,
    required this.onEdit,
  });

  final TarefaDiaria task;
  final VoidCallback onToggle;
  final VoidCallback onDetails;
  final VoidCallback onEdit;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textColor = theme.colorScheme.onSurface;
    final secondaryColor = theme.textTheme.bodySmall?.color ?? textColor;
    final statusColor =
        task.isCompleted ? const Color(0xFF2DBE78) : theme.colorScheme.primary;
    final cardColor = theme.brightness == Brightness.dark
        ? theme.cardColor
        : const Color(0xFFF2FBFF);

    return Material(
      color: cardColor,
      borderRadius: BorderRadius.circular(12),
      child: InkWell(
        onTap: onDetails,
        borderRadius: BorderRadius.circular(12),
        child: Container(
          margin: const EdgeInsets.only(bottom: 12),
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: theme.dividerColor),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Checkbox(
                value: task.isCompleted,
                onChanged: (_) => onToggle(),
                activeColor: const Color(0xFF2DBE78),
                visualDensity: VisualDensity.compact,
              ),
              const SizedBox(width: 4),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      task.time,
                      style: TextStyle(
                        color: secondaryColor,
                        fontSize: 12,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    const SizedBox(height: 3),
                    Text(
                      task.title,
                      style: TextStyle(
                        color: textColor,
                        fontSize: 15,
                        fontWeight: FontWeight.w800,
                        decoration: task.isCompleted
                            ? TextDecoration.lineThrough
                            : null,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      'Categoria: ${task.category}',
                      style: TextStyle(
                        color: secondaryColor,
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 3),
                    Text(
                      task.isCompleted
                          ? 'Status: Conclu\u00EDda'
                          : 'Status: Pendente',
                      style: TextStyle(
                        color: statusColor,
                        fontSize: 12,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 6),
              Column(
                children: [
                  _IconeAcao(
                    icon: Icons.info_outline,
                    tooltip: 'Detalhes',
                    color: theme.colorScheme.primary,
                    onTap: onDetails,
                  ),
                  const SizedBox(height: 6),
                  _IconeAcao(
                    icon: Icons.edit_outlined,
                    tooltip: 'Editar',
                    color: secondaryColor,
                    onTap: onEdit,
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

class _IconeAcao extends StatelessWidget {
  const _IconeAcao({
    required this.icon,
    required this.tooltip,
    required this.color,
    required this.onTap,
  });

  final IconData icon;
  final String tooltip;
  final Color color;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: tooltip,
      child: InkResponse(
        onTap: onTap,
        radius: 24,
        child: SizedBox(
          width: 38,
          height: 38,
          child: Icon(icon, color: color, size: 23),
        ),
      ),
    );
  }
}

class _LinhaDetalhe extends StatelessWidget {
  const _LinhaDetalhe({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textColor = theme.colorScheme.onSurface;
    final secondaryColor = theme.textTheme.bodySmall?.color ?? textColor;

    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: RichText(
        text: TextSpan(
          style: TextStyle(color: secondaryColor, fontSize: 14, height: 1.35),
          children: [
            TextSpan(
              text: '$label: ',
              style: TextStyle(color: textColor, fontWeight: FontWeight.w800),
            ),
            TextSpan(text: value),
          ],
        ),
      ),
    );
  }
}

class _EditarTarefaSheet extends StatefulWidget {
  const _EditarTarefaSheet({required this.task});

  final TarefaDiaria task;

  @override
  State<_EditarTarefaSheet> createState() => _EditarTarefaSheetState();
}

class _EditarTarefaSheetState extends State<_EditarTarefaSheet> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _tituloController;
  late final TextEditingController _horarioController;
  late final TextEditingController _categoriaController;

  @override
  void initState() {
    super.initState();
    _tituloController = TextEditingController(text: widget.task.title);
    _horarioController = TextEditingController(text: widget.task.time);
    _categoriaController = TextEditingController(text: widget.task.category);
  }

  @override
  void dispose() {
    _tituloController.dispose();
    _horarioController.dispose();
    _categoriaController.dispose();
    super.dispose();
  }

  String? _required(String? value) {
    if ((value ?? '').trim().isEmpty) {
      return 'Campo obrigat\u00F3rio';
    }
    return null;
  }

  void _salvar() {
    if (!_formKey.currentState!.validate()) return;

    Navigator.pop(
      context,
      widget.task.copyWith(
        title: _tituloController.text.trim(),
        time: _horarioController.text.trim(),
        category: _categoriaController.text.trim(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textColor = theme.colorScheme.onSurface;

    return Padding(
      padding: EdgeInsets.only(
        left: 18,
        right: 18,
        top: 18,
        bottom: MediaQuery.viewInsetsOf(context).bottom + 18,
      ),
      child: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Editar tarefa',
                style: TextStyle(
                  color: textColor,
                  fontSize: 20,
                  fontWeight: FontWeight.w800,
                ),
              ),
              const SizedBox(height: 14),
              CampoTextoCustomizado(
                controller: _tituloController,
                hintText: 'Nome da tarefa',
                validator: _required,
                contentVerticalPadding: 12,
              ),
              const SizedBox(height: 12),
              CampoTextoCustomizado(
                controller: _horarioController,
                hintText: 'Hor\u00E1rio',
                validator: _required,
                contentVerticalPadding: 12,
              ),
              const SizedBox(height: 12),
              CampoTextoCustomizado(
                controller: _categoriaController,
                hintText: 'Categoria',
                validator: _required,
                contentVerticalPadding: 12,
              ),
              const SizedBox(height: 18),
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () => Navigator.pop(context),
                      style: OutlinedButton.styleFrom(
                        minimumSize: const Size.fromHeight(48),
                        side: BorderSide(color: theme.dividerColor),
                      ),
                      child: const Text('Cancelar'),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: BotaoPrincipal(
                      text: 'Salvar',
                      height: 48,
                      fontSize: 15,
                      onPressed: _salvar,
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
