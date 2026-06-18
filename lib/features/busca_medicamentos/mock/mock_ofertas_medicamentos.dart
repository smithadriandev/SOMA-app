import '../models/oferta_medicamento.dart';

class MockOfertasMedicamentos {
  static const medicamentosComuns = [
    'Dipirona',
    'Paracetamol',
    'Losartana',
    'Omeprazol',
    'Metformina',
  ];

  static const ofertas = [
    OfertaMedicamento(
      medicineName: 'Dipirona 500mg',
      pharmacyName: 'Drogasil',
      price: 70.99,
      address: 'Av. Murilo Dantas, 450',
      latitude: -10.9492,
      longitude: -37.0712,
      priority: PrioridadeMedicamento.low,
    ),
    OfertaMedicamento(
      medicineName: 'Dipirona 500mg',
      pharmacyName: 'Pague Menos',
      price: 75.00,
      address: 'Av. Dr. Jos\u00E9 Tomaz D\u2019\u00C1vila Nabuco, 900',
      latitude: -10.9479,
      longitude: -37.0698,
      priority: PrioridadeMedicamento.low,
    ),
    OfertaMedicamento(
      medicineName: 'Dipirona 500mg',
      pharmacyName: 'Farm\u00E1cia Popular',
      price: 79.90,
      address: 'Rua Projetada, 120 - Farol\u00E2ndia',
      latitude: -10.9501,
      longitude: -37.0689,
      priority: PrioridadeMedicamento.low,
    ),
    OfertaMedicamento(
      medicineName: 'Paracetamol 750mg',
      pharmacyName: 'Farm\u00E1cia Popular',
      price: 12.50,
      address: 'Rua Projetada, 120 - Farol\u00E2ndia',
      latitude: -10.9501,
      longitude: -37.0689,
      priority: PrioridadeMedicamento.low,
    ),
    OfertaMedicamento(
      medicineName: 'Paracetamol 750mg',
      pharmacyName: 'Drogaria Sa\u00FAde',
      price: 14.90,
      address: 'Av. Murilo Dantas, 195',
      latitude: -10.9468,
      longitude: -37.0715,
      priority: PrioridadeMedicamento.low,
    ),
    OfertaMedicamento(
      medicineName: 'Losartana 50mg',
      pharmacyName: 'Farma Vida',
      price: 22.00,
      address: 'Av. Murilo Dantas, 450',
      latitude: -10.9492,
      longitude: -37.0712,
      priority: PrioridadeMedicamento.high,
    ),
    OfertaMedicamento(
      medicineName: 'Losartana 50mg',
      pharmacyName: 'Drogasil',
      price: 24.90,
      address: 'Av. Dr. Jos\u00E9 Tomaz D\u2019\u00C1vila Nabuco, 900',
      latitude: -10.9479,
      longitude: -37.0698,
      priority: PrioridadeMedicamento.high,
    ),
    OfertaMedicamento(
      medicineName: 'Omeprazol 20mg',
      pharmacyName: 'Drogaria Central',
      price: 18.99,
      address: 'Av. Murilo Dantas, 195',
      latitude: -10.9468,
      longitude: -37.0715,
      priority: PrioridadeMedicamento.medium,
    ),
    OfertaMedicamento(
      medicineName: 'Omeprazol 20mg',
      pharmacyName: 'Pague Menos',
      price: 21.50,
      address: 'Av. Dr. Jos\u00E9 Tomaz D\u2019\u00C1vila Nabuco, 900',
      latitude: -10.9479,
      longitude: -37.0698,
      priority: PrioridadeMedicamento.medium,
    ),
    OfertaMedicamento(
      medicineName: 'Metformina 850mg',
      pharmacyName: 'Farm\u00E1cia Popular',
      price: 15.50,
      address: 'Rua Projetada, 120 - Farol\u00E2ndia',
      latitude: -10.9501,
      longitude: -37.0689,
      priority: PrioridadeMedicamento.high,
    ),
    OfertaMedicamento(
      medicineName: 'Metformina 850mg',
      pharmacyName: 'Drogasil',
      price: 16.90,
      address: 'Av. Murilo Dantas, 450',
      latitude: -10.9492,
      longitude: -37.0712,
      priority: PrioridadeMedicamento.high,
    ),
  ];

  static List<OfertaMedicamento> buscarOfertas(String query) {
    final normalizedQuery = query.toLowerCase().trim();
    if (normalizedQuery.isEmpty) {
      return [];
    }

    final results = ofertas.where((offer) {
      return offer.medicineName.toLowerCase().contains(normalizedQuery);
    }).toList();

    results.sort((a, b) => a.price.compareTo(b.price));
    return results;
  }
}
