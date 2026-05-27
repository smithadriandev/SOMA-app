class MedicineOffer {
  const MedicineOffer({
    required this.medicineName,
    required this.pharmacyName,
    required this.price,
    required this.address,
    required this.latitude,
    required this.longitude,
  });

  final String medicineName;
  final String pharmacyName;
  final double price;
  final String address;
  final double latitude;
  final double longitude;
}