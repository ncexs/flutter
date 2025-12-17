import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:geolocator/geolocator.dart';

class MapsScreen extends StatefulWidget {
  const MapsScreen({super.key});

  @override
  State<MapsScreen> createState() => _MapsScreenState();
}

class _MapsScreenState extends State<MapsScreen> with TickerProviderStateMixin {
  final MapController _mapController = MapController();

  // Lokasi UNPAM (Viktor)
  final LatLng _unpamLocation = const LatLng(-6.345869, 106.691689);
  LatLng? _currentLocation;
  double _currentZoom = 15.0;

  @override
  void initState() {
    super.initState();
    _checkPermission();
  }

  // --- LOGIKA GPS ---
  Future<void> _checkPermission() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Cek GPS aktif/tidak
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return; // Stop jika GPS mati
    }

    // Cek Izin Aplikasi
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return; // Stop jika izin ditolak
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return; // Stop jika ditolak permanen
    }

    // Jika aman, ambil lokasi
    _getCurrentLocation();
  }

  Future<void> _getCurrentLocation() async {
    try {
      Position position = await Geolocator.getCurrentPosition();
      setState(() {
        _currentLocation = LatLng(position.latitude, position.longitude);
      });
      // Pindahkan kamera ke lokasi user
      _mapController.move(_currentLocation!, 15);
    } catch (e) {
      debugPrint("Error: $e");
    }
  }

  // Fungsi Zoom
  void _zoomMap(double value) {
    _currentZoom = (_currentZoom + value).clamp(1.0, 19.0);
    _mapController.move(_mapController.camera.center, _currentZoom);
  }

  // --- TAMPILAN UI ---
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: const Text(
          "Lokasi Kampus",
          style: TextStyle(color: Colors.black87, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        // PERBAIKAN: Menggunakan .withValues(alpha: ...)
        backgroundColor: Colors.white.withValues(alpha: 0.8),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: Colors.black87),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Stack(
        children: [
          // 1. PETA UTAMA
          FlutterMap(
            mapController: _mapController,
            options: MapOptions(
              initialCenter: _unpamLocation,
              initialZoom: _currentZoom,
              interactionOptions: const InteractionOptions(
                flags: InteractiveFlag.all & ~InteractiveFlag.rotate,
              ),
            ),
            children: [
              TileLayer(
                urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                userAgentPackageName: 'com.example.app',
              ),

              // Layer Marker
              MarkerLayer(
                markers: [
                  // Marker UNPAM
                  Marker(
                    point: _unpamLocation,
                    width: 100,
                    height: 100,
                    child: _buildCustomMarker(
                      icon: Icons.school,
                      color: Colors.redAccent,
                      label: "UNPAM",
                    ),
                  ),

                  // Marker Lokasi Saya
                  if (_currentLocation != null)
                    Marker(
                      point: _currentLocation!,
                      width: 80,
                      height: 80,
                      child: _buildUserLocationMarker(),
                    ),
                ],
              ),
            ],
          ),

          // 2. TOMBOL KONTROL
          Positioned(
            right: 20,
            bottom: 220,
            child: Column(
              children: [
                _buildFloatingButton(icon: Icons.add, onTap: () => _zoomMap(1)),
                const SizedBox(height: 10),
                _buildFloatingButton(
                  icon: Icons.remove,
                  onTap: () => _zoomMap(-1),
                ),
                const SizedBox(height: 20),
                _buildFloatingButton(
                  icon: Icons.my_location,
                  color: Colors.blue,
                  iconColor: Colors.white,
                  onTap: () {
                    if (_currentLocation != null) {
                      _mapController.move(_currentLocation!, 16);
                    } else {
                      _checkPermission();
                    }
                  },
                ),
              ],
            ),
          ),

          // 3. INFO PANEL (Kartu Bawah)
          Positioned(
            left: 20,
            right: 20,
            bottom: 30,
            child: Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(25),
                boxShadow: [
                  BoxShadow(
                    // PERBAIKAN: .withValues
                    color: Colors.black.withValues(alpha: 0.15),
                    blurRadius: 20,
                    offset: const Offset(0, 10),
                  ),
                ],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          // PERBAIKAN: .withValues
                          color: Colors.redAccent.withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: const Icon(
                          Icons.location_on,
                          color: Colors.redAccent,
                          size: 30,
                        ),
                      ),
                      const SizedBox(width: 15),
                      const Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Universitas Pamulang",
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.black87,
                              ),
                            ),
                            Text(
                              "Kampus Viktor - Serpong",
                              style: TextStyle(
                                color: Colors.grey,
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 15,
                      vertical: 10,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.grey[100],
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          "Posisi Anda:",
                          style: TextStyle(fontWeight: FontWeight.w600),
                        ),
                        Text(
                          _currentLocation != null
                              ? "${_currentLocation!.latitude.toStringAsFixed(4)}, ${_currentLocation!.longitude.toStringAsFixed(4)}"
                              : "Mencari GPS...",
                          style: TextStyle(
                            color: Colors.blue[700],
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 15),
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton.icon(
                      onPressed: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text("Memulai Navigasi ke Kampus..."),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blueAccent,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                      icon: const Icon(Icons.directions, color: Colors.white),
                      label: const Text(
                        "Navigasi Sekarang",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // --- WIDGET CUSTOM ---

  Widget _buildCustomMarker({
    required IconData icon,
    required Color color,
    required String label,
  }) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Colors.white,
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                // PERBAIKAN: .withValues
                color: color.withValues(alpha: 0.4),
                blurRadius: 10,
                offset: const Offset(0, 5),
              ),
            ],
            border: Border.all(color: color, width: 2),
          ),
          child: Icon(icon, color: color, size: 30),
        ),
        const SizedBox(height: 5),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
            boxShadow: [const BoxShadow(color: Colors.black12, blurRadius: 4)],
          ),
          child: Text(
            label,
            style: TextStyle(
              color: color,
              fontWeight: FontWeight.bold,
              fontSize: 12,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildUserLocationMarker() {
    return Stack(
      alignment: Alignment.center,
      children: [
        Container(
          width: 60,
          height: 60,
          decoration: BoxDecoration(
            // PERBAIKAN: .withValues
            color: Colors.blue.withValues(alpha: 0.2),
            shape: BoxShape.circle,
          ),
        ),
        Container(
          width: 30,
          height: 30,
          decoration: const BoxDecoration(
            color: Colors.white,
            shape: BoxShape.circle,
            boxShadow: [BoxShadow(color: Colors.black26, blurRadius: 5)],
          ),
        ),
        Container(
          width: 15,
          height: 15,
          decoration: const BoxDecoration(
            color: Colors.blueAccent,
            shape: BoxShape.circle,
          ),
        ),
      ],
    );
  }

  Widget _buildFloatingButton({
    required IconData icon,
    required VoidCallback onTap,
    Color color = Colors.white,
    Color iconColor = Colors.black87,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 50,
        height: 50,
        decoration: BoxDecoration(
          color: color,
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              // PERBAIKAN: .withValues
              color: Colors.black.withValues(alpha: 0.1),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Icon(icon, color: iconColor),
      ),
    );
  }
}
