import 'package:flutter/material.dart';

// Kelas ini menggunakan StatefulWidget karena kita perlu mengubah tampilan
// (teks pilihan) saat user memilih menu.
class OptionContextScreen extends StatefulWidget {
  const OptionContextScreen({super.key});

  @override
  State<OptionContextScreen> createState() => _OptionContextScreenState();
}

class _OptionContextScreenState extends State<OptionContextScreen> {
  // Variabel untuk menyimpan hasil pilihan agar bisa ditampilkan di layar
  String _pilihanOptionMenu = "Belum ada yang dipilih";
  String _pilihanContextMenu = "Belum ada yang dipilih";

  // ------------------------------------------------------------------------
  // FUNGSI 1: Menangani logika saat Option Menu (Titik Tiga) dipilih
  // ------------------------------------------------------------------------
  void _pilihOptionMenu(String value) {
    setState(() {
      _pilihanOptionMenu = value;
    });

    // Menampilkan pesan kecil di bawah (SnackBar)
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text("Anda memilih menu: $value"),
        // Mengambil warna dari tema utama (main.dart)
        backgroundColor: Theme.of(context).colorScheme.primary,
        duration: const Duration(seconds: 1),
      ),
    );
  }

  // ------------------------------------------------------------------------
  // FUNGSI 2: Menampilkan Context Menu saat ditekan lama (Long Press)
  // ------------------------------------------------------------------------
  // Kita menggunakan 'async' dan 'await' karena memunculkan menu butuh waktu
  // menunggu input dari user.
  Future<void> _tampilkanContextMenu(Offset posisiKlik) async {
    // Mencari ukuran layar/overlay untuk penentuan posisi menu
    final RenderBox overlay =
        Overlay.of(context).context.findRenderObject() as RenderBox;

    // Menampilkan menu pop-up di posisi jari user
    final String? hasilPilihan = await showMenu<String>(
      context: context,
      // Mengatur posisi menu muncul (RelativeRect)
      position: RelativeRect.fromRect(
        posisiKlik & const Size(40, 40), // Area sentuh
        Offset.zero & overlay.size, // Ukuran layar keseluruhan
      ),
      // Daftar Item Menu
      items: [
        const PopupMenuItem(
          value: 'Edit Data',
          child: Row(
            children: [
              Icon(Icons.edit, color: Colors.blue),
              SizedBox(width: 10),
              Text('Edit Data'),
            ],
          ),
        ),
        const PopupMenuItem(
          value: 'Hapus Data',
          child: Row(
            children: [
              Icon(Icons.delete, color: Colors.red),
              SizedBox(width: 10),
              Text('Hapus Data'),
            ],
          ),
        ),
      ],
    );

    // Cek 'mounted' (apakah layar masih aktif?) sebelum update state
    // Ini penting di Flutter modern untuk mencegah error
    if (!mounted) return;

    // Jika user memilih sesuatu (hasil tidak null)
    if (hasilPilihan != null) {
      setState(() {
        _pilihanContextMenu = hasilPilihan;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Aksi Context Menu: $hasilPilihan")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    // Mengambil skema warna dari main.dart biar seragam
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Pertemuan 12: Menu"),
        // Warna AppBar mengikuti tema primary
        backgroundColor: colorScheme.primary,
        foregroundColor: colorScheme.onPrimary,

        // =======================================================
        // 1. IMPLEMENTASI OPTION MENU (Tombol Titik Tiga di Pojok Kanan)
        // =======================================================
        actions: [
          PopupMenuButton<String>(
            // Fungsi yang dijalankan saat item dipilih
            onSelected: _pilihOptionMenu,
            // Membangun daftar item menu
            itemBuilder: (BuildContext context) {
              return [
                const PopupMenuItem<String>(
                  value: 'Upload',
                  child: Row(
                    children: [
                      Icon(Icons.cloud_upload, color: Colors.grey),
                      SizedBox(width: 8),
                      Text('Upload'),
                    ],
                  ),
                ),
                const PopupMenuItem<String>(
                  value: 'Settings',
                  child: Row(
                    children: [
                      Icon(Icons.settings, color: Colors.grey),
                      SizedBox(width: 8),
                      Text('Settings'),
                    ],
                  ),
                ),
                const PopupMenuItem<String>(
                  value: 'Logout',
                  child: Row(
                    children: [
                      Icon(Icons.logout, color: Colors.grey),
                      SizedBox(width: 8),
                      Text('Logout'),
                    ],
                  ),
                ),
              ];
            },
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Menampilkan hasil Option Menu
            const Text(
              "Status Option Menu:",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            Text(
              _pilihanOptionMenu,
              style: TextStyle(
                fontSize: 18,
                color: colorScheme.primary, // Warna teks ikut tema
              ),
            ),
            const SizedBox(height: 30),
            const Divider(), // Garis pemisah
            const SizedBox(height: 30),

            // Menampilkan hasil Context Menu
            const Text(
              "Status Context Menu:",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            Text(
              _pilihanContextMenu,
              style: TextStyle(
                fontSize: 18,
                color: colorScheme.primary, // Warna teks ikut tema
              ),
            ),
            const SizedBox(height: 30),

            // =======================================================
            // 2. IMPLEMENTASI CONTEXT MENU (Tekan Lama pada Widget)
            // =======================================================
            GestureDetector(
              // Mendeteksi saat user menekan lama
              onLongPressStart: (details) {
                // Memanggil fungsi untuk memunculkan menu
                // details.globalPosition adalah koordinat jari di layar
                _tampilkanContextMenu(details.globalPosition);
              },
              child: Container(
                width: 250,
                height: 100,
                decoration: BoxDecoration(
                  // Warna background container (primaryContainer dari tema)
                  color: colorScheme.primaryContainer,
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: [
                    BoxShadow(
                      // Nilai alpha adalah 0.0 sampai 1.0
                      color: Colors.grey.withValues(alpha: 0.5),
                      spreadRadius: 2,
                      blurRadius: 5,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                alignment: Alignment.center,
                child: Text(
                  "Tekan Tahan Disini\n(Long Press)",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    // Warna teks agar kontras dengan container
                    color: colorScheme.onPrimaryContainer,
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
