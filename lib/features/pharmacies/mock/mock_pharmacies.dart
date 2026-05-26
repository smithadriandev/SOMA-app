import 'package:latlong2/latlong.dart';

import '../models/pharmacy.dart';

class MockPharmacies {
  static const LatLng unitTiradentesLocation = LatLng(-10.9695271, -37.058544);

  static const pharmacies = [
    Pharmacy(
      name: 'Farmácia Popular',
      address: 'Av. Murilo Dantas, 450',
      distance: '420 m',
      openingHours: 'Aberta até 22:00',
      latitude: -10.9667,
      longitude: -37.0611,
    ),
    Pharmacy(
      name: 'Drogaria Saúde',
      address: 'Av. Dr. José Tomaz D’Ávila Nabuco, 900',
      distance: '650 m',
      openingHours: 'Aberta até 21:00',
      latitude: -10.9734,
      longitude: -37.0547,
    ),
    Pharmacy(
      name: 'Farma Vida',
      address: 'Rua Projetada, 120 - Farolândia',
      distance: '900 m',
      openingHours: '24 horas',
      latitude: -10.9762,
      longitude: -37.0609,
    ),
    Pharmacy(
      name: 'Drogaria Central',
      address: 'Av. Murilo Dantas, 195',
      distance: '1.1 km',
      openingHours: 'Aberta até 20:00',
      latitude: -10.9638,
      longitude: -37.0554,
    ),
  ];
}
