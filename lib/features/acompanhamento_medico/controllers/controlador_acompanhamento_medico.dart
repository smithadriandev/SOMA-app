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
      description: 'Rem\u00E9dio da manh\u00E3 tomado corretamente',
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
      type: 'Alimenta\u00E7\u00E3o',
      description: 'Almo\u00E7ou bem e bebeu \u00E1gua',
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
      description: 'Apresentou leve confus\u00E3o mental',
      impact: ImpactoMedico.attention,
    ),
  ];

  List<RegistroMedico> get registros => List.unmodifiable(_registros);

  double get nivelSaudeDia => _calcularNivelSaudeDia();

  String get textoNivelSaudeDia => nivelSaudeDia.toStringAsFixed(1);

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

  double _calcularNivelSaudeDia() {
    var nivel = 5.0;

    for (final registro in _registros) {
      nivel -= switch (registro.impact) {
        ImpactoMedico.positive => 0.0,
        ImpactoMedico.neutral => 0.1,
        ImpactoMedico.attention => 0.4,
        ImpactoMedico.critical => 0.8,
      };
    }

    return nivel.clamp(0.0, 5.0).toDouble();
  }
}
