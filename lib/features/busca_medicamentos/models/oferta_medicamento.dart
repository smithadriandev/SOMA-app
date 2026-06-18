class OfertaMedicamento {
  const OfertaMedicamento({
    required this.medicineName,
    required this.pharmacyName,
    required this.price,
    required this.address,
    required this.latitude,
    required this.longitude,
    required this.priority,
  });

  final String medicineName;
  final String pharmacyName;
  final double price;
  final String address;
  final double latitude;
  final double longitude;
  final PrioridadeMedicamento priority;

  String get priorityLabel {
    return switch (priority) {
      PrioridadeMedicamento.high => 'Alta prioridade',
      PrioridadeMedicamento.medium => 'M\u00E9dia prioridade',
      PrioridadeMedicamento.low => 'Baixa prioridade',
    };
  }
}

enum PrioridadeMedicamento {
  high,
  medium,
  low,
}
