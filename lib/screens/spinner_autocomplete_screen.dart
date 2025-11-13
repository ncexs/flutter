import 'package:flutter/material.dart';

// ===============================================
// HALAMAN PERTEMUAN 8 - SPINNER & AUTOCOMPLETE
// ===============================================

class SpinnerAutocompleteScreen extends StatefulWidget {
  const SpinnerAutocompleteScreen({super.key});

  @override
  State<SpinnerAutocompleteScreen> createState() =>
      _SpinnerAutocompleteScreenState();
}

class _SpinnerAutocompleteScreenState extends State<SpinnerAutocompleteScreen> {
  // STATE UNTUK SPINNER (DropdownButton)
  final List<String> _categories = [
    'Automobile',
    'Business Services',
    'Computers',
    'Education',
    'Personal',
    'Travel',
  ];
  String? _selectedCategory;

  // STATE UNTUK AUTOCOMPLETE
  static const List<String> _languages = [
    'C',
    'C++',
    'Java',
    'NET',
    'Phone',
    'Android',
    'ASP.NET',
    'PHP',
  ];

  @override
  void initState() {
    super.initState();
    _selectedCategory = _categories[0];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: Text(
          "Pertemuan 8 - Spinner & AutoComplete",
          style: TextStyle(color: Theme.of(context).colorScheme.onPrimary),
        ),
        backgroundColor: Theme.of(context).colorScheme.primary,
        iconTheme: IconThemeData(
          color: Theme.of(context).colorScheme.onPrimary,
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          // --- Implementasi Latihan Spinner ---
          const Text(
            "Latihan 1: Spinner (DropdownButton)",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 8),
          const Text("Category:"),
          const SizedBox(height: 8),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8.0),
              border: Border.all(color: Colors.grey.shade400),
            ),
            child: DropdownButtonHideUnderline(
              child: DropdownButton<String>(
                value: _selectedCategory,
                isExpanded: true,
                icon: Icon(
                  Icons.arrow_drop_down,
                  color: Theme.of(context).colorScheme.primary,
                ),
                items: _categories.map((String category) {
                  return DropdownMenuItem<String>(
                    value: category,
                    child: Text(category),
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  setState(() {
                    _selectedCategory = newValue;
                  });
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Spinner: Pilihan Anda: $newValue')),
                  );
                },
              ),
            ),
          ),

          const SizedBox(height: 30), // Spasi pemisah
          // --- Implementasi Contoh AutoComplete ---
          const Text(
            "Contoh 2: AutoCompleteTextView",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 8),
          const Text("What is your favourite programming language?"),
          const SizedBox(height: 8),
          Autocomplete<String>(
            optionsBuilder: (TextEditingValue textEditingValue) {
              if (textEditingValue.text == '') {
                return const Iterable<String>.empty();
              }
              return _languages.where((String option) {
                return option.toLowerCase().contains(
                  textEditingValue.text.toLowerCase(),
                );
              });
            },
            fieldViewBuilder:
                (
                  BuildContext context,
                  TextEditingController textEditingController,
                  FocusNode focusNode,
                  VoidCallback onFieldSubmitted,
                ) {
                  return TextFormField(
                    controller: textEditingController,
                    focusNode: focusNode,
                    decoration: InputDecoration(
                      hintText: "Ketik bahasa pemrograman...",
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0),
                        borderSide: BorderSide(color: Colors.grey.shade400),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0),
                        borderSide: BorderSide(color: Colors.grey.shade400),
                      ),
                    ),
                  );
                },
            onSelected: (String selection) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('AutoComplete: Pilihan Anda: $selection'),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
