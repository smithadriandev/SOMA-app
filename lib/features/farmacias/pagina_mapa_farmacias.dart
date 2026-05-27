import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';

import '../../app/theme.dart';
import 'mock/mock_farmacias.dart';
import 'models/farmacia.dart';
import 'widgets/card_farmacia.dart';

class PaginaMapaFarmacias extends StatefulWidget {
  const PaginaMapaFarmacias({super.key});

  @override
  State<PaginaMapaFarmacias> createState() => _PaginaMapaFarmaciasState();
}

class _PaginaMapaFarmaciasState extends State<PaginaMapaFarmacias> {
  final _mapController = MapController();
  LatLng _userLocation = MockFarmacias.unitTiradentesLocation;
  Farmacia? _selectedFarmacia;

  @override
  void initState() {
    super.initState();
    _loadUserLocation();
  }

  Future<void> _loadUserLocation() async {
    try {
      final serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        return;
      }

      var permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
      }

      if (permission == LocationPermission.denied ||
          permission == LocationPermission.deniedForever) {
        return;
      }

      final position = await Geolocator.getCurrentPosition(
        locationSettings: const LocationSettings(
          accuracy: LocationAccuracy.high,
        ),
      );

      if (!mounted) return;

      final currentLocation = LatLng(position.latitude, position.longitude);
      setState(() => _userLocation = currentLocation);
      _mapController.move(currentLocation, 15);
    } catch (_) {
      if (!mounted) return;
      setState(() => _userLocation = MockFarmacias.unitTiradentesLocation);
    }
  }

  void _focusFarmacia(Farmacia pharmacy) {
    setState(() => _selectedFarmacia = pharmacy);
    _mapController.move(pharmacy.position, 16);
  }

  void _showFarmaciaDetails(Farmacia pharmacy) {
    _focusFarmacia(pharmacy);

    showModalBottomSheet<void>(
      context: context,
      backgroundColor: Theme.of(context).cardColor,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(18)),
      ),
      builder: (context) {
        final theme = Theme.of(context);
        final textColor = theme.colorScheme.onSurface;
        final secondaryColor = theme.textTheme.bodySmall?.color ?? Colors.grey;

        return Padding(
          padding: const EdgeInsets.fromLTRB(22, 18, 22, 24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                pharmacy.name,
                style: TextStyle(
                  color: textColor,
                  fontSize: 18,
                  fontWeight: FontWeight.w800,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                pharmacy.address,
                style: TextStyle(color: secondaryColor, fontSize: 14),
              ),
              const SizedBox(height: 6),
              Text(
                '${pharmacy.distance} • ${pharmacy.openingHours}',
                style: TextStyle(color: secondaryColor, fontSize: 14),
              ),
            ],
          ),
        );
      },
    );
  }

  List<Marker> _buildMarkers() {
    return [
      Marker(
        point: _userLocation,
        width: 46,
        height: 46,
        child: const _MarcadorMapa(
          icon: Icons.person_pin_circle,
          color: SomaColors.primaryBlue,
          size: 38,
        ),
      ),
      ...MockFarmacias.pharmacies.map((pharmacy) {
        final selected = pharmacy == _selectedFarmacia;

        return Marker(
          point: pharmacy.position,
          width: 46,
          height: 46,
          child: GestureDetector(
            onTap: () => _showFarmaciaDetails(pharmacy),
            child: _MarcadorMapa(
              icon: Icons.local_pharmacy,
              color:
                  selected ? SomaColors.primaryBlue : const Color(0xFF2DBE78),
              size: selected ? 42 : 36,
            ),
          ),
        );
      }),
    ];
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textColor = theme.colorScheme.onSurface;

    return Scaffold(
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 520),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 18, 20, 14),
                  child: Row(
                    children: [
                      IconButton(
                        onPressed: () => Navigator.pop(context),
                        icon: Icon(
                          Icons.arrow_back,
                          color: textColor,
                          size: 29,
                        ),
                        padding: EdgeInsets.zero,
                        constraints: const BoxConstraints(
                          minWidth: 40,
                          minHeight: 40,
                        ),
                      ),
                      const SizedBox(width: 6),
                      Text(
                        'Farmácias próximas',
                        style: TextStyle(
                          color: textColor,
                          fontSize: 20,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ],
                  ),
                ),
                Divider(height: 1, color: theme.dividerColor),
                Expanded(
                  child: Column(
                    children: [
                      Expanded(
                        flex: 6,
                        child: Padding(
                          padding: const EdgeInsets.all(16),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(14),
                            child: FlutterMap(
                              mapController: _mapController,
                              options: MapOptions(
                                initialCenter: _userLocation,
                                initialZoom: 15,
                              ),
                              children: [
                                TileLayer(
                                  urlTemplate:
                                      'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                                  userAgentPackageName: 'com.example.soma',
                                ),
                                MarkerLayer(markers: _buildMarkers()),
                              ],
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 260,
                        child: ListView.builder(
                          padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                          itemCount: MockFarmacias.pharmacies.length,
                          itemBuilder: (context, index) {
                            final pharmacy = MockFarmacias.pharmacies[index];

                            return CardFarmacia(
                              pharmacy: pharmacy,
                              onViewOnMap: () => _focusFarmacia(pharmacy),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _MarcadorMapa extends StatelessWidget {
  const _MarcadorMapa({
    required this.icon,
    required this.color,
    required this.size,
  });

  final IconData icon;
  final Color color;
  final double size;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.22),
            blurRadius: 5,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Icon(
        icon,
        color: color,
        size: size,
      ),
    );
  }
}
