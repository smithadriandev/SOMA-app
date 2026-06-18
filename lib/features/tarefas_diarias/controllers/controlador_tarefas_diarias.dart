import 'package:flutter/foundation.dart';

import '../mock/mock_tarefas_diarias.dart';
import '../models/tarefa_diaria.dart';

class ControladorTarefasDiarias extends ChangeNotifier {
  ControladorTarefasDiarias._() : _tarefas = MockTarefasDiarias.initialTasks() {
    _ordenarPorHorario();
  }

  static final ControladorTarefasDiarias instance =
      ControladorTarefasDiarias._();

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

  void atualizarTarefa(int index, TarefaDiaria tarefaAtualizada) {
    if (index < 0 || index >= _tarefas.length) {
      return;
    }

    _tarefas[index] = tarefaAtualizada;
    _ordenarPorHorario();
    notifyListeners();
  }

  void _ordenarPorHorario() {
    _tarefas.sort((a, b) {
      final compareTime =
          _minutosDoDia(a.time).compareTo(_minutosDoDia(b.time));
      if (compareTime != 0) {
        return compareTime;
      }

      return a.title.compareTo(b.title);
    });
  }

  int _minutosDoDia(String time) {
    final match = RegExp(r'^(\d{1,2}):(\d{2})').firstMatch(time.trim());
    if (match == null) {
      return 24 * 60;
    }

    final hour = int.tryParse(match.group(1) ?? '') ?? 24;
    final minute = int.tryParse(match.group(2) ?? '') ?? 0;

    return hour.clamp(0, 23) * 60 + minute.clamp(0, 59);
  }
}
