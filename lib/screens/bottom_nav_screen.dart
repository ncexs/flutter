import 'package:flutter/material.dart';
// Import library eksternal untuk bottom bar
import 'package:awesome_bottom_bar/awesome_bottom_bar.dart';
// Import file-file layar yang akan ditampilkan di tiap tab
import 'home_screen.dart'; // Layar Tab 0
import 'profil_screen.dart'; // Layar Tab 1
import 'list_materi_screen.dart'; // Layar Tab 2

// Ini adalah StatefulWidget.
// Tampilannya (tab yang aktif) bisa berubah berdasarkan interaksi user.
class BottomNavScreen extends StatefulWidget {
  const BottomNavScreen({super.key});

  @override
  // Menghubungkan widget ini dengan class State-nya
  State<BottomNavScreen> createState() => _BottomNavScreenState();
}

// Class State untuk BottomNavScreen
class _BottomNavScreenState extends State<BottomNavScreen> {
  // Variabel state untuk menyimpan nomor tab yang sedang aktif.
  // Dimulai dari 0 (tab pertama).
  int _currentIndex = 0;

  // _pages adalah daftar widget/layar yang akan ditampilkan
  // Urutannya HARUS sesuai dengan urutan TabItem di bawah
  final List<Widget> _pages = [
    HomeScreen(), // Indeks 0 (akan dipanggil saat _currentIndex == 0)
    ProfileScreen(), // Indeks 1 (akan dipanggil saat _currentIndex == 1)
    ListMateriScreen(), // Indeks 2 (akan dipanggil saat _currentIndex == 2)
  ];

  @override
  Widget build(BuildContext context) {
    // Scaffold adalah kerangka dasar halaman
    return Scaffold(
      // body: menampilkan layar dari _pages berdasarkan _currentIndex
      // Jika _currentIndex adalah 1, maka _pages[1] (ProfileScreen) akan tampil.
      body: _pages[_currentIndex],

      // bottomNavigationBar: menampilkan bilah navigasi di bawah
      bottomNavigationBar: BottomBarDefault(
        // items: daftar tab yang akan ditampilkan
        items: const [
          TabItem(icon: Icons.home, title: 'Beranda'), // Tab Indeks 0
          TabItem(icon: Icons.person, title: 'Profil'), // Tab Indeks 1
          TabItem(icon: Icons.menu_book, title: 'Books'), // Tab Indeks 2
        ],
        backgroundColor: Colors.white, // Latar belakang bottom bar
        color: Colors.grey, // Warna ikon & teks saat tidak aktif
        // Menggunakan warna primary dari Tema
        colorSelected: Theme.of(context).colorScheme.primary,
        // =======================

        // Memberi tahu widget BottomBar, tab mana yang harus di-highlight
        indexSelected: _currentIndex,

        // onTap: fungsi yang akan dijalankan saat salah satu tab diketuk
        // 'index' adalah nomor tab yang baru saja diketuk
        onTap: (index) {
          // setState() memberi tahu Flutter untuk "membangun ulang" widget
          // karena ada perubahan data (yaitu _currentIndex)
          setState(() {
            _currentIndex = index; // Update nilai _currentIndex
          });
        },
      ),
    );
  }
}
