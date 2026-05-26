import 'package:flutter/material.dart';

enum MedicalImpact {
  positive,
  attention,
  critical,
  neutral,
}

class MedicalRecord {
  const MedicalRecord({
    required this.dateTimeText,
    required this.type,
    required this.description,
    required this.impact,
  });

  final String dateTimeText;
  final String type;
  final String description;
  final MedicalImpact impact;

  String get impactLabel {
    return switch (impact) {
      MedicalImpact.positive => 'positivo',
      MedicalImpact.attention => 'atenção',
      MedicalImpact.critical => 'crítico',
      MedicalImpact.neutral => 'neutro',
    };
  }

  IconData get icon {
    return switch (type) {
      'Medicamento' => Icons.medication_outlined,
      'Sintoma' => Icons.sick_outlined,
      'Humor' => Icons.mood_outlined,
      'Sono' => Icons.bedtime_outlined,
      'Alimentação' => Icons.restaurant_outlined,
      'Sinais vitais' => Icons.monitor_heart_outlined,
      'Consulta' => Icons.event_note_outlined,
      _ => Icons.health_and_safety_outlined,
    };
  }
}
