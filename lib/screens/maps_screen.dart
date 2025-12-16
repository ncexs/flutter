import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart'; // Library Peta Utama
import 'package:latlong2/latlong.dart'; // Format Koordinat
import 'package:geolocator/geolocator.dart'; // Akses GPS

class MapsScreen extends StatefulWidget {
  const MapsScreen({super.key});

  @override
  State<MapsScreen> createState() => _MapsScreenState();
}

class _MapsScreenState extends State<MapsScreen> {
  // Controller untuk menggerakkan peta secara coding
  final MapController _mapController = MapController();

  // Koordinat Default (Universitas Pamulang - Viktor)
  // Anda bisa ganti koordinat ini sesuai keinginan
  final LatLng _unpamLocation = const LatLng(-6.345869, 106.691689);

  // Variabel untuk menyimpan posisi saat ini
  LatLng? _currentLocation;

  @override
  void initState() {
    super.initState();
    // Cek izin lokasi saat pertama kali dibuka
    _checkPermission();
  }

  // Fungsi Cek Izin & Ambil Lokasi
  Future<void> _checkPermission() async {
    bool serviceEnabled;
    LocationPermission permission;

    // 1. Cek apakah GPS nyala?
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Jika mati, minta user nyalakan
      return Future.error('Location services are disabled.');
    }

    // 2. Cek izin aplikasi
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error('Location permissions are permanently denied.');
    }

    // 3. Jika aman, ambil lokasi sekarang
    _getCurrentLocation();
  }

  Future<void> _getCurrentLocation() async {
    try {
      Position position = await Geolocator.getCurrentPosition();
      setState(() {
        _currentLocation = LatLng(position.latitude, position.longitude);
      });
    } catch (e) {
      debugPrint("Gagal mengambil lokasi: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Peta Lokasi (Maps)"),
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Colors.white,
        actions: [
          // Tombol Refresh Lokasi
          IconButton(
            icon: const Icon(Icons.my_location),
            onPressed: () {
              if (_currentLocation != null) {
                // Pindahkan kamera ke lokasi saya
                _mapController.move(_currentLocation!, 15.0);
              } else {
                _checkPermission();
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("Sedang mencari lokasi...")),
                );
              }
            },
          ),
        ],
      ),
      body: Stack(
        children: [
          // 1. Widget Peta Utama
          FlutterMap(
            mapController: _mapController,
            options: MapOptions(
              // Lokasi awal kamera (UNPAM)
              initialCenter: _unpamLocation,
              initialZoom: 15.0,
            ),
            children: [
              // Layer Gambar Peta (Tile) - Menggunakan OpenStreetMap (Gratis)
              TileLayer(
                urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                userAgentPackageName: 'com.example.app', // Wajib diisi (bebas)
              ),

              // Layer Penanda (Marker)
              MarkerLayer(
                markers: [
                  // Marker 1: UNPAM (Warna Merah)
                  Marker(
                    point: _unpamLocation,
                    width: 80,
                    height: 80,
                    child: const Column(
                      children: [
                        Icon(Icons.location_on, color: Colors.red, size: 40),
                        Text(
                          "UNPAM",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.red,
                          ),
                        ),
                      ],
                    ),
                  ),

                  // Marker 2: Lokasi Saya (Warna Biru) - Jika sudah ditemukan
                  if (_currentLocation != null)
                    Marker(
                      point: _currentLocation!,
                      width: 80,
                      height: 80,
                      child: const Icon(
                        Icons.person_pin_circle,
                        color: Colors.blueAccent,
                        size: 40,
                      ),
                    ),
                ],
              ),
            ],
          ),

          // 2. Info Box di Bawah
          Positioned(
            bottom: 20,
            left: 20,
            right: 20,
            child: Card(
              elevation: 5,
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text(
                      "Lokasi Terpilih",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      _currentLocation != null
                          ? "Lat: ${_currentLocation!.latitude.toStringAsFixed(4)}, Lng: ${_currentLocation!.longitude.toStringAsFixed(4)}"
                          : "Menampilkan lokasi UNPAM",
                      style: const TextStyle(color: Colors.grey),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
