import 'package:latlong2/latlong.dart';

class Pharmacy {
  const Pharmacy({
    required this.name,
    required this.address,
    required this.distance,
    required this.openingHours,
    required this.latitude,
    required this.longitude,
  });

  final String name;
  final String address;
  final String distance;
  final String openingHours;
  final double latitude;
  final double longitude;

  LatLng get position => LatLng(latitude, longitude);
}
