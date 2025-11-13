import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'dart:developer';

class CreateDataScreen extends StatefulWidget {
  const CreateDataScreen({super.key});

  @override
  State<CreateDataScreen> createState() => _CreateDataScreenState();
}

class _CreateDataScreenState extends State<CreateDataScreen> {
  DateTime _selectedDate = DateTime.now();
  TimeOfDay _selectedTime = TimeOfDay.now();

  // Fungsi untuk menampilkan DatePicker
  Future<void> _selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2030),
    );

    if (pickedDate != null && pickedDate != _selectedDate) {
      setState(() {
        _selectedDate = pickedDate;
      });
    }
  }

  // Fungsi untuk menampilkan TimePicker
  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: _selectedTime,
    );

    if (pickedTime != null && pickedTime != _selectedTime) {
      setState(() {
        _selectedTime = pickedTime;
      });
    }
  }

  // Fungsi menyimpan data
  void _saveData() {
    // Ambil warna tema di sini untuk digunakan pada SnackBar
    final Color primaryColor = Theme.of(context).colorScheme.primary;

    final String formattedDate = DateFormat('dd-MM-yyyy').format(_selectedDate);
    final String formattedTime = _selectedTime.format(context);

    log('Tanggal & Waktu yang Disimpan: $formattedDate pukul $formattedTime');

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          'Data berhasil disimpan: $formattedDate pukul $formattedTime',
        ),
        // PERBAIKAN: Menggunakan warna tema untuk SnackBar
        backgroundColor: primaryColor,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // Ambil warna primer dari tema (yang ditentukan di main.dart)
    final Color primaryColor = Theme.of(context).colorScheme.primary;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          'Create Data',
          // Teks di AppBar sebaiknya kontras dengan primaryColor, umumnya putih.
          style: TextStyle(color: Colors.white),
        ),
        // Mengambil warna background AppBar dari tema
        backgroundColor: primaryColor,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const Text(
              'Pilih Tanggal',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            // Tombol untuk DatePicker
            ElevatedButton.icon(
              onPressed: () => _selectDate(context),
              icon: const Icon(Icons.calendar_today, size: 20),
              label: Text(
                DateFormat('dd-MM-yyyy').format(_selectedDate),
                style: const TextStyle(fontSize: 16),
              ),
              style: ElevatedButton.styleFrom(
                // Menggunakan warna tombol dari tema
                backgroundColor: primaryColor,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 10,
                ),
              ),
            ),
            const SizedBox(height: 30),

            const Text(
              'Pilih Waktu',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            // Tombol untuk TimePicker
            ElevatedButton.icon(
              onPressed: () => _selectTime(context),
              icon: const Icon(Icons.access_time, size: 20),
              label: Text(
                _selectedTime.format(context),
                style: const TextStyle(fontSize: 16),
              ),
              style: ElevatedButton.styleFrom(
                // Menggunakan warna tombol dari tema
                backgroundColor: primaryColor,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 10,
                ),
              ),
            ),
            const Expanded(child: SizedBox()),

            // Tombol Simpan Data
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _saveData,
                style: ElevatedButton.styleFrom(
                  // PERBAIKAN: Menggunakan warna tema untuk tombol Simpan Data
                  backgroundColor: primaryColor,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 15),
                ),
                child: const Text(
                  'Simpan Data',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
