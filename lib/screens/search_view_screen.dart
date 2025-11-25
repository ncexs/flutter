import 'package:flutter/material.dart';

// Definisi data sumber (12 bulan)
const List<String> allMonths = [
  'Januari',
  'Februari',
  'Maret',
  'April',
  'Mei',
  'Juni',
  'Juli',
  'Agustus',
  'September',
  'Oktober',
  'November',
  'Desember',
];

class SearchViewScreen extends StatefulWidget {
  const SearchViewScreen({super.key});

  @override
  State<SearchViewScreen> createState() => _SearchViewScreenState();
}

class _SearchViewScreenState extends State<SearchViewScreen> {
  // Controller untuk mengambil input dari TextField
  final TextEditingController _searchController = TextEditingController();

  // Daftar yang akan ditampilkan (awalnya sama dengan semua bulan)
  List<String> _filteredMonths = allMonths;

  // Fungsi untuk memfilter daftar secara real-time
  void _filterList(String query) {
    final List<String> suggestions = allMonths.where((month) {
      // Ubah query dan bulan menjadi huruf kecil untuk pencarian case-insensitive
      return month.toLowerCase().contains(query.toLowerCase());
    }).toList();

    // Memperbarui UI dengan daftar yang sudah difilter
    setState(() {
      _filteredMonths = suggestions;
    });
  }

  @override
  void initState() {
    super.initState();
    // Inisialisasi daftar saat pertama kali dimuat
    _filteredMonths = allMonths;

    // Tambahkan listener untuk memicu filter setiap kali teks berubah
    _searchController.addListener(() {
      _filterList(_searchController.text);
    });
  }

  @override
  void dispose() {
    // Bersihkan controller saat widget dihapus
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Color primaryColor = Theme.of(context).colorScheme.primary;
    final Color onPrimaryColor = Theme.of(context).colorScheme.onPrimary;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Pertemuan 11: Search View (Real-time)',
          style: TextStyle(color: onPrimaryColor),
        ),
        backgroundColor: primaryColor,
        iconTheme: IconThemeData(color: onPrimaryColor),
      ),
      body: Column(
        children: <Widget>[
          // 1. Kolom Pencarian (TextField)
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Cari Bulan...',
                prefixIcon: const Icon(Icons.search),
                suffixIcon: IconButton(
                  icon: const Icon(Icons.clear),
                  onPressed: () {
                    // Membersihkan teks pencarian dan me-reset filter
                    _searchController.clear();
                    _filterList('');
                  },
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
          ),

          // 2. Daftar Hasil (ListView yang sudah difilter)
          Expanded(
            child: _filteredMonths.isEmpty
                ? const Center(
                    child: Text(
                      'Tidak ada bulan yang cocok.',
                      style: TextStyle(fontSize: 16, color: Colors.grey),
                    ),
                  )
                : ListView.builder(
                    itemCount: _filteredMonths.length,
                    itemBuilder: (context, index) {
                      final month = _filteredMonths[index];
                      return ListTile(
                        title: Text(month),
                        onTap: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('Anda memilih: $month'),
                              backgroundColor: primaryColor,
                            ),
                          );
                        },
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
