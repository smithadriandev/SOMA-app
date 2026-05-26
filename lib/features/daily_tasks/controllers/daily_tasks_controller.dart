import 'package:flutter/foundation.dart';

import '../mock/mock_daily_tasks.dart';
import '../models/daily_task.dart';

class DailyTasksController extends ChangeNotifier {
  DailyTasksController._() : _tasks = MockDailyTasks.initialTasks();

  static final DailyTasksController instance = DailyTasksController._();

  final List<DailyTask> _tasks;

  List<DailyTask> get tasks => List.unmodifiable(_tasks);

  int get completedCount => _tasks.where((task) => task.isCompleted).length;

  int get totalCount => _tasks.length;

  double get progress {
    if (_tasks.isEmpty) {
      return 0;
    }

    return completedCount / totalCount;
  }

  int get progressPercent => (progress * 100).round();

  void toggleTask(int index) {
    if (index < 0 || index >= _tasks.length) {
      return;
    }

    final task = _tasks[index];
    _tasks[index] = task.copyWith(isCompleted: !task.isCompleted);
    notifyListeners();
  }
}
