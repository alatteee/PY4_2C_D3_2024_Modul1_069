# 📱 LogBook App: Multi-Step Counter & History Logger

[![Framework](https://img.shields.io/badge/Framework-Flutter-blue.svg)](https://flutter.dev/)
[![Language](https://img.shields.io/badge/Language-Dart-blue.svg)](https://dart.dev/)
[![Principles](https://img.shields.io/badge/Principles-SRP-green.svg)](https://en.wikipedia.org/wiki/Single_responsibility_principle)

Aplikasi mobile sederhana yang dibangun dengan **Flutter** untuk mendemonstrasikan penerapan **Single Responsibility Principle (SRP)** dan manajemen state dasar. Proyek ini merupakan bagian dari tugas **Modul 1 Praktikum Proyek 4**.

---

## 🌟 Fitur Utama

***Multi-Step Counter**: Menambah atau mengurangi nilai angka berdasarkan input "Step" yang dinamis. 
***History Logger**: Mencatat setiap aktivitas (Tambah, Kurang, Reset) lengkap dengan waktu kejadian. 
***Smart History Limit**: Mengelola memori dengan hanya menampilkan **5 aktivitas terakhir** saja.
* **Professional UI/UX**:
    *Tampilan modern menggunakan **Gradient Card**. 
    *Indikator warna pada riwayat (Hijau untuk Tambah, Merah untuk Kurang). 
    *Dialog konfirmasi dan **SnackBar** untuk aksi Reset agar data tidak hilang tidak sengaja. 

---

## 🧠 Self-Reflection: Implementasi Prinsip SRP

**"Bagaimana prinsip SRP membantu saat harus menambah fitur History Logger tadi?"** 

Penerapan prinsip **Single Responsibility Principle (SRP)** sangat mempermudah proses pengembangan, terutama saat menambahkan fitur *History Logger*. Karena kode telah dipisahkan, saya hanya perlu memodifikasi file `counter_controller.dart` untuk menangani struktur data `List<String>` dan logika manipulasi riwayat tanpa perlu mengkhawatirkan kode antarmuka. Pemisahan antara mana yang bertugas "berpikir" (*Controller*) dan mana yang bertugas "tampil estetis" (*View*) membuat aplikasi lebih mudah dikembangkan.

---

## 🛠️ Struktur Proyek

Sesuai dengan panduan modul, struktur kode dibagi menjadi:

```text
lib/
├── main.dart                <-- Entry point: Menjalankan MyApp & CounterView
├── counter_controller.dart  <-- Logika: Angka, Step, List Riwayat
└── counter_view.dart        <-- Antarmuka: Tombol, Teks, Dialog, SnackBar
