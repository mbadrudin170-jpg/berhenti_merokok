---
description: Tambahkan log debug untuk memantau nilai variabel dan parameter hanya pada file Dart yang ditentukan pengguna.
agent: code
---

# Tambahkan Log Debug

## 1. Tujuan

Tambahkan log debug pada setiap variabel dan parameter yang relevan di file Dart yang secara khusus ditentukan pengguna.

Gunakan sistem logging yang sudah tersedia di proyek, yaitu `L.i()`, `L.w()`, dan `L.e()` dari:

`lib/shared/utils/l.dart`

Fokus utama adalah menampilkan nilai aktual variabel agar pengguna dapat mengetahui data yang sedang diproses ketika program berjalan.

Log harus sederhana, singkat, dan mudah dibaca. Jangan membuat pesan yang terlalu deskriptif.

## 2. Batasan File

1. Hanya tambahkan log pada file yang ditentukan pengguna.
2. Jangan menambahkan log pada file lain.
3. File lain boleh dibaca untuk memahami alur eksekusi dan urutan inisialisasi.
4. Jangan mengubah `lib/shared/utils/l.dart`.
5. Jangan mengubah file generated seperti `.g.dart` dan `.freezed.dart`.
6. Jika pengguna belum menentukan file target, tanyakan terlebih dahulu.
7. Jangan memperluas cakupan pekerjaan ke seluruh proyek.

## 3. Aturan Penempatan Log

Tambahkan log pada setiap variabel dan parameter yang relevan.

Prioritaskan:

1. Parameter yang diterima fungsi atau method.
2. Variabel lokal setelah mendapatkan nilai.
3. Variabel setelah mengalami perubahan nilai.
4. Data sebelum dikirim ke repository, database, atau API.
5. Data hasil dari repository, database, atau API.
6. Nilai state sebelum dan sesudah perubahan.
7. Nilai yang digunakan dalam percabangan apabila diperlukan untuk mengetahui alasan kondisi tersebut terpenuhi.

Ketentuan:

- Log harus ditempatkan setelah variabel mendapatkan nilainya.
- Jika beberapa variabel tersedia pada titik eksekusi yang sama, gabungkan dalam satu log.
- Jangan mencatat variabel yang sama berulang kali apabila nilainya belum berubah.
- Jika nilai variabel berubah, catat kembali nilai terbarunya pada titik yang relevan.
- Jangan mengubah urutan proses hanya demi menambahkan log.
- Jangan menambahkan log yang tidak memberikan informasi nilai aktual.

## 4. Penggunaan L.i()

Gunakan `L.i()` untuk mencatat nilai variabel dan parameter dalam alur normal program.

Format harus sederhana. Cukup nama variabel dan nilainya.

Contoh:

```dart
L.i('kopi=$kopi, susu=$susu, teh=$teh');
```

Contoh lainnya:

```dart
L.i('idPengguna=$idPengguna, nama=$nama');
L.i('totalHarga=$totalHarga, jumlah=$jumlah');
L.i('isLoading=$isLoading, data=$data');
```

Ketentuan:

1. Gunakan nama variabel sebenarnya.
2. Gunakan interpolasi Dart `$namaVariabel`.
3. Jangan menambahkan penjelasan panjang.
4. Jangan menambahkan keterangan yang tidak diperlukan.
5. Jangan menggunakan nilai perkiraan atau nilai contoh sebagai pengganti nilai aktual.

## 5. Penggunaan L.w()

Gunakan `L.w()` untuk kondisi peringatan atau kondisi khusus yang perlu diketahui pengguna.

Formatnya sama seperti `L.i()`, tetapi tambahkan sedikit informasi mengenai kondisi yang terjadi.

Contoh:

```dart
L.w('pengguna menolak izin, izin=$izin');
```

Contoh lainnya:

```dart
L.w('data tidak ditemukan, id=$id');
L.w('validasi gagal, email=$email');
L.w('menggunakan nilai default, jumlah=$jumlah');
```

Ketentuan:

1. Keterangan harus singkat.
2. Tetap sertakan nilai variabel yang berkaitan.
3. Jangan menggunakan `L.w()` untuk alur normal.
4. Jangan membuat pesan terlalu panjang.

## 6. Penggunaan L.e()

Gunakan `L.e()` khusus untuk mencatat error.

Berbeda dengan `L.i()` dan `L.w()`, log error harus menjelaskan proses yang gagal serta menyertakan error dan stack trace apabila tersedia.

Contoh:

```dart
try {
  // Proses program.
} catch (e, s) {
  L.e('gagal melakukan tambah pengguna: $e $s');
}
```

Contoh lainnya:

```dart
L.e('gagal mengambil data pengguna: $e $s');
L.e('gagal menyimpan transaksi: $e $s');
```

Ketentuan:

1. Sertakan nama proses yang gagal.
2. Sertakan error menggunakan `$e`.
3. Sertakan stack trace menggunakan `$s` apabila tersedia.
4. Jangan mengarang informasi error.
5. Jangan menggunakan `L.e()` untuk kondisi normal atau peringatan.
6. Jangan mengubah mekanisme penanganan error yang sudah ada.
7. Jangan menambahkan `try-catch` baru hanya demi menambahkan log.

Jika blok `catch` belum menerima stack trace dan diperlukan, gunakan parameter `(e, s)` tanpa mengubah perilaku penanganan error yang sudah ada.

## 7. Aturan Khusus untuk Model

Jika variabel merupakan objek model, cukup tampilkan objek model secara langsung menggunakan `$model`.

