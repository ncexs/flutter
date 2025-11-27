# 🚀 **[GANTI DENGAN NAMA APLIKASI ANDA] (Wajib Diubah)**

Dokumen ini menjelaskan bagian–bagian proyek Flutter yang **harus Anda modifikasi** agar aplikasi memiliki identitas sendiri dan tidak sama dengan contoh bawaan.

# **1. ⚙️ Modifikasi Utama (Semua Pertemuan)**

| **Bagian** | **Lokasi** | **Yang Harus Diubah** |
|------------|------------|------------------------|
| **Warna Tema Utama** | lib/main.dart → properti **seedColor** | Ganti warna bawaan `Color.fromARGB(255, 6, 92, 240)` dengan warna lain yang Anda pilih. |
| **Judul Aplikasi** | lib/main.dart → **title** | Ubah `'Aplikasi Mobile'` menjadi nama aplikasi Anda sendiri. |
| **Nama Proyek** | pubspec.yaml → **name:** | Ganti `flutter_application` dengan nama proyek Anda. |
| **Aset Gambar** | folder `assets/img/` dan `profil_screen.dart` | Ganti `background.jpeg` dan `profil.jpeg` dengan gambar milik Anda dan sesuaikan path di kode. |
| **Item Navigasi** | bottom_nav_screen.dart | Ganti label dan ikon tab (misal: dari `Books` menjadi `Materi`, `Tugas`, dll). |

# **2. 👤 Modifikasi Layar Profil (profil_screen.dart)**

| **Bagian** | **Lokasi** | **Yang Harus Diubah** |
|------------|------------|------------------------|
| **Data Biodata** | profil_screen.dart → bagian `_buildInfoRow` | Ganti email, nomor HP, dan kampus dengan data Anda sendiri. |
| **Logika Tombol** | profil_screen.dart → `_showadaptiveAlert` | Ganti pesan alert dan snackbar, atau tambahkan fungsi lain selain `_incrementCounter()`. |
| **Tampilan Card** | profil_screen.dart | Ubah warna background container biodata. |

# **3. 📦 Modifikasi Pilihan (Pertemuan 6 & 8)**

## **A. Checkbox & Radio Button**

| **Bagian** | **Lokasi** | **Yang Harus Diubah** |
|------------|------------|------------------------|
| **Daftar Hobi/Opsi** | checkbox_screen.dart | Ganti opsi 'Painting', 'Reading', dll menjadi daftar baru. |
| **Pesan Submit** | checkbox_screen.dart → `_showHobbies` | Ubah teks hasil yang muncul di snackbar. |

## **B. Spinner & Autocomplete**

| **Bagian** | **Lokasi** | **Yang Harus Diubah** |
|------------|------------|------------------------|
| **Data Spinner** | spinner_autocomplete_screen.dart → `_categories` | Ganti daftar kategori. |
| **Data Autocomplete** | spinner_autocomplete_screen.dart → `_languages` | Ganti daftar autocomplete. |
| **Tampilan Input** | spinner_autocomplete_screen.dart | Tambah prefixIcon, ubah hintText, atau ubah border. |

# **4. 📅 Modifikasi Input Waktu (create_data_screen.dart)**

| **Bagian** | **Lokasi** | **Yang Harus Diubah** |
|------------|------------|------------------------|
| **Logika Simpan** | create_data_screen.dart → `_saveData` | Ubah detail data yang ditampilkan, format tanggal/waktu, dll. |
| **Tampilan Tombol** | create_data_screen.dart | Ubah bentuk tombol atau padding. |

# **5. 📑 Modifikasi Tab Layout (Pertemuan 10)**

| **Bagian** | **Lokasi** | **Yang Harus Diubah** |
|------------|------------|------------------------|
| **Jumlah Tab** | tab_layout_screen.dart | Ubah `length: 3` menjadi angka lain. |
| **Isi Tab** | tab_layout_screen.dart | Ganti ikon/label tab. |
| **Konten Tab** | tab_layout_screen.dart | Ubah konten yang ditampilkan di TabBarView. |

# **6. 🔍 Modifikasi Pencarian (Pertemuan 11)**

| **Bagian** | **Lokasi** | **Yang Harus Diubah** |
|------------|------------|------------------------|
| **Data Sumber** | search_view_screen.dart → `allMonths` | Ganti seluruh list bulan menjadi data lain sesuai aplikasi Anda. |
| **Tampilan Item Daftar** | search_view_screen.dart | Ubah ListTile jadi Card, atau tambah icon/subtitle. |
| **Dekorasi Search** | search_view_screen.dart | Ubah hintText, prefixIcon, atau bentuk border. |
