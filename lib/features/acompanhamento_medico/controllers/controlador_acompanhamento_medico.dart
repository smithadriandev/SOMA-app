import 'package:flutter/foundation.dart';

import '../models/registro_medico.dart';

class ControladorAcompanhamentoMedico extends ChangeNotifier {
  ControladorAcompanhamentoMedico._();

  static final ControladorAcompanhamentoMedico instance =
      ControladorAcompanhamentoMedico._();

  final List<RegistroMedico> _registros = [
    const RegistroMedico(
      dateTimeText: 'Hoje - 08:00',
      type: 'Medicamento',
      description: 'Remédio da manhã tomado corretamente',
      impact: ImpactoMedico.positive,
    ),
    const RegistroMedico(
      dateTimeText: 'Hoje - 10:30',
      type: 'Humor',
      description: 'Paciente ficou calmo e comunicativo',
      impact: ImpactoMedico.positive,
    ),
    const RegistroMedico(
      dateTimeText: 'Hoje - 12:15',
      type: 'Alimentação',
      description: 'Almoçou bem e bebeu água',
      impact: ImpactoMedico.positive,
    ),
    const RegistroMedico(
      dateTimeText: 'Ontem - 22:00',
      type: 'Sono',
      description: 'Acordou duas vezes durante a noite',
      impact: ImpactoMedico.attention,
    ),
    const RegistroMedico(
      dateTimeText: 'Ontem - 16:40',
      type: 'Sintoma',
      description: 'Apresentou leve confusão mental',
      impact: ImpactoMedico.attention,
    ),
  ];

  double _nivelSaudeDia = 3.5;

  List<RegistroMedico> get registros => List.unmodifiable(_registros);

  double get nivelSaudeDia => _nivelSaudeDia;

  String get textoNivelSaudeDia => _nivelSaudeDia.toStringAsFixed(1);

  void adicionarRegistro(RegistroMedico record) {
    _registros.insert(0, record);
    notifyListeners();
  }

  void atualizarRegistro(int index, RegistroMedico record) {
    if (index < 0 || index >= _registros.length) {
      return;
    }

    _registros[index] = record;
    notifyListeners();
  }

  void removerRegistro(int index) {
    if (index < 0 || index >= _registros.length) {
      return;
    }

    _registros.removeAt(index);
    notifyListeners();
  }

  void atualizarNivelSaudeDia(double value) {
    final nextValue = value.clamp(0.0, 5.0).toDouble();
    if (_nivelSaudeDia == nextValue) {
      return;
    }

    _nivelSaudeDia = nextValue;
    notifyListeners();
  }
}