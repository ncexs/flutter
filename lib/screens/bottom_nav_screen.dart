import 'package:flutter/material.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';

// Import halaman-halaman
import 'home_screen.dart';
import 'profil_screen.dart';
import 'list_materi_screen.dart';

// HAPUS IMPORT INI JIKA TIDAK DIPAKAI DI _PAGES
// import 'option_context_screen.dart';

class BottomNavScreen extends StatefulWidget {
  const BottomNavScreen({super.key});

  @override
  State<BottomNavScreen> createState() => _BottomNavScreenState();
}

class _BottomNavScreenState extends State<BottomNavScreen> {
  int _currentIndex = 0;

  final List<Widget> _pages = [
    const HomeScreen(),
    const ListMateriScreen(),
    const ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    // Kita ambil scheme warna dari main.dart
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      body: _pages[_currentIndex],
      bottomNavigationBar: SalomonBottomBar(
        currentIndex: _currentIndex,
        onTap: (i) => setState(() => _currentIndex = i),
        items: [
          /// Tab Beranda
          SalomonBottomBarItem(
            icon: const Icon(Icons.home),
            title: const Text("Beranda"),
            // Menggunakan warna Utama dari main.dart
            selectedColor: colorScheme.primary,
          ),

          /// Tab Materi
          SalomonBottomBarItem(
            icon: const Icon(Icons.menu_book),
            title: const Text("Materi"),
            // Menggunakan warna Sekunder (Otomatis dibuat dari seedColor main.dart)
            // Warnanya akan berbeda tapi tetap cocok dengan Primary
            selectedColor: colorScheme.secondary,
          ),

          /// Tab Profil
          SalomonBottomBarItem(
            icon: const Icon(Icons.person),
            title: const Text("Profil"),
            // Menggunakan warna Tersier (Otomatis dibuat dari seedColor main.dart)
            // Warnanya sebagai aksen/pelengkap
            selectedColor: colorScheme.tertiary,
          ),
        ],
      ),
    );
  }
}
