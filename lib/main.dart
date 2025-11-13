import 'package:flutter/material.dart';
// Import file yang berisi navigasi utama (BottomNavScreen)
import 'package:flutter_application/screens/bottom_nav_screen.dart';

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
      title: 'Aplikasi Mobile',
      // ThemeData digunakan untuk mengatur tema global aplikasi
      theme: ThemeData(
        // ColorScheme mendefinisikan palet warna aplikasi
        colorScheme: ColorScheme.fromSeed(
          // seedColor adalah warna dasar yang akan menghasilkan palet warna
          // Ini adalah warna "master" kita
          seedColor: const Color.fromARGB(255, 6, 92, 240),
        ),
        // useMaterial3: true mengaktifkan tampilan Material Design 3
        useMaterial3: true,
      ),
      // home: properti ini menentukan layar pertama yang akan dilihat pengguna
      home: BottomNavScreen(),
    );
  }
}
