import 'package:flutter/foundation.dart';

import '../mock/mock_tarefas_diarias.dart';
import '../models/tarefa_diaria.dart';

class ControladorTarefasDiarias extends ChangeNotifier {
  ControladorTarefasDiarias._() : _tarefas = MockTarefasDiarias.initialTasks();

  static final ControladorTarefasDiarias instance = ControladorTarefasDiarias._();

  final List<TarefaDiaria> _tarefas;

  List<TarefaDiaria> get tarefas => List.unmodifiable(_tarefas);

  int get totalConcluidas => _tarefas.where((task) => task.isCompleted).length;

  int get totalTarefas => _tarefas.length;

  double get progresso {
    if (_tarefas.isEmpty) {
      return 0;
    }

    return totalConcluidas / totalTarefas;
  }

  int get percentualProgresso => (progresso * 100).round();

  void alternarTarefa(int index) {
    if (index < 0 || index >= _tarefas.length) {
      return;
    }

    final task = _tarefas[index];
    _tarefas[index] = task.copyWith(isCompleted: !task.isCompleted);
    notifyListeners();
  }
}
