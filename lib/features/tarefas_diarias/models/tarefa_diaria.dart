import 'package:flutter/material.dart';

class TarefaDiaria {
  TarefaDiaria({
    required this.title,
    required this.category,
    required this.time,
    required this.isCompleted,
    required this.icon,
    this.description,
  });

  static const defaultDescription =
      'Essa tarefa ajuda a manter a rotina di\u00E1ria do paciente organizada.';

  final String title;
  final String category;
  final String time;
  final bool isCompleted;
  final IconData icon;
  final String? description;

  String get descriptionText => description ?? defaultDescription;

  TarefaDiaria copyWith({
    String? title,
    String? category,
    String? time,
    bool? isCompleted,
    IconData? icon,
    String? description,
  }) {
    return TarefaDiaria(
      title: title ?? this.title,
      category: category ?? this.category,
      time: time ?? this.time,
      isCompleted: isCompleted ?? this.isCompleted,
      icon: icon ?? this.icon,
      description: description ?? this.description,
    );
  }
}
