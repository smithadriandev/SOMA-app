import '../models/medicine_offer.dart';

class MockMedicineOffers {
  static const commonMedicines = [
    'Dipirona',
    'Paracetamol',
    'Losartana',
    'Omeprazol',
    'Metformina',
  ];

  static const offers = [
    MedicineOffer(
      medicineName: 'Dipirona 500mg',
      pharmacyName: 'Drogasil',
      price: 70.99,
      address: 'Av. Murilo Dantas, 450',
      latitude: -10.9492,
      longitude: -37.0712,
    ),
    MedicineOffer(
      medicineName: 'Dipirona 500mg',
      pharmacyName: 'Pague Menos',
      price: 75.00,
      address: 'Av. Dr. José Tomaz D’Ávila Nabuco, 900',
      latitude: -10.9479,
      longitude: -37.0698,
    ),
    MedicineOffer(
      medicineName: 'Dipirona 500mg',
      pharmacyName: 'Farmácia Popular',
      price: 79.90,
      address: 'Rua Projetada, 120 - Farolândia',
      latitude: -10.9501,
      longitude: -37.0689,
    ),
    MedicineOffer(
      medicineName: 'Paracetamol 750mg',
      pharmacyName: 'Farmácia Popular',
      price: 12.50,
      address: 'Rua Projetada, 120 - Farolândia',
      latitude: -10.9501,
      longitude: -37.0689,
    ),
    MedicineOffer(
      medicineName: 'Paracetamol 750mg',
      pharmacyName: 'Drogaria Saúde',
      price: 14.90,
      address: 'Av. Murilo Dantas, 195',
      latitude: -10.9468,
      longitude: -37.0715,
    ),
    MedicineOffer(
      medicineName: 'Losartana 50mg',
      pharmacyName: 'Farma Vida',
      price: 22.00,
      address: 'Av. Murilo Dantas, 450',
      latitude: -10.9492,
      longitude: -37.0712,
    ),
    MedicineOffer(
      medicineName: 'Losartana 50mg',
      pharmacyName: 'Drogasil',
      price: 24.90,
      address: 'Av. Dr. José Tomaz D’Ávila Nabuco, 900',
      latitude: -10.9479,
      longitude: -37.0698,
    ),
    MedicineOffer(
      medicineName: 'Omeprazol 20mg',
      pharmacyName: 'Drogaria Central',
      price: 18.99,
      address: 'Av. Murilo Dantas, 195',
      latitude: -10.9468,
      longitude: -37.0715,
    ),
    MedicineOffer(
      medicineName: 'Omeprazol 20mg',
      pharmacyName: 'Pague Menos',
      price: 21.50,
      address: 'Av. Dr. José Tomaz D’Ávila Nabuco, 900',
      latitude: -10.9479,
      longitude: -37.0698,
    ),
    MedicineOffer(
      medicineName: 'Metformina 850mg',
      pharmacyName: 'Farmácia Popular',
      price: 15.50,
      address: 'Rua Projetada, 120 - Farolândia',
      latitude: -10.9501,
      longitude: -37.0689,
    ),
    MedicineOffer(
      medicineName: 'Metformina 850mg',
      pharmacyName: 'Drogasil',
      price: 16.90,
      address: 'Av. Murilo Dantas, 450',
      latitude: -10.9492,
      longitude: -37.0712,
    ),
  ];

  static List<MedicineOffer> searchOffers(String query) {
    final normalizedQuery = query.toLowerCase().trim();
    if (normalizedQuery.isEmpty) {
      return [];
    }

    final results = offers.where((offer) {
      return offer.medicineName.toLowerCase().contains(normalizedQuery);
    }).toList();

    results.sort((a, b) => a.price.compareTo(b.price));
    return results;
  }
}