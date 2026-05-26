import 'package:flutter/material.dart';

import '../../app/theme.dart';
import '../../shared/widgets/custom_text_field.dart';
import '../../shared/widgets/primary_button.dart';
import 'controllers/medical_tracking_controller.dart';
import 'models/medical_record.dart';

class MedicalTrackingPage extends StatelessWidget {
  const MedicalTrackingPage({super.key});

  Future<void> _showRecordSheet(
    BuildContext context, {
    MedicalRecord? initialRecord,
    int? recordIndex,
  }) async {
    final record = await showModalBottomSheet<MedicalRecord>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Theme.of(context).cardColor,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(18)),
      ),
      builder: (context) => _AddMedicalRecordSheet(
        initialRecord: initialRecord,
      ),
    );

    if (record != null) {
      if (recordIndex == null) {
        MedicalTrackingController.instance.addRecord(record);
      } else {
        MedicalTrackingController.instance.updateRecord(recordIndex, record);
      }
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
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textColor = theme.colorScheme.onSurface;
    final secondaryColor = theme.textTheme.bodySmall?.color ?? Colors.grey;
    final controller = MedicalTrackingController.instance;

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
                    animation: controller,
                    builder: (context, _) {
                      return ListView.builder(
                        padding: const EdgeInsets.fromLTRB(18, 18, 18, 22),
                        itemCount: controller.records.length + 1,
                        itemBuilder: (context, index) {
                          if (index == 0) {
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                _HealthLevelCard(
                                  dailyHealthLevel: controller.dailyHealthLevel,
                                ),
                                const SizedBox(height: 16),
                                PrimaryButton(
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

                          final record = controller.records[index - 1];
                          return _MedicalRecordCard(
                            record: record,
                            onTap: () => _showRecordSheet(
                              context,
                              initialRecord: record,
                              recordIndex: index - 1,
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

class _HealthLevelCard extends StatelessWidget {
  const _HealthLevelCard({required this.dailyHealthLevel});

  final double dailyHealthLevel;

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
                '${dailyHealthLevel.toStringAsFixed(1)}/5',
                style: TextStyle(
                  color: textColor,
                  fontSize: 34,
                  fontWeight: FontWeight.w900,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
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

class _MedicalRecordCard extends StatelessWidget {
  const _MedicalRecordCard({
    required this.record,
    required this.onTap,
  });

  final MedicalRecord record;
  final VoidCallback onTap;

  Color _impactColor() {
    return switch (record.impact) {
      MedicalImpact.positive => const Color(0xFF2DBE78),
      MedicalImpact.attention => const Color(0xFFFF9800),
      MedicalImpact.critical => const Color(0xFFFF3B3B),
      MedicalImpact.neutral => SomaColors.primaryBlue,
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

class _AddMedicalRecordSheet extends StatefulWidget {
  const _AddMedicalRecordSheet({this.initialRecord});

  final MedicalRecord? initialRecord;

  @override
  State<_AddMedicalRecordSheet> createState() => _AddMedicalRecordSheetState();
}

class _AddMedicalRecordSheetState extends State<_AddMedicalRecordSheet> {
  final _descriptionController = TextEditingController();
  final _detailController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  late String _type;
  late MedicalImpact _impact;

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
    _impact = initialRecord?.impact ?? MedicalImpact.neutral;
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
      MedicalRecord(
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
                'Adicionar registro',
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
              CustomTextField(
                controller: _descriptionController,
                hintText: 'Descrição do registro',
                validator: _required,
                contentVerticalPadding: 12,
              ),
              const SizedBox(height: 12),
              CustomTextField(
                controller: _detailController,
                hintText: 'Observação opcional',
                contentVerticalPadding: 12,
              ),
              const SizedBox(height: 12),
              DropdownButtonFormField<MedicalImpact>(
                initialValue: _impact,
                dropdownColor: theme.cardColor,
                decoration: const InputDecoration(labelText: 'Impacto'),
                items: MedicalImpact.values
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
              PrimaryButton(
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

  String _impactLabel(MedicalImpact impact) {
    return switch (impact) {
      MedicalImpact.positive => 'positivo',
      MedicalImpact.attention => 'atenção',
      MedicalImpact.critical => 'crítico',
      MedicalImpact.neutral => 'neutro',
    };
  }
}
