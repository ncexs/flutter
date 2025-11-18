import 'package:flutter/material.dart';

// Layar ini mengimplementasikan TabBar dan TabBarView
class TabLayoutScreen extends StatelessWidget {
  const TabLayoutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final Color primaryColor = Theme.of(context).colorScheme.primary;
    final Color onPrimaryColor = Theme.of(context).colorScheme.onPrimary;

    // DefaultTabController adalah widget yang menyediakan TabController ke widget-widget turunannya.
    return DefaultTabController(
      length: 3, // Jumlah total tab yang akan digunakan
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: primaryColor,
          title: Text(
            'Pertemuan 10: TabLayout',
            style: TextStyle(color: onPrimaryColor),
          ),
          iconTheme: IconThemeData(color: onPrimaryColor),
          // Bagian bottom dari AppBar adalah tempat menempatkan TabBar
          bottom: TabBar(
            // Warna indicator (garis bawah tab yang dipilih)
            indicatorColor: onPrimaryColor,
            // Warna teks/ikon tab yang dipilih
            labelColor: onPrimaryColor,
            // PERBAIKAN: Mengganti .withOpacity(0.7) dengan .withAlpha(178)
            unselectedLabelColor: onPrimaryColor.withAlpha(178),
            tabs: const [
              // Icon dan Label untuk setiap Tab
              Tab(icon: Icon(Icons.home), text: 'Home'),
              Tab(icon: Icon(Icons.settings), text: 'Settings'),
              Tab(icon: Icon(Icons.person), text: 'Profile'),
            ],
          ),
        ),
        // TabBarView akan menampilkan konten sesuai dengan tab yang dipilih
        body: TabBarView(
          children: [
            // Konten untuk Tab "Home"
            _buildTabContent(Icons.home, 'Halaman Utama', primaryColor),
            // Konten untuk Tab "Settings"
            _buildTabContent(
              Icons.settings,
              'Pengaturan Aplikasi',
              primaryColor,
            ),
            // Konten untuk Tab "Profile"
            _buildTabContent(Icons.person, 'Informasi Pengguna', primaryColor),
          ],
        ),
      ),
    );
  }

  // Widget helper untuk membuat tampilan konten Tab yang seragam
  Widget _buildTabContent(IconData icon, String text, Color color) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Icon(icon, size: 100, color: color),
          const SizedBox(height: 20),
          Text(
            text,
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          const Padding(
            padding: EdgeInsets.all(16.0),
            child: Text(
              'Ini adalah konten dari TabBarView. Konten akan berganti secara otomatis saat Anda memilih tab di atas.',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16, color: Colors.black54),
            ),
          ),
        ],
      ),
    );
  }
}
