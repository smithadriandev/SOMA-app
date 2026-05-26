import 'package:flutter/foundation.dart';

import '../mock/mock_medical_records.dart';
import '../models/medical_record.dart';

class MedicalTrackingController extends ChangeNotifier {
  MedicalTrackingController._()
      : _records = MockMedicalRecords.initialRecords(),
        _dailyHealthLevel = 3.5;

  static final MedicalTrackingController instance =
      MedicalTrackingController._();

  final List<MedicalRecord> _records;
  double _dailyHealthLevel;

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

  void updateDailyHealthLevel(double value) {
    _dailyHealthLevel = value.clamp(0.0, 5.0);
    notifyListeners();
  }
}
