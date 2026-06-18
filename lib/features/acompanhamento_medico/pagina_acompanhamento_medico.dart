import 'package:flutter/material.dart';

import '../../app/theme.dart';
import '../../shared/widgets/campo_texto_customizado.dart';
import '../../shared/widgets/botao_principal.dart';
import 'controllers/controlador_acompanhamento_medico.dart';
import 'models/registro_medico.dart';

class PaginaAcompanhamentoMedico extends StatelessWidget {
  const PaginaAcompanhamentoMedico({super.key});

  ControladorAcompanhamentoMedico get _controller =>
      ControladorAcompanhamentoMedico.instance;

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
    final secondaryColor = theme.textTheme.bodySmall?.color ?? textColor;

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
                          'Acompanhamento m\u00E9dico',
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
                                  'Acompanhe sa\u00FAde, rotina e comportamento de forma simples.',
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
  const _CardNivelSaude({required this.nivelSaudeDia});

  final double nivelSaudeDia;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textColor = theme.colorScheme.onSurface;
    final secondaryColor = theme.textTheme.bodySmall?.color ?? textColor;
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
            'N\u00EDvel de sa\u00FAde do dia',
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
            'O n\u00EDvel de sa\u00FAde \u00E9 calculado automaticamente com base nos registros do dia.',
            style: TextStyle(
              color: secondaryColor,
              fontSize: 13,
              fontWeight: FontWeight.w700,
              height: 1.35,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            'Baseado nos registros de humor, sono, alimenta\u00E7\u00E3o e medica\u00E7\u00E3o.',
            style: TextStyle(
              color: secondaryColor,
              fontSize: 13,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Este indicador \u00E9 apenas um acompanhamento di\u00E1rio e n\u00E3o substitui avalia\u00E7\u00E3o m\u00E9dica.',
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
    final secondaryColor = theme.textTheme.bodySmall?.color ?? textColor;
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
                      '${record.dateTimeText} \u2022 ${record.type}',
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
  State<_AddRegistroMedicoSheet> createState() =>
      _AddRegistroMedicoSheetState();
}

class _AddRegistroMedicoSheetState extends State<_AddRegistroMedicoSheet> {
  final _formKey = GlobalKey<FormState>();

  final _nomeRemedioController = TextEditingController();
  final _doseController = TextEditingController();
  final _horarioController = TextEditingController();
  final _observacaoMedicamentoController = TextEditingController();
  final _observacaoHumorController = TextEditingController();
  final _horasSonoController = TextEditingController();
  final _observacaoSonoController = TextEditingController();
  final _observacaoAlimentacaoController = TextEditingController();
  final _observacaoSintomaController = TextEditingController();
  final _nomeMedicoController = TextEditingController();
  final _especialidadeController = TextEditingController();
  final _dataConsultaController = TextEditingController();
  final _observacaoConsultaController = TextEditingController();
  final _pressaoController = TextEditingController();
  final _batimentosController = TextEditingController();
  final _temperaturaController = TextEditingController();
  final _glicemiaController = TextEditingController();
  final _observacaoSinaisController = TextEditingController();

  late String _type;
  late ImpactoMedico _impact;

  String? _foiTomado = 'Sim';
  String? _estadoEmocional = 'Calmo';
  String? _qualidadeSono = 'Dormiu bem';
  String? _alimentacao = 'Comeu bem';
  String? _bebeuAgua = 'Sim';
  String? _sintoma = 'Confus\u00E3o mental';
  String? _intensidade = 'Leve';

  final _types = const [
    'Medicamento',
    'Humor',
    'Sono',
    'Alimenta\u00E7\u00E3o',
    'Sintoma',
    'Consulta',
    'Sinais vitais',
  ];

  @override
  void initState() {
    super.initState();
    final initialRecord = widget.initialRecord;
    _type = initialRecord?.type ?? 'Medicamento';
    _impact = initialRecord?.impact ?? _impactoSugerido();

    if (initialRecord != null) {
      _preencherObservacaoDaEdicao(initialRecord.description);
    }
  }

  void _preencherObservacaoDaEdicao(String description) {
    switch (_type) {
      case 'Medicamento':
        _observacaoMedicamentoController.text = description;
      case 'Humor':
        _observacaoHumorController.text = description;
      case 'Sono':
        _observacaoSonoController.text = description;
      case 'Alimenta\u00E7\u00E3o':
        _observacaoAlimentacaoController.text = description;
      case 'Sintoma':
        _observacaoSintomaController.text = description;
      case 'Consulta':
        _observacaoConsultaController.text = description;
      case 'Sinais vitais':
        _observacaoSinaisController.text = description;
    }
  }

  @override
  void dispose() {
    for (final controller in [
      _nomeRemedioController,
      _doseController,
      _horarioController,
      _observacaoMedicamentoController,
      _observacaoHumorController,
      _horasSonoController,
      _observacaoSonoController,
      _observacaoAlimentacaoController,
      _observacaoSintomaController,
      _nomeMedicoController,
      _especialidadeController,
      _dataConsultaController,
      _observacaoConsultaController,
      _pressaoController,
      _batimentosController,
      _temperaturaController,
      _glicemiaController,
      _observacaoSinaisController,
    ]) {
      controller.dispose();
    }
    super.dispose();
  }

  String? _required(String? value) {
    if ((value ?? '').trim().isEmpty) {
      return 'Campo obrigat\u00F3rio';
    }
    return null;
  }

  void _atualizarImpactoSugerido() {
    setState(() => _impact = _impactoSugerido());
  }

  ImpactoMedico _impactoSugerido() {
    return switch (_type) {
      'Medicamento' => _foiTomado == 'N\u00E3o'
          ? ImpactoMedico.attention
          : ImpactoMedico.positive,
      'Humor' => ['Calmo', 'Alegre'].contains(_estadoEmocional)
          ? ImpactoMedico.positive
          : ImpactoMedico.attention,
      'Sono' => _qualidadeSono == 'Dormiu bem'
          ? ImpactoMedico.positive
          : ImpactoMedico.attention,
      'Alimenta\u00E7\u00E3o' =>
        _alimentacao == 'Comeu bem' && _bebeuAgua == 'Sim'
            ? ImpactoMedico.positive
            : ImpactoMedico.attention,
      'Sintoma' => _intensidade == 'Forte'
          ? ImpactoMedico.critical
          : ImpactoMedico.attention,
      'Consulta' => ImpactoMedico.neutral,
      'Sinais vitais' => ImpactoMedico.neutral,
      _ => ImpactoMedico.neutral,
    };
  }

  bool _sinaisVitaisTemValor() {
    return [
      _pressaoController,
      _batimentosController,
      _temperaturaController,
      _glicemiaController,
    ].any((controller) => controller.text.trim().isNotEmpty);
  }

  String _montarDescricao() {
    switch (_type) {
      case 'Medicamento':
        return _juntarPartes([
          'Rem\u00E9dio: ${_nomeRemedioController.text.trim()}',
          'Dose: ${_doseController.text.trim()}',
          'Hor\u00E1rio: ${_horarioController.text.trim()}',
          'Tomado: $_foiTomado',
          _observacaoMedicamentoController.text.trim().isEmpty
              ? null
              : 'Observa\u00E7\u00E3o: ${_observacaoMedicamentoController.text.trim()}',
        ]);
      case 'Humor':
        return _juntarPartes([
          'Estado emocional: $_estadoEmocional',
          _observacaoHumorController.text.trim().isEmpty
              ? null
              : 'Observa\u00E7\u00E3o: ${_observacaoHumorController.text.trim()}',
        ], separator: '. ');
      case 'Sono':
        return _juntarPartes([
          'Sono: $_qualidadeSono',
          _horasSonoController.text.trim().isEmpty
              ? null
              : 'Horas: ${_horasSonoController.text.trim()}h',
          _observacaoSonoController.text.trim().isEmpty
              ? null
              : 'Observa\u00E7\u00E3o: ${_observacaoSonoController.text.trim()}',
        ]);
      case 'Alimenta\u00E7\u00E3o':
        return _juntarPartes([
          'Alimenta\u00E7\u00E3o: $_alimentacao',
          'Bebeu \u00E1gua: $_bebeuAgua',
          _observacaoAlimentacaoController.text.trim().isEmpty
              ? null
              : 'Observa\u00E7\u00E3o: ${_observacaoAlimentacaoController.text.trim()}',
        ]);
      case 'Sintoma':
        return _juntarPartes([
          'Sintoma: $_sintoma',
          'Intensidade: $_intensidade',
          _observacaoSintomaController.text.trim().isEmpty
              ? null
              : 'Observa\u00E7\u00E3o: ${_observacaoSintomaController.text.trim()}',
        ]);
      case 'Consulta':
        return _juntarPartes([
          'Consulta com Dr(a). ${_nomeMedicoController.text.trim()}',
          'Especialidade: ${_especialidadeController.text.trim()}',
          'Data: ${_dataConsultaController.text.trim()}',
          _observacaoConsultaController.text.trim().isEmpty
              ? null
              : 'Observa\u00E7\u00F5es: ${_observacaoConsultaController.text.trim()}',
        ]);
      case 'Sinais vitais':
        return _juntarPartes([
          _pressaoController.text.trim().isEmpty
              ? null
              : 'Press\u00E3o: ${_pressaoController.text.trim()}',
          _batimentosController.text.trim().isEmpty
              ? null
              : 'Batimentos: ${_batimentosController.text.trim()} bpm',
          _temperaturaController.text.trim().isEmpty
              ? null
              : 'Temperatura: ${_temperaturaController.text.trim()}\u00B0C',
          _glicemiaController.text.trim().isEmpty
              ? null
              : 'Glicemia: ${_glicemiaController.text.trim()}',
          _observacaoSinaisController.text.trim().isEmpty
              ? null
              : 'Observa\u00E7\u00E3o: ${_observacaoSinaisController.text.trim()}',
        ]);
      default:
        return '';
    }
  }

  String _juntarPartes(List<String?> partes, {String separator = ' | '}) {
    return partes
        .whereType<String>()
        .where((part) => part.trim().isNotEmpty)
        .join(separator);
  }

  String _horaAgoraTexto() {
    final now = DateTime.now();
    final hour = now.hour.toString().padLeft(2, '0');
    final minute = now.minute.toString().padLeft(2, '0');
    return 'Hoje - $hour:$minute';
  }

  void _save() {
    final formValido = _formKey.currentState!.validate();
    final sinaisValidos = _type != 'Sinais vitais' || _sinaisVitaisTemValor();

    if (!formValido || !sinaisValidos) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Preencha os campos obrigat\u00F3rios')),
      );
      return;
    }

    Navigator.pop(
      context,
      RegistroMedico(
        dateTimeText: widget.initialRecord?.dateTimeText ?? _horaAgoraTexto(),
        type: _type,
        description: _montarDescricao(),
        impact: _impact,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textColor = theme.colorScheme.onSurface;
    final secondaryColor = theme.textTheme.bodySmall?.color ?? textColor;
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
              const SizedBox(height: 6),
              Text(
                'Escolha o tipo para ver os campos corretos.',
                style: TextStyle(
                  color: secondaryColor,
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 14),
              _DropdownCampo<String>(
                label: 'Tipo de registro',
                value: _type,
                items: _types,
                itemLabel: (value) => value,
                onChanged: (value) {
                  if (value == null) return;
                  setState(() {
                    _type = value;
                    _impact = _impactoSugerido();
                  });
                },
              ),
              const SizedBox(height: 14),
              ..._camposDoTipo(),
              const SizedBox(height: 12),
              _ImpactoAutomaticoInfo(impactLabel: _impactLabel(_impact)),
              const SizedBox(height: 12),
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
                      text: 'Salvar registro',
                      height: 48,
                      fontSize: 15,
                      onPressed: _save,
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

  List<Widget> _camposDoTipo() {
    return switch (_type) {
      'Medicamento' => [
          _campoTexto(
              _nomeRemedioController, 'Nome do rem\u00E9dio', _required),
          _espacoCampo(),
          _campoTexto(_doseController, 'Dose', _required),
          _espacoCampo(),
          _campoTexto(_horarioController, 'Hor\u00E1rio', _required),
          _espacoCampo(),
          _DropdownCampo<String>(
            label: 'Foi tomado?',
            value: _foiTomado,
            items: const ['Sim', 'N\u00E3o'],
            itemLabel: (value) => value,
            onChanged: (value) {
              setState(() => _foiTomado = value);
              _atualizarImpactoSugerido();
            },
          ),
          _espacoCampo(),
          _campoTexto(
            _observacaoMedicamentoController,
            'Observa\u00E7\u00E3o opcional',
            null,
          ),
        ],
      'Humor' => [
          _DropdownCampo<String>(
            label: 'Estado emocional',
            value: _estadoEmocional,
            items: const [
              'Calmo',
              'Alegre',
              'Ansioso',
              'Irritado',
              'Triste',
              'Confuso',
            ],
            itemLabel: (value) => value,
            onChanged: (value) {
              setState(() => _estadoEmocional = value);
              _atualizarImpactoSugerido();
            },
          ),
          _espacoCampo(),
          _campoTexto(_observacaoHumorController,
              'Observa\u00E7\u00E3o opcional', null),
        ],
      'Sono' => [
          _DropdownCampo<String>(
            label: 'Qualidade do sono',
            value: _qualidadeSono,
            items: const [
              'Dormiu bem',
              'Dormiu pouco',
              'Acordou durante a noite',
              'Ins\u00F4nia',
            ],
            itemLabel: (value) => value,
            onChanged: (value) {
              setState(() => _qualidadeSono = value);
              _atualizarImpactoSugerido();
            },
          ),
          _espacoCampo(),
          _campoTexto(_horasSonoController, 'Horas dormidas', null),
          _espacoCampo(),
          _campoTexto(
              _observacaoSonoController, 'Observa\u00E7\u00E3o opcional', null),
        ],
      'Alimenta\u00E7\u00E3o' => [
          _DropdownCampo<String>(
            label: 'Alimenta\u00E7\u00E3o',
            value: _alimentacao,
            items: const ['Comeu bem', 'Comeu pouco', 'N\u00E3o quis comer'],
            itemLabel: (value) => value,
            onChanged: (value) {
              setState(() => _alimentacao = value);
              _atualizarImpactoSugerido();
            },
          ),
          _espacoCampo(),
          _DropdownCampo<String>(
            label: 'Bebeu \u00E1gua?',
            value: _bebeuAgua,
            items: const ['Sim', 'N\u00E3o'],
            itemLabel: (value) => value,
            onChanged: (value) {
              setState(() => _bebeuAgua = value);
              _atualizarImpactoSugerido();
            },
          ),
          _espacoCampo(),
          _campoTexto(
            _observacaoAlimentacaoController,
            'Observa\u00E7\u00E3o opcional',
            null,
          ),
        ],
      'Sintoma' => [
          _DropdownCampo<String>(
            label: 'Sintoma',
            value: _sintoma,
            items: const [
              'Confus\u00E3o mental',
              'Agita\u00E7\u00E3o',
              'Esquecimento',
              'Tontura',
              'Sonol\u00EAncia',
              'Dor',
            ],
            itemLabel: (value) => value,
            onChanged: (value) => setState(() => _sintoma = value),
          ),
          _espacoCampo(),
          _DropdownCampo<String>(
            label: 'Intensidade',
            value: _intensidade,
            items: const ['Leve', 'Moderada', 'Forte'],
            itemLabel: (value) => value,
            onChanged: (value) {
              setState(() => _intensidade = value);
              _atualizarImpactoSugerido();
            },
          ),
          _espacoCampo(),
          _campoTexto(_observacaoSintomaController,
              'Observa\u00E7\u00E3o opcional', null),
        ],
      'Consulta' => [
          _campoTexto(_nomeMedicoController, 'Nome do m\u00E9dico', _required),
          _espacoCampo(),
          _campoTexto(_especialidadeController, 'Especialidade', _required),
          _espacoCampo(),
          _campoTexto(_dataConsultaController, 'Data da consulta', _required),
          _espacoCampo(),
          _campoTexto(
              _observacaoConsultaController, 'Observa\u00E7\u00F5es', null),
        ],
      'Sinais vitais' => [
          _campoTexto(_pressaoController, 'Press\u00E3o arterial', null),
          _espacoCampo(),
          _campoTexto(_batimentosController, 'Batimentos card\u00EDacos', null),
          _espacoCampo(),
          _campoTexto(_temperaturaController, 'Temperatura', null),
          _espacoCampo(),
          _campoTexto(_glicemiaController, 'Glicemia', null),
          _espacoCampo(),
          _campoTexto(_observacaoSinaisController,
              'Observa\u00E7\u00E3o opcional', null),
        ],
      _ => const [],
    };
  }

  Widget _campoTexto(
    TextEditingController controller,
    String hint,
    String? Function(String?)? validator,
  ) {
    return CampoTextoCustomizado(
      controller: controller,
      hintText: hint,
      validator: validator,
      contentVerticalPadding: 12,
    );
  }

  Widget _espacoCampo() => const SizedBox(height: 12);

  String _impactLabel(ImpactoMedico impact) {
    return switch (impact) {
      ImpactoMedico.positive => 'positivo',
      ImpactoMedico.attention => 'aten\u00E7\u00E3o',
      ImpactoMedico.critical => 'cr\u00EDtico',
      ImpactoMedico.neutral => 'neutro',
    };
  }
}

class _ImpactoAutomaticoInfo extends StatelessWidget {
  const _ImpactoAutomaticoInfo({required this.impactLabel});

  final String impactLabel;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textColor = theme.colorScheme.onSurface;
    final secondaryColor = theme.textTheme.bodySmall?.color ?? textColor;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: theme.inputDecorationTheme.fillColor ?? theme.cardColor,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: theme.dividerColor),
      ),
      child: Text(
        'Impacto definido automaticamente: $impactLabel',
        style: TextStyle(
          color: secondaryColor,
          fontSize: 13,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }
}

class _DropdownCampo<T> extends StatelessWidget {
  const _DropdownCampo({
    required this.label,
    required this.value,
    required this.items,
    required this.itemLabel,
    required this.onChanged,
  });

  final String label;
  final T? value;
  final List<T> items;
  final String Function(T value) itemLabel;
  final ValueChanged<T?> onChanged;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return DropdownButtonFormField<T>(
      initialValue: value,
      dropdownColor: theme.cardColor,
      decoration: InputDecoration(labelText: label),
      validator: (value) => value == null ? 'Campo obrigat\u00F3rio' : null,
      items: items
          .map(
            (item) => DropdownMenuItem<T>(
              value: item,
              child: Text(itemLabel(item)),
            ),
          )
          .toList(),
      onChanged: onChanged,
    );
  }
}
