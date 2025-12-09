import 'package:flutter/material.dart';

class CustomScaffold extends StatelessWidget {
  const CustomScaffold({super.key, this.child, this.appBar});

  final Widget? child;
  final PreferredSizeWidget? appBar;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar,
      extendBodyBehindAppBar: true,
      body: Stack(
        children: [
          // Gambar Background Full Screen
          Image.asset(
            "assets/img/background2.jpeg", // Pastikan file ini ada
            fit: BoxFit.cover,
            width: double.infinity,
            height: double.infinity,
          ),
          // Area Konten Aman
          SafeArea(child: child!),
        ],
      ),
    );
  }
}
