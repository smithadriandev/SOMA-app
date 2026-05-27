import 'package:flutter/foundation.dart';

import '../models/medical_record.dart';

class MedicalTrackingController extends ChangeNotifier {
  MedicalTrackingController._();

  static final MedicalTrackingController instance =
      MedicalTrackingController._();

  final List<MedicalRecord> _records = [
    const MedicalRecord(
      dateTimeText: 'Hoje - 08:00',
      type: 'Medicamento',
      description: 'Remédio da manhã tomado corretamente',
      impact: MedicalImpact.positive,
    ),
    const MedicalRecord(
      dateTimeText: 'Hoje - 10:30',
      type: 'Humor',
      description: 'Paciente ficou calmo e comunicativo',
      impact: MedicalImpact.positive,
    ),
    const MedicalRecord(
      dateTimeText: 'Hoje - 12:15',
      type: 'Alimentação',
      description: 'Almoçou bem e bebeu água',
      impact: MedicalImpact.positive,
    ),
    const MedicalRecord(
      dateTimeText: 'Ontem - 22:00',
      type: 'Sono',
      description: 'Acordou duas vezes durante a noite',
      impact: MedicalImpact.attention,
    ),
    const MedicalRecord(
      dateTimeText: 'Ontem - 16:40',
      type: 'Sintoma',
      description: 'Apresentou leve confusão mental',
      impact: MedicalImpact.attention,
    ),
  ];

  double _dailyHealthLevel = 3.5;

  List<MedicalRecord> get records => List.unmodifiable(_records);

  double get dailyHealthLevel => _dailyHealthLevel;

  String get dailyHealthLevelText => _dailyHealthLevel.toStringAsFixed(1);

  void addRecord(MedicalRecord record) {
    _records.insert(0, record);
    notifyListeners();
  }

  void updateRecord(int index, MedicalRecord record) {
    if (index < 0 || index >= _records.length) {
      return;
    }

    _records[index] = record;
    notifyListeners();
  }

  void removeRecord(int index) {
    if (index < 0 || index >= _records.length) {
      return;
    }

    _records.removeAt(index);
    notifyListeners();
  }

  void updateDailyHealthLevel(double value) {
    final nextValue = value.clamp(0.0, 5.0).toDouble();
    if (_dailyHealthLevel == nextValue) {
      return;
    }

    _dailyHealthLevel = nextValue;
    notifyListeners();
  }
}