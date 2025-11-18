import 'package:flutter/material.dart';

// 1. IMPORT SEMUA FILE BARU ANDA
import 'detail_screen.dart'; // Template materi 1-5, 7
import 'checkbox_screen.dart'; // Materi Pertemuan 6
import 'spinner_autocomplete_screen.dart'; // Materi Pertemuan 8
import 'create_data_screen.dart'; // Materi Pertemuan 9
// WAJIB DITAMBAHKAN: Import TabLayoutScreen untuk Pertemuan 10
import 'tab_layout_screen.dart';

// ===============================================
// HALAMAN DAFTAR MATERI (STATELESS)
// ===============================================
class ListMateriScreen extends StatelessWidget {
  const ListMateriScreen({super.key});

  // Fungsi helper untuk membuat konten "Toast and AlertDialog"
  Widget _buildToastAlertContent(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ElevatedButton(
          onPressed: () {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(const SnackBar(content: Text('Ini adalah Toast!')));
          },
          child: const Text('Toast'),
        ),
        const SizedBox(height: 16),
        ElevatedButton(
          onPressed: () {
            showDialog(
              context: context,
              builder: (context) => AlertDialog(
                title: const Text('Contoh Alert'),
                content: const Text('Ini adalah AlertDialog.'),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text('OK'),
                  ),
                ],
              ),
            );
          },
          child: const Text('AlertDialog'),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    // Daftar semua materi pertemuan
    final List<Map<String, String>> materiList = [
      {'judul': 'Pertemuan 1', 'sub': 'Instalasi Flutter'},
      {'judul': 'Pertemuan 2', 'sub': 'Pengenalan Widget'},
      {'judul': 'Pertemuan 3', 'sub': 'Activity & Intent'},
      {'judul': 'Pertemuan 4', 'sub': 'Toast & Alert Dialog (Contoh)'},
      {'judul': 'Pertemuan 5', 'sub': 'Materi (Belum Diisi)'},
      {'judul': 'Pertemuan 6', 'sub': 'Bekerja dengan CheckBox'},
      {'judul': 'Pertemuan 7', 'sub': 'Project UTS'},
      {'judul': 'Pertemuan 8', 'sub': 'Spinner & AutoComplete'},
      {'judul': 'Pertemuan 9', 'sub': 'DatePicker & TimePicker'},
      // PERUBAHAN: Tambahkan Pertemuan 10
      {'judul': 'Pertemuan 10', 'sub': 'Contoh Penggunaan TabLayout'},
    ];

    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        title: Text(
          'My Books',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Theme.of(context).colorScheme.onPrimary,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.only(top: 8, bottom: 12, left: 8),
              child: Text(
                'Daftar Pertemuan',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: materiList.length,
                itemBuilder: (context, index) {
                  final item = materiList[index];

                  return Card(
                    margin: const EdgeInsets.symmetric(
                      vertical: 6,
                      horizontal: 8,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: ListTile(
                      leading: Icon(
                        Icons.menu_book,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                      title: Text(
                        item['judul']!,
                        style: const TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 16,
                        ),
                      ),
                      subtitle: Text(item['sub']!),
                      trailing: const Icon(Icons.arrow_forward_ios, size: 18),

                      // 2. LOGIKA ONTAP DENGAN NAMA CLASS BARU
                      onTap: () {
                        switch (item['judul']) {
                          // Kasus untuk halaman detail SEDERHANA
                          case 'Pertemuan 1':
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                // MEMANGGIL CLASS DetailScreen
                                builder: (context) => DetailScreen(
                                  title: item['judul']!,
                                  content: const Text("Hello"),
                                ),
                              ),
                            );
                            break;
                          case 'Pertemuan 2':
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                // MEMANGGIL CLASS DetailScreen
                                builder: (context) => DetailScreen(
                                  title: item['judul']!,
                                  content: const Text("Isi Materi Pertemuan 2"),
                                ),
                              ),
                            );
                            break;
                          case 'Pertemuan 3':
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                // MEMANGGIL CLASS DetailScreen
                                builder: (context) => DetailScreen(
                                  title: item['judul']!,
                                  content: const Text("Isi Materi Pertemuan 3"),
                                ),
                              ),
                            );
                            break;
                          case 'Pertemuan 4':
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                // MEMANGGIL CLASS DetailScreen
                                builder: (context) => DetailScreen(
                                  title: "Toast and AlertDialog",
                                  content: _buildToastAlertContent(context),
                                ),
                              ),
                            );
                            break;
                          case 'Pertemuan 5':
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                // MEMANGGIL CLASS DetailScreen
                                builder: (context) => DetailScreen(
                                  title: item['judul']!,
                                  content: const Text("Isi Materi Pertemuan 5"),
                                ),
                              ),
                            );
                            break;
                          case 'Pertemuan 7':
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                // MEMANGGIL CLASS DetailScreen
                                builder: (context) => DetailScreen(
                                  title: item['judul']!,
                                  content: const Text("Isi Materi Project UTS"),
                                ),
                              ),
                            );
                            break;

                          // Kasus untuk halaman KOMPLEKS (file sendiri)
                          case 'Pertemuan 6':
                            // MEMANGGIL CLASS CheckboxScreen
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const CheckboxScreen(),
                              ),
                            );
                            break;
                          case 'Pertemuan 8':
                            // MEMANGGIL CLASS SpinnerAutocompleteScreen
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    const SpinnerAutocompleteScreen(),
                              ),
                            );
                            break;
                          case 'Pertemuan 9':
                            // MEMANGGIL CLASS CreateDataScreen
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const CreateDataScreen(),
                              ),
                            );
                            break;
                          // PERUBAHAN: Tambahkan case untuk Pertemuan 10
                          case 'Pertemuan 10':
                            // MEMANGGIL CLASS TabLayoutScreen
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const TabLayoutScreen(),
                              ),
                            );
                            break;
                          default:
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text('${item['judul']} dibuka'),
                              ),
                            );
                        }
                      },
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
