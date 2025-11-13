import 'package:flutter/material.dart';

// ===============================================
// HALAMAN TEMPLATE DETAIL (STATELESS)
// ===============================================
// Ini adalah template generik untuk materi sederhana.

class DetailScreen extends StatelessWidget {
  // Deklarasikan variabel untuk menampung judul dan konten
  final String title;
  final Widget content;

  // Constructor untuk menerima data
  const DetailScreen({super.key, required this.title, required this.content});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: Text(
          title, // Gunakan judul yang dikirim
          style: TextStyle(color: Theme.of(context).colorScheme.onPrimary),
        ),
        backgroundColor: Theme.of(context).colorScheme.primary,
        iconTheme: IconThemeData(
          color: Theme.of(context).colorScheme.onPrimary,
        ),
      ),
      body: Center(
        child: content, // Tampilkan konten yang dikirim
      ),
    );
  }
}
