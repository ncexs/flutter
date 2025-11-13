// Mengimpor package untuk dialog (popup) yang bisa beradaptasi
// dengan tampilan iOS atau Android
import 'package:adaptive_dialog/adaptive_dialog.dart';
// Mengimpor package dasar Flutter untuk semua widget Material Design
import 'package:flutter/material.dart';

// Ini adalah StatefulWidget.
// Artinya, widget ini memiliki "state" (data) yang bisa berubah
// seiring waktu (dalam kasus ini, variabel _counter).
class ProfileScreen extends StatefulWidget {
  // Constructor untuk widget
  const ProfileScreen({super.key});

  @override
  // Membuat dan menghubungkan class State (_ProfileScreenState)
  State<ProfileScreen> createState() => _ProfileScreenState();
}

// Ini adalah class State yang menyimpan data untuk ProfileScreen
class _ProfileScreenState extends State<ProfileScreen> {
  // Variabel state untuk menyimpan hitungan (angka)
  int _counter = 0;

  // Fungsi/method untuk menambah nilai _counter
  void _incrementCounter() {
    // setState() adalah fungsi penting di StatefulWidget.
    // Ini memberi tahu Flutter untuk "membangun ulang" (re-render)
    // tampilan karena ada data yang berubah.
    setState(() {
      _counter++;
    });
  }

  // Fungsi untuk menampilkan dialog (alert)
  // 'async' diperlukan karena kita menggunakan 'await' di dalamnya
  Future<void> _showadaptiveAlert(BuildContext context) async {
    // Panggil fungsi increment dulu
    _incrementCounter();

    // 'await' berarti "tunggu" sampai dialog ini selesai (ditutup user)
    // baru lanjutkan kode di bawahnya (jika ada).
    await showOkAlertDialog(
      context: context, // Konteks build dari widget
      title: "OK", // Judul dialog diubah
      message: "Tombol diklik: $_counter", // Pesan diubah
      okLabel: "ok", // Teks di tombol
    );
  }

  // Fungsi ini untuk membuat baris info (Ikon + Teks)
  Widget _buildInfoRow(IconData icon, String text) {
    return Padding(
      // Padding horizontal dihapus agar centering berfungsi
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        // Mengatur agar Ikon dan Teks di dalamnya Posisinya di tengah Row
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Ikon
          Icon(icon, color: Colors.black54, size: 20),
          // Jarak antara ikon dan teks
          const SizedBox(width: 16),
          // Teks
          Text(text, style: const TextStyle(fontSize: 14)),
        ],
      ),
    );
  }

  // @override menandakan kita mengganti fungsi build() dari class induk
  @override
  Widget build(BuildContext context) {
    // Scaffold adalah kerangka dasar halaman (menyediakan AppBar, body, dll.)
    return Scaffold(
      // AppBar (bilah di bagian atas)
      appBar: AppBar(
        title: const Text("My Profil"), // Judul AppBar
        // Menggunakan warna primary dari Tema
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Theme.of(context).colorScheme.onPrimary,
      ),

      // ===== PERUBAHAN DI SINI =====
      // Menyamakan warna background Scaffold dengan halaman Home dan List
      backgroundColor: Colors.grey[100],
      // =============================

      // body: konten utama halaman
      // ListView membuat konten bisa di-scroll jika lebih panjang dari layar
      body: ListView(
        padding: const EdgeInsets.all(
          26,
        ), // Jarak/padding di sekeliling ListView
        children: [
          // Stack digunakan untuk menumpuk widget (foto di atas gambar latar)
          Stack(
            // clipBehavior.none agar CircleAvatar bisa "keluar" dari batas Container
            clipBehavior: Clip.none,
            // 'alignment' ditambahkan
            alignment: Alignment.center,
            children: [
              // Ini adalah widget latar (gambar sampul)
              Container(
                // Tinggi diubah dari 270 menjadi 240
                height: 240,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  image: const DecorationImage(
                    image: AssetImage(
                      "assets/img/background.jpeg", // Path gambar background
                    ),
                    fit: BoxFit
                        .cover, // Membuat gambar menutupi seluruh area Container
                  ),
                ),
              ),
              // Positioned digunakan untuk mengatur posisi widget di dalam Stack
              Positioned(
                // Posisi top diubah dari 80 menjadi 36
                top: 36,
                // (Tambahan) Container untuk border & shadow
                child: Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.white, width: 4),
                    boxShadow: [
                      BoxShadow(
                        color: const Color.fromARGB(
                          51,
                          0,
                          0,
                          0,
                        ), // Menggantikan withOpacity(0.2)
                        blurRadius: 10,
                        spreadRadius: 2,
                      ),
                    ],
                  ),
                  // CircleAvatar untuk membuat gambar profil bundar
                  child: const CircleAvatar(
                    // Radius diubah dari 95 menjadi 80
                    radius: 80,
                    backgroundImage: AssetImage(
                      "assets/img/profil.jpeg", // Path foto profil
                    ),
                  ),
                ),
              ),
            ],
          ),
          // SizedBox hanya untuk memberi spasi/jarak vertikal
          const SizedBox(height: 15),
          // Container untuk kartu info di bawah foto
          Container(
            decoration: BoxDecoration(
              color: const Color.fromARGB(
                255,
                231,
                235,
                238,
              ), // Warna latar kartu
              borderRadius: BorderRadius.circular(12), // Sudut melengkung
            ),
            // Column untuk menyusun widget di dalamnya secara vertikal
            child: Column(
              // Menjadikan semua widget di dalam Column ini rata tengah
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 20), // Spasi atas
                // Teks Nama
                const Text(
                  "Ncex's",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 10), // Spasi
                // Teks Subtitle/Deskripsi
                const Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 16,
                  ), // Jarak kiri-kanan
                  child: Text(
                    "Next-gen Coding Engine for Xtended Systems",
                    style: TextStyle(fontSize: 10),
                    textAlign: TextAlign.center,
                  ),
                ),
                const SizedBox(height: 20), // Spasi
                // Judul "Biodata:"
                const Text(
                  "Biodata:",
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),

                // Baris info baru (Email)
                _buildInfoRow(Icons.email, "email@example.com"),
                // Baris info baru (Telepon)
                _buildInfoRow(Icons.phone, "+62 123 456 789"),
                // Baris info baru (Lokasi)
                _buildInfoRow(Icons.location_on, "Universitas Pamulang"),

                const SizedBox(height: 20), // Spasi
                // Tombol (Kode Anda sebelumnya dipertahankan)
                ElevatedButton(
                  // onPressed adalah fungsi yg akan dipanggil saat tombol ditekan
                  onPressed: () {
                    // 1. Tampilkan dialog
                    _showadaptiveAlert(context);
                    // 2. Tampilkan SnackBar (notifikasi di bawah)
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Tombol diklik: $_counter')),
                    );
                  },
                  child: const Text("Click Me"), // Teks di dalam tombol
                ),
                const SizedBox(height: 20), // Spasi bawah
              ],
            ),
          ),
        ],
      ),
    );
  }
}
