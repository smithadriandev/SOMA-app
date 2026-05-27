import 'package:flutter/material.dart';

enum ImpactoMedico {
  positive,
  attention,
  critical,
  neutral,
}

class RegistroMedico {
  const RegistroMedico({
    required this.dateTimeText,
    required this.type,
    required this.description,
    required this.impact,
  });

  final String dateTimeText;
  final String type;
  final String description;
  final ImpactoMedico impact;

  RegistroMedico copyWith({
    String? dateTimeText,
    String? type,
    String? description,
    ImpactoMedico? impact,
  }) {
    return RegistroMedico(
      dateTimeText: dateTimeText ?? this.dateTimeText,
      type: type ?? this.type,
      description: description ?? this.description,
      impact: impact ?? this.impact,
    );
  }

  String get impactLabel {
    return switch (impact) {
      ImpactoMedico.positive => 'positivo',
      ImpactoMedico.attention => 'atenção',
      ImpactoMedico.critical => 'crítico',
      ImpactoMedico.neutral => 'neutro',
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