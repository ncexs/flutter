import 'package:flutter/material.dart';
// WAJIB DITAMBAHKAN: Import file screen tujuan
import 'package:flutter_application/screens/create_data_screen.dart';

// Ini adalah StatelessWidget.
// Artinya, widget ini tidak memiliki "state" (data) internal
// yang bisa berubah. Tampilannya statis.
class HomeScreen extends StatelessWidget {
  // Constructor untuk widget
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Scaffold adalah kerangka dasar halaman
    return Scaffold(
      // Mengatur warna latar belakang seluruh halaman
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: const Text("Beranda"), // Judul di AppBar
        // ===== PERUBAHAN =====
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Theme.of(context).colorScheme.onPrimary,
        // =======================
      ),
      // ListView agar konten bisa di-scroll jika melebihi layar
      body: ListView(
        // children berisi semua widget yang akan ditampilkan di dalam ListView
        children: [
          // Stack digunakan untuk menumpuk widget (latar melengkung, teks, card)
          Stack(
            children: [
              // Latar belakang melengkung
              Container(
                height: 220, // Tinggi container
                decoration: BoxDecoration(
                  // 'withOpacity(0.2)' diganti dengan nilai alpha '51'
                  color: const Color.fromARGB(51, 4, 7, 69),

                  // Mengatur kelengkungan sudut (hanya di bagian bawah)
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(150),
                    bottomRight: Radius.circular(150),
                  ),
                ),
              ),
              // Teks sambutan
              // Align untuk mengatur posisi widget di dalam Stack
              Align(
                alignment: Alignment.topCenter, // Posisikan di tengah-atas
                child: Padding(
                  // Beri jarak dari atas
                  padding: const EdgeInsets.only(top: 60.0),
                  child: const Text(
                    "Selamat Datang, Ncex's!",
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                ),
              ),
              // Baris yang berisi menu Card
              Padding(
                // Beri jarak dari atas, kiri, dan kanan
                padding: const EdgeInsets.only(
                  top: 130.0,
                  left: 16.0,
                  right: 16.0,
                ),
                // Row untuk menyusun widget secara horizontal (mendatar)
                child: Row(
                  children: [
                    // Memanggil fungsi _buildMenuCard untuk membuat card
                    // Kita kirim 'context' ke dalam fungsi
                    _buildMenuCard(context, Icons.list_alt, "List Data"),
                    // SizedBox hanya untuk memberi spasi/jarak horizontal
                    const SizedBox(width: 10),
                    _buildMenuCard(context, Icons.add_box, "Create Data"),
                    const SizedBox(width: 10),
                    _buildMenuCard(context, Icons.info_outline, "About"),
                  ],
                ),
              ),
            ],
          ),
          // Spasi di bawah Stack
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  // Ini adalah FUNGSI/METHOD untuk membuat widget Card menu
  Widget _buildMenuCard(BuildContext context, IconData icon, String label) {
    return Expanded(
      child: Container(
        height: 100, // Tinggi card
        decoration: BoxDecoration(
          color: Colors.white, // Warna latar card
          borderRadius: BorderRadius.circular(16), // Sudut melengkung
          // boxShadow untuk memberi efek bayangan
          boxShadow: [
            BoxShadow(
              color: const Color.fromARGB(77, 158, 158, 158),
              spreadRadius: 2, // Seberapa menyebar bayangannya
              blurRadius: 6, // Seberapa buram bayangannya
              offset: const Offset(0, 3), // Posisi bayangan (x, y)
            ),
          ],
        ),
        // InkWell membuat widget (Container) bisa diketuk
        child: InkWell(
          onTap: () {
            // ===================================
            // LOGIKA NAVIGASI DITAMBAHKAN DI SINI
            // ===================================
            if (label == "Create Data") {
              Navigator.push(
                context,
                MaterialPageRoute(
                  // Navigasi ke CreateDataScreen
                  builder: (context) => const CreateDataScreen(),
                ),
              );
            } else {
              // Aksi default untuk menu lain (opsional: bisa diisi dengan navigasi lain)
              ScaffoldMessenger.of(
                context,
              ).showSnackBar(SnackBar(content: Text('Menu $label diklik')));
            }
          },
          // Column untuk menyusun ikon dan teks secara vertikal
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Ikon sekarang menggunakan warna primary dari Tema
              Icon(
                icon,
                size: 35,
                color: Theme.of(context).colorScheme.primary,
              ),
              const SizedBox(height: 10), // Spasi antara ikon dan teks
              Text(
                // Teks label
                label,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
