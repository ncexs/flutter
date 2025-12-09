import 'package:flutter/material.dart';
// UBAH: Import WelcomePage sebagai halaman awal (bukan lagi BottomNavScreen)
// Pastikan path import sesuai dengan nama project Anda (misal: flutter_application)
import 'package:flutter_application/pages/welcome_page.dart';

// Fungsi main() adalah yang pertama kali dijalankan saat aplikasi dibuka
void main() {
  // Menjalankan widget MyApp sebagai root dari aplikasi
  runApp(const MyApp());
}

// MyApp adalah widget utama aplikasi Anda.
// Ini adalah StatelessWidget karena tampilannya tidak berubah (statis)
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // MaterialApp adalah widget dasar untuk aplikasi bergaya Material Design
    return MaterialApp(
      // TAMBAHAN: Properti ini menghilangkan pita "DEBUG" kecil di pojok kanan atas layar
      debugShowCheckedModeBanner: false,

      title: 'Aplikasi Mobile',

      // ThemeData digunakan untuk mengatur tema global aplikasi
      theme: ThemeData(
        // ColorScheme mendefinisikan palet warna aplikasi
        colorScheme: ColorScheme.fromSeed(
          // seedColor adalah warna dasar yang akan menghasilkan palet warna
          // Ini adalah warna "master" kita (Biru)
          seedColor: const Color.fromARGB(255, 6, 92, 240),
        ),
        // useMaterial3: true mengaktifkan tampilan Material Design 3 (Gaya UI terbaru Google)
        useMaterial3: true,
      ),

      // home: properti ini menentukan layar pertama yang akan dilihat pengguna
      // UBAH: Sesuai modul, aplikasi sekarang dimulai dari WelcomePage
      // (Bukan langsung ke menu utama/BottomNavScreen)
      home: const WelcomePage(),
    );
  }
}