Jangan menguraikan properti model satu per satu.

**Benar:**

```dart
L.i('model=$model');
```

**Salah:**

```dart
L.i('model=${model.nama}, umur=${model.umur}');
```

**Salah:**

```dart
L.i('nama=${model.nama}, umur=${model.umur}, alamat=${model.alamat}');
```

Aturan ini berlaku untuk:

- Model Freezed.
- Model hasil API.
- Model database.
- Model hasil repository.
- Model lainnya.

Jika nama variabel model bukan `model`, gunakan nama variabel sebenarnya.

Contoh:

```dart
L.i('pengguna=$pengguna');
L.i('transaksi=$transaksi');
L.i('produk=$produk');
```

Jangan menguraikan properti objek model kecuali pengguna secara khusus meminta pemeriksaan properti tertentu.

## 8. Aturan L.init()

Pemilihan metode logging wajib berdasarkan urutan inisialisasi yang sebenarnya.

### 8.1. Setelah L.init()

Jika jalur eksekusi sudah melewati `L.init()`, gunakan:

- `L.i()` untuk informasi.
- `L.w()` untuk peringatan.
- `L.e()` untuk error.

### 8.2. Sebelum L.init()

Jika jalur eksekusi belum melewati `L.init()`, gunakan `debugPrint()` dengan pengecekan `kDebugMode`.

Contoh:

```dart
if (kDebugMode) {
  debugPrint('kopi=$kopi, susu=$susu');
}
```

Pastikan import berikut tersedia:

```dart
import 'package:flutter/foundation.dart';
```

### 8.3. Pemeriksaan urutan inisialisasi

1. Cari lokasi pemanggilan `L.init()` di proyek.
2. Periksa kapan `L.init()` dijalankan.
3. Telusuri jalur eksekusi fungsi, method, callback, atau proses yang akan diberi log.
4. Jangan hanya menentukan penggunaan logging berdasarkan posisi kode dalam file.
5. Jika belum dapat memastikan apakah `L.init()` sudah dijalankan, gunakan `debugPrint()` dengan pengecekan `kDebugMode`.

Jangan mengubah mekanisme atau lokasi pemanggilan `L.init()`.

## 9. Keamanan Data

Jangan mencatat nilai sensitif seperti:

- Password.
- Access token.
- Refresh token.
- OTP.
- Secret key.
- Private key.
- Kredensial autentikasi.

Jika variabel model atau objek mengandung informasi sensitif, jangan mencetak keseluruhan objek tersebut. Laporkan variabel yang dikecualikan beserta alasannya tanpa menampilkan nilainya.

## 10. Larangan

1. Jangan mengubah logika bisnis.
2. Jangan mengubah hasil proses program.
3. Jangan mengubah kondisi percabangan.
4. Jangan mengubah nilai variabel.
5. Jangan mengubah tipe data.
6. Jangan melakukan refactoring.
7. Jangan menambahkan fitur.
8. Jangan membuat sistem logging baru.
9. Jangan menambahkan package baru.
10. Jangan menggunakan `print()` sebagai pengganti sistem logging.
11. Jangan mengubah file di luar daftar target.
12. Jangan mengubah `L.init()`.
13. Jangan menambahkan log sebelum variabel mendapatkan nilai.
14. Jangan mencetak properti model satu per satu.
15. Jangan membuat pesan log terlalu panjang.

## 11. Pemeriksaan Setelah Penambahan Log

Setelah selesai:

1. Pastikan semua variabel dan parameter yang relevan sudah diberi log.
2. Pastikan nilai yang dicatat merupakan nilai aktual.
3. Pastikan objek model cukup menggunakan `$model`.
4. Pastikan `L.i()`, `L.w()`, dan `L.e()` digunakan sesuai fungsinya.
5. Pastikan log sebelum `L.init()` menggunakan `debugPrint()` dengan pengecekan `kDebugMode`.
6. Pastikan log setelah `L.init()` menggunakan `L.*`.
7. Pastikan tidak ada data sensitif yang tercetak.
8. Pastikan tidak ada perubahan logika program.
9. Periksa format kode Dart.
10. Jalankan `flutter analyze` jika memungkinkan dan laporkan hasilnya.

Jangan memperbaiki masalah lain yang tidak berkaitan dengan penambahan log.

## 12. Format Laporan Akhir

# Laporan Penambahan Log Debug

## A. File yang Diperbarui

Tampilkan path setiap file yang berhasil diberi log.

## B. Lokasi Log

Tampilkan path dan nomor baris setiap log yang ditambahkan.

Contoh:

- `lib/fitur/pengguna/controller/pengguna_controller.dart:25`
  - `L.i('idPengguna=$idPengguna, nama=$nama');`

## C. Variabel yang Dikecualikan

Tampilkan variabel yang tidak dicatat karena mengandung informasi sensitif beserta alasannya.

## D. Pemeriksaan L.init()

Jelaskan penggunaan `L.*` dan `debugPrint()` berdasarkan urutan inisialisasi.

## E. Hasil Pemeriksaan

Laporkan hasil pemeriksaan kode dan `flutter analyze`.

Pastikan tidak ada perubahan logika program.

## 13. Prinsip Pelaksanaan

Fokus hanya menambahkan log debug pada file yang ditentukan pengguna.

Utamakan nilai variabel dan parameter, bukan penjelasan panjang.

Gunakan format log yang sederhana, konsisten, dan mudah dibaca.

Jangan melakukan pekerjaan tambahan di luar kebutuhan logging.
