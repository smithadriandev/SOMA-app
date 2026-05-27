import 'package:flutter/material.dart';

import '../../app/theme.dart';
import '../../shared/widgets/campo_texto_customizado.dart';
import '../../shared/widgets/botao_principal.dart';
import 'controllers/controlador_acompanhamento_medico.dart';
import 'models/registro_medico.dart';

class PaginaAcompanhamentoMedico extends StatelessWidget {
  const PaginaAcompanhamentoMedico({super.key});

  ControladorAcompanhamentoMedico get _controller => ControladorAcompanhamentoMedico.instance;

  Future<void> _showRecordSheet(
    BuildContext context, {
    RegistroMedico? initialRecord,
    int? recordIndex,
  }) async {
    final record = await showModalBottomSheet<RegistroMedico>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Theme.of(context).cardColor,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(18)),
      ),
      builder: (context) => _AddRegistroMedicoSheet(
        initialRecord: initialRecord,
      ),
    );

    if (record == null) return;

    if (recordIndex == null) {
      _controller.adicionarRegistro(record);
    } else {
      _controller.atualizarRegistro(recordIndex, record);
    }

    if (!context.mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          recordIndex == null
              ? 'Registro adicionado com sucesso'
              : 'Registro atualizado com sucesso',
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textColor = theme.colorScheme.onSurface;
    final secondaryColor = theme.textTheme.bodySmall?.color ?? Colors.grey;

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
                      Expanded(
                        child: Text(
                          'Acompanhamento médico',
                          style: TextStyle(
                            color: textColor,
                            fontSize: 21,
                            fontWeight: FontWeight.w800,
                          ),
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
                      final registros = _controller.registros;

                      return ListView.builder(
                        padding: const EdgeInsets.fromLTRB(18, 18, 18, 22),
                        itemCount: registros.length + 1,
                        itemBuilder: (context, index) {
                          if (index == 0) {
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                _CardNivelSaude(
                                  nivelSaudeDia: _controller.nivelSaudeDia,
                                  onChanged: _controller.atualizarNivelSaudeDia,
                                ),
                                const SizedBox(height: 16),
                                BotaoPrincipal(
                                  text: 'Adicionar registro',
                                  width: double.infinity,
                                  height: 48,
                                  fontSize: 16,
                                  onPressed: () => _showRecordSheet(context),
                                ),
                                const SizedBox(height: 22),
                                Text(
                                  'Registros recentes',
                                  style: TextStyle(
                                    color: textColor,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w800,
                                  ),
                                ),
                                const SizedBox(height: 5),
                                Text(
                                  'Acompanhe saúde, rotina e comportamento de forma simples.',
                                  style: TextStyle(
                                    color: secondaryColor,
                                    fontSize: 13,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                const SizedBox(height: 14),
                              ],
                            );
                          }

                          final recordIndex = index - 1;
                          final record = registros[recordIndex];

                          return _RegistroMedicoCard(
                            record: record,
                            onTap: () => _showRecordSheet(
                              context,
                              initialRecord: record,
                              recordIndex: recordIndex,
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

class _CardNivelSaude extends StatelessWidget {
  const _CardNivelSaude({
    required this.nivelSaudeDia,
    required this.onChanged,
  });

  final double nivelSaudeDia;
  final ValueChanged<double> onChanged;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textColor = theme.colorScheme.onSurface;
    final secondaryColor = theme.textTheme.bodySmall?.color ?? Colors.grey;
    final cardColor = theme.brightness == Brightness.dark
        ? theme.cardColor
        : SomaColors.fieldBlue;

    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: theme.dividerColor),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Nível de saúde do dia',
            style: TextStyle(
              color: textColor,
              fontSize: 18,
              fontWeight: FontWeight.w800,
            ),
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              Icon(
                Icons.monitor_heart_outlined,
                color: textColor,
                size: 40,
              ),
              const SizedBox(width: 12),
              Text(
                '${nivelSaudeDia.toStringAsFixed(1)}/5',
                style: TextStyle(
                  color: textColor,
                  fontSize: 34,
                  fontWeight: FontWeight.w900,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            'Arraste para ajustar o acompanhamento do dia.',
            style: TextStyle(
              color: secondaryColor,
              fontSize: 13,
              fontWeight: FontWeight.w700,
            ),
          ),
          Slider(
            value: nivelSaudeDia,
            min: 0,
            max: 5,
            divisions: 10,
            label: nivelSaudeDia.toStringAsFixed(1),
            activeColor: theme.colorScheme.primary,
            onChanged: onChanged,
          ),
          Text(
            'Baseado nos registros de humor, sono, alimentação e medicação.',
            style: TextStyle(
              color: secondaryColor,
              fontSize: 13,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Este indicador é apenas um acompanhamento diário e não substitui avaliação médica.',
            style: TextStyle(
              color: secondaryColor,
              fontSize: 11,
              height: 1.3,
            ),
          ),
        ],
      ),
    );
  }
}

class _RegistroMedicoCard extends StatelessWidget {
  const _RegistroMedicoCard({
    required this.record,
    required this.onTap,
  });

  final RegistroMedico record;
  final VoidCallback onTap;

  Color _impactColor() {
    return switch (record.impact) {
      ImpactoMedico.positive => const Color(0xFF2DBE78),
      ImpactoMedico.attention => const Color(0xFFFF9800),
      ImpactoMedico.critical => const Color(0xFFFF3B3B),
      ImpactoMedico.neutral => SomaColors.primaryBlue,
    };
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textColor = theme.colorScheme.onSurface;
    final secondaryColor = theme.textTheme.bodySmall?.color ?? Colors.grey;
    final impactColor = _impactColor();
    final cardColor = theme.brightness == Brightness.dark
        ? theme.cardColor
        : const Color(0xFFF2FBFF);

    return Material(
      color: cardColor,
      borderRadius: BorderRadius.circular(12),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Container(
          margin: const EdgeInsets.only(bottom: 12),
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: theme.dividerColor),
          ),
          child: Row(
            children: [
              Container(
                width: 42,
                height: 42,
                decoration: BoxDecoration(
                  color: impactColor.withValues(alpha: 0.16),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(
                  record.icon,
                  color: impactColor,
                  size: 25,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${record.dateTimeText} • ${record.type}',
                      style: TextStyle(
                        color: textColor,
                        fontSize: 14,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      record.description,
                      style: TextStyle(
                        color: secondaryColor,
                        fontSize: 13,
                        fontWeight: FontWeight.w500,
                        height: 1.25,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      'Impacto: ${record.impactLabel}',
                      style: TextStyle(
                        color: impactColor,
                        fontSize: 12,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ],
                ),
              ),
              Icon(
                Icons.edit_outlined,
                color: secondaryColor,
                size: 18,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _AddRegistroMedicoSheet extends StatefulWidget {
  const _AddRegistroMedicoSheet({this.initialRecord});

  final RegistroMedico? initialRecord;

  @override
  State<_AddRegistroMedicoSheet> createState() => _AddRegistroMedicoSheetState();
}

class _AddRegistroMedicoSheetState extends State<_AddRegistroMedicoSheet> {
  final _descriptionController = TextEditingController();
  final _detailController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  late String _type;
  late ImpactoMedico _impact;

  final _types = const [
    'Medicamento',
    'Sintoma',
    'Humor',
    'Sono',
    'Alimentação',
    'Sinais vitais',
    'Consulta',
  ];

  @override
  void initState() {
    super.initState();
    final initialRecord = widget.initialRecord;
    _type = initialRecord?.type ?? 'Medicamento';
    _impact = initialRecord?.impact ?? ImpactoMedico.neutral;
    _descriptionController.text = initialRecord?.description ?? '';
  }

  @override
  void dispose() {
    _descriptionController.dispose();
    _detailController.dispose();
    super.dispose();
  }

  String? _required(String? value) {
    if ((value ?? '').trim().isEmpty) {
      return 'Digite uma descrição';
    }

    return null;
  }

  void _save() {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    final description = _detailController.text.trim().isEmpty
        ? _descriptionController.text.trim()
        : '${_descriptionController.text.trim()} - ${_detailController.text.trim()}';

    Navigator.pop(
      context,
      RegistroMedico(
        dateTimeText: widget.initialRecord?.dateTimeText ?? 'Hoje - agora',
        type: _type,
        description: description,
        impact: _impact,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textColor = theme.colorScheme.onSurface;
    final isEditing = widget.initialRecord != null;

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
                isEditing ? 'Editar registro' : 'Adicionar registro',
                style: TextStyle(
                  color: textColor,
                  fontSize: 20,
                  fontWeight: FontWeight.w800,
                ),
              ),
              const SizedBox(height: 14),
              DropdownButtonFormField<String>(
                initialValue: _type,
                dropdownColor: theme.cardColor,
                decoration: const InputDecoration(labelText: 'Tipo'),
                items: _types
                    .map(
                      (type) => DropdownMenuItem(
                        value: type,
                        child: Text(type),
                      ),
                    )
                    .toList(),
                onChanged: (value) {
                  if (value != null) {
                    setState(() => _type = value);
                  }
                },
              ),
              const SizedBox(height: 12),
              CampoTextoCustomizado(
                controller: _descriptionController,
                hintText: 'Descrição do registro',
                validator: _required,
                contentVerticalPadding: 12,
              ),
              const SizedBox(height: 12),
              CampoTextoCustomizado(
                controller: _detailController,
                hintText: 'Observação opcional',
                contentVerticalPadding: 12,
              ),
              const SizedBox(height: 12),
              DropdownButtonFormField<ImpactoMedico>(
                initialValue: _impact,
                dropdownColor: theme.cardColor,
                decoration: const InputDecoration(labelText: 'Impacto'),
                items: ImpactoMedico.values
                    .map(
                      (impact) => DropdownMenuItem(
                        value: impact,
                        child: Text(_impactLabel(impact)),
                      ),
                    )
                    .toList(),
                onChanged: (value) {
                  if (value != null) {
                    setState(() => _impact = value);
                  }
                },
              ),
              const SizedBox(height: 18),
              BotaoPrincipal(
                text: 'Salvar registro',
                width: double.infinity,
                height: 48,
                fontSize: 16,
                onPressed: _save,
              ),
            ],
          ),
        ),
      ),
    );
  }

  String _impactLabel(ImpactoMedico impact) {
    return switch (impact) {
      ImpactoMedico.positive => 'positivo',
      ImpactoMedico.attention => 'atenção',
      ImpactoMedico.critical => 'crítico',
      ImpactoMedico.neutral => 'neutro',
    };
  }
}