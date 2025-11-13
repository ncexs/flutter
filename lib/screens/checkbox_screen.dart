import 'package:flutter/material.dart';

// ==========================================================
// HALAMAN PERTEMUAN 6 - CHECKBOX (STATEFUL)
// ==========================================================

class CheckboxScreen extends StatefulWidget {
  const CheckboxScreen({super.key});

  @override
  State<CheckboxScreen> createState() => _CheckboxScreenState();
}

class _CheckboxScreenState extends State<CheckboxScreen> {
  // Variabel state untuk menyimpan status hobi
  bool paintingChecked = false;
  bool readingChecked = false;
  bool singingChecked = false;
  bool cookingChecked = false;

  // Fungsi ini dipanggil saat tombol SUBMIT ditekan
  void _showHobbies() {
    List<String> selectedHobbies = [];
    if (paintingChecked) selectedHobbies.add("Painting");
    if (readingChecked) selectedHobbies.add("Reading");
    if (singingChecked) selectedHobbies.add("Singing");
    if (cookingChecked) selectedHobbies.add("Cooking");

    String resultText;
    if (selectedHobbies.isEmpty) {
      resultText = "No hobbies selected";
    } else {
      resultText = "${selectedHobbies.join(' ')} are selected";
    }

    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(resultText)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: Text(
          "Pertemuan 6 - Checkbox",
          // Menggunakan warna teks onPrimary dari Tema
          style: TextStyle(color: Theme.of(context).colorScheme.onPrimary),
        ),
        // Menggunakan warna primary dari Tema
        backgroundColor: Theme.of(context).colorScheme.primary,
        iconTheme: IconThemeData(
          color: Theme.of(context).colorScheme.onPrimary,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Choose your hobbies:",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 10),
            CheckboxListTile(
              title: const Text("Painting"),
              value: paintingChecked,
              activeColor: Theme.of(context).colorScheme.primary,
              onChanged: (value) {
                setState(() {
                  paintingChecked = value!;
                });
              },
            ),
            CheckboxListTile(
              title: const Text("Reading"),
              value: readingChecked,
              activeColor: Theme.of(context).colorScheme.primary,
              onChanged: (value) {
                setState(() {
                  readingChecked = value!;
                });
              },
            ),
            CheckboxListTile(
              title: const Text("Singing"),
              value: singingChecked,
              activeColor: Theme.of(context).colorScheme.primary,
              onChanged: (value) {
                setState(() {
                  singingChecked = value!;
                });
              },
            ),
            CheckboxListTile(
              title: const Text("Cooking"),
              value: cookingChecked,
              activeColor: Theme.of(context).colorScheme.primary,
              onChanged: (value) {
                setState(() {
                  cookingChecked = value!;
                });
              },
            ),
            const SizedBox(height: 20),
            Center(
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _showHobbies,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Theme.of(context).colorScheme.primary,
                    foregroundColor: Theme.of(context).colorScheme.onPrimary,
                  ),
                  child: const Text("SUBMIT"),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
