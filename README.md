# 📚 My Books Flutter App (Update Pertemuan 11)

Aplikasi ini berisi kumpulan materi praktikum Mobile Programming 1 yang diimplementasikan menggunakan Flutter.

## ✨ Yang Baru: Pertemuan 11 - Search View

Pembaruan utama dalam versi ini adalah implementasi fitur pencarian real-time untuk memfilter daftar.

| File Baru | Deskripsi |
| :--- | :--- |
| `lib/screens/search_view_screen.dart` | Implementasi fitur filter **real-time** menggunakan `TextField` dan `ListView.builder`. |
| `lib/list_materi_screen.dart` | Penambahan item **Pertemuan 11: Bekerja dengan Search View (Filter List)**. |

-----

## 🎨 Modifikasi Tampilan & Fungsi

Fitur Search View pada Pertemuan 11 dirancang agar mudah diubah tampilannya. Berikut adalah beberapa bagian yang dapat dimodifikasi di file **`lib/screens/search_view_screen.dart`** untuk membuat tampilan yang berbeda:

### 1\. Mengubah Data Sumber 📝

Secara *default*, daftar ini menampilkan 12 bulan.

  * **Tujuan Modifikasi:** Mengubah daftar yang difilter (misalnya menjadi daftar nama hewan, mata kuliah, atau kota).
  * **Baris Kode:** Di bagian atas file.

<!-- end list -->

```dart
// search_view_screen.dart

// Ubah data di sini sesuai kebutuhan
const List<String> allMonths = [
  'Januari',
  'Februari',
  'Maret',
  // ... dst
];
```

### 2\. Mengubah Tampilan Item Daftar 🎴

Anda dapat mengubah bagaimana setiap item daftar (`ListTile`) ditampilkan.

  * **Tujuan Modifikasi:** Menambahkan *leading icon*, *subtitle*, atau mengubah warna teks.
  * **Lokasi Kode:** Di dalam widget `ListView.builder`.

#### Contoh Modifikasi (Menambahkan Icon dan Warna Kontainer):

Ubah bagian `ListTile` di dalam `ListView.builder` menjadi seperti ini:

```dart
// search_view_screen.dart (di dalam build pada ListView.builder)
// ...
return Padding(
  padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
  child: Card( // Gunakan Card untuk tampilan yang lebih modern
    elevation: 2,
    child: ListTile(
      leading: Icon(Icons.calendar_today, color: primaryColor), // Tambah Icon
      title: Text(
        month, 
        style: const TextStyle(fontWeight: FontWeight.bold),
      ),
      subtitle: Text('Ini adalah Bulan $month'), // Tambah Subtitle
      onTap: () {
        // ... kode SnackBar
      },
    ),
  ),
);
```

### 3\. Mengubah Dekorasi Kolom Pencarian (TextField) 🔍

Kolom pencarian (`TextField`) dapat diubah untuk memiliki bentuk, warna, atau ikon yang berbeda.

  * **Tujuan Modifikasi:** Mengubah bentuk border, warna latar belakang, atau ikon hint.
  * **Lokasi Kode:** Di dalam properti `decoration` pada `TextField`.

#### Contoh Modifikasi (Mengubah Bentuk Border):

Ubah `border: OutlineInputBorder(...)` menjadi `border: UnderlineInputBorder()` atau gunakan warna berbeda:

```dart
// search_view_screen.dart (di dalam TextField)
// ...
decoration: InputDecoration(
  hintText: 'Cari Sesuatu...',
  prefixIcon: const Icon(Icons.filter_alt), // Mengubah ikon
  filled: true,
  fillColor: Colors.grey[100], // Menambahkan warna latar belakang
  border: UnderlineInputBorder(
    borderSide: BorderSide(color: primaryColor, width: 2),
  ),
),
// ...
```

-----

## ⚙️ Modifikasi Tema Global

Untuk mengubah warna aplikasi secara keseluruhan (AppBar, tombol, SnackBar), ubah nilai **`seedColor`** di file **`main.dart`**.

```dart
// main.dart
// ...
theme: ThemeData(
  colorScheme: ColorScheme.fromSeed(seedColor: Colors.purple), // Ganti Colors.purple ke warna lain
  useMaterial3: true,
),
// ...
```