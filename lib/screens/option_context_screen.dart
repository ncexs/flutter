import 'package:flutter/material.dart';

// ===============================================
// HALAMAN PERTEMUAN 12 - OPTION MENU & CONTEXT MENU
// ===============================================

class OptionContextScreen extends StatelessWidget {
  const OptionContextScreen({super.key});

  // Fungsi helper untuk menampilkan SnackBar
  void _showSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Theme.of(context).colorScheme.primary,
        duration: const Duration(milliseconds: 1500),
      ),
    );
  }

  // Fungsi untuk menampilkan Context Menu (showMenu) saat Long Press
  void _showContextMenu(BuildContext context, Offset position) {
    // showMenu digunakan untuk menampilkan menu pop-up di posisi spesifik
    showMenu<String>(
      context: context,
      // position ditentukan berdasarkan posisi Long Press pada layar
      position: RelativeRect.fromRect(
        position & const Size(40, 40), // Ukuran kecil di sekitar titik tekan
        Offset.zero & MediaQuery.of(context).size, // Ukuran seluruh layar
      ),
      items: <PopupMenuEntry<String>>[
        const PopupMenuItem<String>(
          value: 'edit',
          child: Row(
            children: [Icon(Icons.edit), SizedBox(width: 8), Text('Edit Data')],
          ),
        ),
        const PopupMenuItem<String>(
          value: 'delete',
          child: Row(
            children: [
              Icon(Icons.delete),
              SizedBox(width: 8),
              Text('Hapus Data'),
            ],
          ),
        ),
        const PopupMenuItem<String>(
          value: 'archive',
          child: Row(
            children: [Icon(Icons.archive), SizedBox(width: 8), Text('Arsip')],
          ),
        ),
      ],
    ).then((String? result) {
      if (result != null) {
        _showSnackBar(context, 'Context Menu: Aksi "$result" dipilih');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final Color onPrimaryColor = Theme.of(context).colorScheme.onPrimary;
    final Color primaryColor = Theme.of(context).colorScheme.primary;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'P12: Option & Context Menu',
          style: TextStyle(color: onPrimaryColor),
        ),
        backgroundColor: primaryColor,
        iconTheme: IconThemeData(color: onPrimaryColor),

        // ===================================
        // Option Menu (Actions di AppBar)
        // ===================================
        actions: [
          // Option 1: Ikon Pencarian
          IconButton(
            icon: const Icon(Icons.search),
            tooltip: 'Cari',
            onPressed: () {
              _showSnackBar(context, 'Option Menu: Tombol Cari diklik');
            },
          ),

          // Option 2: Overflow Menu (Tiga Titik Vertikal)
          PopupMenuButton<String>(
            icon: const Icon(Icons.more_vert),
            onSelected: (String result) {
              _showSnackBar(context, 'Option Menu: Opsi "$result" dipilih');
            },
            itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
              const PopupMenuItem<String>(
                value: 'about',
                child: Text('Tentang Aplikasi'),
              ),
              const PopupMenuItem<String>(
                value: 'settings',
                child: Text('Pengaturan'),
              ),
              const PopupMenuItem<String>(
                value: 'logout',
                child: Text('Logout'),
              ),
            ],
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Padding(
              padding: EdgeInsets.only(bottom: 20.0),
              child: Text(
                'Menu di atas (AppBar) adalah Option Menu.',
                style: TextStyle(fontSize: 16),
              ),
            ),

            // ===================================
            // Context Menu (Triggered by Long Press)
            // ===================================
            // GestureDetector membungkus Card agar bisa merespons long press
            GestureDetector(
              // Mendapatkan posisi ketukan untuk menempatkan menu yang tepat
              onLongPressStart: (details) {
                _showContextMenu(context, details.globalPosition);
              },
              child: Card(
                elevation: 6,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                margin: const EdgeInsets.symmetric(horizontal: 40),
                child: Padding(
                  padding: const EdgeInsets.all(30.0),
                  child: Column(
                    children: [
                      Icon(Icons.touch_app, size: 60, color: primaryColor),
                      const SizedBox(height: 15),
                      const Text(
                        'TEKAN LAMA (LONG PRESS)',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 5),
                      const Text(
                        'Tekan lama card ini untuk memunculkan Context Menu.',
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 14, color: Colors.grey),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
