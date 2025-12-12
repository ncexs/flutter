# 🚀 Aplikasi Mobile Flutter

![Flutter](https://img.shields.io/badge/Flutter-%2302569B.svg?style=for-the-badge&logo=Flutter&logoColor=white)
![Dart](https://img.shields.io/badge/dart-%230175C2.svg?style=for-the-badge&logo=dart&logoColor=white)

> **⚠️ PENTING:** Proyek ini adalah implementasi tugas Mobile Programming (Pertemuan 1 - 13).
> Dokumen ini berisi panduan bagian mana saja yang **WAJIB DIMODIFIKASI** agar aplikasi memiliki identitas sendiri dan tidak dianggap plagiat.

---

## 🛠️ **PANDUAN MODIFIKASI (Checklist Wajib)**

Ikuti langkah-langkah di bawah ini untuk mengubah identitas aplikasi.

### **1. ⚙️ Modifikasi Utama (Global)**
*Bagian ini mengubah identitas dasar aplikasi.*

| **Bagian** | **Lokasi File** | **Instruksi Perubahan** |
|------------|-----------------|-------------------------|
| **Warna Tema** | `lib/main.dart` | Ganti `seedColor: Color.fromARGB(...)` dengan warna pilihan Anda. |
| **Palet Warna** | `lib/style/color.dart` | Sesuaikan `primaryColor`, `buttonColor`, dll agar senada dengan tema baru. |
| **Judul App** | `lib/main.dart` | Ubah properti `title: '...'` menjadi nama aplikasi Anda. |
| **Nama Proyek** | `pubspec.yaml` | Ganti `name: flutter_application` dengan nama unik (huruf kecil, tanpa spasi). |
| **Aset Gambar** | `assets/img/` | Timpa file `background2.jpeg` & `office.png` dengan gambar baru milik Anda. |
| **Navigasi** | `bottom_nav_screen.dart` | Ganti label tab (misal: `Books` ➝ `Materi`) dan ikonnya. |

---

### **2. 🔐 Modifikasi Halaman Autentikasi**
*Halaman pertama yang dilihat pengguna (Login, Register, Welcome).*

| **Bagian** | **Lokasi File** | **Instruksi Perubahan** |
|------------|-----------------|-------------------------|
| **Sambutan** | `welcome_page.dart` | Ubah teks `"Discover your Dream"` dengan slogan aplikasi Anda. |
| **Ilustrasi** | `welcome_page.dart` | Pastikan nama file gambar sesuai dengan aset baru Anda. |
| **Form Login** | `login_page.dart` | Ubah judul `"Welcome Back"` atau hint text pada input. |
| **Form Register**| `register_page.dart` | Ubah judul `"Get Started"` atau label input. |
| **Background** | `custom_scaffold.dart` | Pastikan path gambar background sesuai dengan file baru Anda. |

---

### **3. 👤 Modifikasi Layar Profil**
*Halaman biodata diri mahasiswa.*

| **Bagian** | **Lokasi File** | **Instruksi Perubahan** |
|------------|-----------------|-------------------------|
| **Biodata** | `profil_screen.dart` | **Wajib:** Ganti Nama, Email, NIM, dan Kampus dengan data Anda. |
| **Tombol** | `profil_screen.dart` | Ubah pesan pada `_showadaptiveAlert` agar berbeda. |
| **Tampilan** | `profil_screen.dart` | Ganti warna container atau bentuk foto profil. |

---

### **4. 📦 Modifikasi Input & Data (Pertemuan 6-13)**

#### **A. Checkbox & Pilihan (Pertemuan 6)**
* **File:** `checkbox_screen.dart`
* **Ubah:** Ganti daftar hobi default ('Painting', 'Reading') menjadi skill atau kegemaran lain.
* **Ubah:** Edit pesan SnackBar yang muncul saat tombol ditekan.

#### **B. Spinner & Autocomplete (Pertemuan 8)**
* **File:** `spinner_autocomplete_screen.dart`
* **Ubah:** Ganti data list `_categories` dan `_languages` dengan topik lain.
* **Ubah:** Ganti `hintText` atau ikon pada form input.

#### **C. Input Waktu (Pertemuan 9)**
* **File:** `create_data_screen.dart`
* **Ubah:** Modifikasi format tanggal atau pesan sukses pada fungsi `_saveData`.

#### **D. Tab Layout (Pertemuan 10)**
* **File:** `tab_layout_screen.dart`
* **Ubah:** Ganti jumlah tab, ikon, dan label judul tab.

#### **E. Pencarian (Pertemuan 11)**
* **File:** `search_view_screen.dart`
* **Ubah:** Ganti data dummy `allMonths` menjadi data lain (misal: Daftar Teman, Daftar Buah).

#### **F. Menu (Pertemuan 12)**
* **File:** `option_context_screen.dart`
* **Option Menu:** Ganti item menu (misal: 'Settings' ➝ 'Pengaturan').
* **Context Menu:** Ganti opsi Long Press (misal: 'Edit' ➝ 'Ubah').

#### **G. Multimedia Audio & Video (Pertemuan 13)**
* **File:** `multimedia_screen.dart`
* **Aset:** Ganti file `music.mp3` di folder `assets/audio/` dan `video.mp4` di `assets/video/` dengan file milikmu.
* **Ubah:** Ganti gambar cover album di tampilan Audio Player.

---

## 💻 **CARA RUN**

### **Cara Menjalankan Aplikasi**
1.  **Install Library** (Wajib saat pertama kali download):
    ```bash
    flutter pub get
    ```
2.  **Jalankan Aplikasi**:
    ```bash
    flutter run
    ```

### **⚠️ Troubleshooting (Solusi Error)**

| **Masalah** | **Solusi** |
|------------|------------------------|
| **Gambar/Video Hilang** | Cek folder `assets/`. Pastikan nama file sama persis dengan di kodingan (huruf besar/kecil berpengaruh). |
| **Video Lag (Patah-patah)** | Ini wajar di Emulator/Debug Mode. Coba jalankan di HP asli atau gunakan mode release (`flutter run -d chrome --release`). |
| **Error Nama Proyek** | Jika mengganti nama di `pubspec.yaml`, jalankan `flutter clean` lalu `flutter pub get`. |
| **Symlink (Windows)** | Jika muncul error symlink, jalankan VS Code sebagai **Administrator**. |

---

## 📦 **Packages yang Digunakan**
* `flutter/material.dart`
* [`salomon_bottom_bar`](https://pub.dev/packages/salomon_bottom_bar)
* [`icons_plus`](https://pub.dev/packages/icons_plus)
* [`intl`](https://pub.dev/packages/intl)
* [`adaptive_dialog`](https://pub.dev/packages/adaptive_dialog)
* [`audioplayers`](https://pub.dev/packages/audioplayers) (Pertemuan 13)
* [`video_player`](https://pub.dev/packages/video_player) (Pertemuan 13)
* [`chewie`](https://pub.dev/packages/chewie) (Pertemuan 13)