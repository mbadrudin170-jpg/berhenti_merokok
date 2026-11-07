---
description: Tambahkan log debug pada variabel dan parameter hanya di file Dart yang ditentukan pengguna.
agent: code
---

# Tambahkan Log Debug pada Variabel

## Tujuan

Tambahkan log debug pada variabel dan parameter di file yang secara spesifik ditentukan oleh pengguna.

Tujuannya adalah membantu pengguna mengetahui nilai variabel selama program berjalan, sehingga lebih mudah melacak alur eksekusi, menemukan penyebab masalah, dan memahami perubahan nilai data.

Gunakan sistem logging yang sudah tersedia di proyek, yaitu `L.i()`, `L.w()`, dan `L.e()` dari:

`lib/shared/utils/l.dart`

Jangan membuat sistem logging baru.

## 1. Batasan File

1. Hanya tambahkan log pada file yang secara eksplisit ditentukan oleh pengguna.
2. Jangan mencari file lain untuk dijadikan target penambahan log.
3. File lain boleh dibaca apabila diperlukan untuk memahami alur eksekusi, letak `L.init()`, atau hubungan antarvariabel.
4. Jangan menambahkan log di file yang tidak ditentukan pengguna.
5. Jangan mengubah file `lib/shared/utils/l.dart`. File tersebut hanya digunakan sebagai referensi implementasi logging.
6. Jika pengguna belum menentukan file target, tanyakan path file yang ingin diberi log. Jangan mulai mengubah file apa pun.

## 2. Aturan Utama Penambahan Log

1. Tambahkan log pada variabel dan parameter yang terdapat dalam file target.
2. Usahakan setiap nilai variabel dapat diketahui pada saat nilainya tersedia.
3. Untuk parameter fungsi atau method, tambahkan log pada awal fungsi atau method setelah parameter tersedia.
4. Untuk variabel lokal, tambahkan log setelah variabel mendapatkan nilainya.
5. Jika variabel mengalami perubahan nilai yang penting, tambahkan log setelah perubahan tersebut agar nilai terbarunya dapat diketahui.
6. Untuk beberapa variabel yang tersedia pada titik eksekusi yang sama, gabungkan nilainya dalam satu pemanggilan log agar tidak terlalu banyak baris logging.
7. Jangan menambahkan log berulang hanya karena variabel yang sama digunakan berkali-kali tanpa perubahan nilai.
8. Jangan menambahkan log sebelum variabel mendapatkan nilai.
9. Jangan mengubah urutan operasi program hanya demi menambahkan log.
10. Jangan menambahkan log yang tidak memberikan informasi nilai variabel secara nyata.

### Prioritas informasi

Utamakan pencatatan:

- Parameter yang diterima fungsi atau method.
- Nilai variabel lokal setelah dihitung.
- Nilai data sebelum dikirim ke repository, database, API, atau proses lainnya.
- Nilai hasil dari repository, database, API, atau proses lainnya.
- Nilai sebelum dan sesudah perubahan state.
- Nilai yang digunakan dalam kondisi percabangan apabila diperlukan untuk mengetahui alasan suatu kondisi terpenuhi atau tidak.

Jangan hanya mencatat bahwa suatu proses dijalankan. Utamakan nilai variabel yang digunakan dalam proses tersebut.

## 3. Ketentuan Penggunaan L.i()

Gunakan `L.i()` untuk mencatat nilai variabel dan parameter dalam alur program normal.

**Jangan membuat pesan terlalu panjang atau terlalu deskriptif.**

Cukup cantumkan nama variabel dan nilainya menggunakan interpolasi Dart.

Contoh yang benar:

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

1. Gunakan nama variabel yang sebenarnya.
2. Sertakan nilai variabel menggunakan `$namaVariabel`.
3. Gabungkan variabel yang berkaitan dalam satu log apabila berada pada titik eksekusi yang sama.
4. Jangan menambahkan penjelasan panjang yang tidak diperlukan.
5. Jangan menggunakan nilai contoh atau nilai perkiraan. Catat nilai aktual saat program berjalan.

## 4. Ketentuan Penggunaan L.w()

Gunakan `L.w()` ketika terdapat kondisi peringatan atau kondisi khusus yang perlu diperhatikan.

Pesan harus singkat, tetapi tetap memberikan sedikit konteks mengenai kondisi yang terjadi dan menyertakan nilai variabel terkait.

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

1. Tetap sertakan nilai variabel yang berkaitan dengan kondisi tersebut.
2. Berikan keterangan singkat mengenai alasan log peringatan muncul.
3. Jangan menggunakan `L.w()` hanya untuk mencatat variabel dalam alur normal.
4. Jangan membuat pesan terlalu panjang.

## 5. Ketentuan Penggunaan L.e()

Gunakan `L.e()` khusus untuk mencatat error yang terjadi dalam proses program, terutama pada blok `catch`.

Format yang diutamakan:

```dart
try {
  // Proses program.
} catch (e, s) {
  L.e('gagal melakukan tambah pengguna: $e $s');
}
```

Ketentuan:

1. Sertakan konteks singkat mengenai proses yang gagal.
2. Sertakan nilai error menggunakan `$e`.
3. Sertakan stack trace menggunakan `$s` apabila tersedia.
4. Jangan mengarang informasi error.
5. Jangan menggunakan `L.e()` untuk mencatat kondisi normal atau peringatan biasa.
6. Jika blok `catch` belum memiliki parameter stack trace dan diperlukan untuk memperoleh `$s`, penambahan parameter stack trace diperbolehkan selama tidak mengubah penanganan error.
7. Jangan menghilangkan atau mengubah mekanisme penanganan error yang sudah tersedia.
8. Jangan menambahkan `try-catch` baru hanya untuk memasukkan log apabila sebelumnya tidak diperlukan.

Contoh:

```dart
} catch (e, s) {
  L.e('gagal mengambil data pengguna: $e $s');
  rethrow;
}
```

Pertahankan perilaku penanganan error yang sudah ada. Contoh di atas bukan instruksi untuk selalu menambahkan `rethrow`.

## 6. Aturan L.init()

Pemilihan sistem logging harus berdasarkan apakah `L.init()` sudah benar-benar dijalankan ketika kode tersebut dieksekusi.

Referensi implementasi:

`lib/shared/utils/l.dart`

### 6.1. Kode yang dieksekusi setelah L.init()

Jika jalur eksekusi sudah melewati pemanggilan `L.init()`, gunakan:

- `L.i()` untuk informasi.
- `L.w()` untuk peringatan.
- `L.e()` untuk error.

Contoh:

```dart
L.i('nama=$nama, umur=$umur');
L.w('izin ditolak, izin=$izin');
L.e('gagal menyimpan data: $e $s');
```

### 6.2. Kode yang dieksekusi sebelum L.init()

Jika jalur eksekusi belum melewati `L.init()`, jangan menggunakan `L.i()`, `L.w()`, atau `L.e()`.

Gunakan `debugPrint()` dengan pengecekan `kDebugMode`.

Contoh:

```dart
if (kDebugMode) {
  debugPrint('nama=$nama, umur=$umur');
}
```

Pastikan tersedia import:

```dart
import 'package:flutter/foundation.dart';
```

Jika import tersebut belum tersedia, tambahkan hanya apabila memang diperlukan dan belum tersedia melalui import yang sudah ada.

### 6.3. Wajib memeriksa urutan inisialisasi

1. Cari lokasi pemanggilan `L.init()` di proyek.
2. Baca implementasi pemanggilan tersebut.
3. Telusuri alur eksekusi file target.
4. Tentukan apakah fungsi, method, callback, atau proses yang diberi log dapat berjalan sebelum `L.init()`.
5. Jangan menentukan penggunaan `L.*` hanya berdasarkan posisi kode dalam file.
6. Jika urutan inisialisasi belum dapat dipastikan, gunakan `debugPrint()` dengan pengecekan `kDebugMode` pada bagian tersebut.

Jangan mengubah lokasi atau mekanisme pemanggilan `L.init()`.

## 7. Larangan

1. Jangan mengubah logika bisnis.
2. Jangan mengubah hasil proses program.
3. Jangan mengubah kondisi `if`, `else`, `switch`, atau perulangan.
4. Jangan mengubah nilai variabel hanya untuk keperluan logging.
5. Jangan mengubah tipe data variabel.
6. Jangan mengubah parameter fungsi atau method, kecuali penambahan parameter stack trace pada `catch` sebagaimana dijelaskan sebelumnya.
7. Jangan menghapus kode yang sudah ada.
8. Jangan melakukan refactoring.
9. Jangan membuat fungsi logging tambahan.
10. Jangan menambahkan package baru.
11. Jangan menggunakan `print()` sebagai pengganti logging yang sudah ditentukan.
12. Jangan mengubah file di luar daftar target pengguna.
13. Jangan menambahkan log pada file generated seperti `.g.dart` dan `.freezed.dart`.
14. Jangan menambahkan log yang mencetak password, token autentikasi, OTP, secret key, private key, atau kredensial lainnya. Laporkan variabel sensitif yang dikecualikan tanpa menampilkan nilainya.
15. Jangan mengubah format pesan log menjadi terlalu panjang dan sulit dibaca.

## 8. Ketentuan Import

Jika file target belum memiliki akses terhadap `L`:

1. Cari pola import yang digunakan proyek.
2. Tambahkan import `L` menggunakan path yang benar sesuai struktur proyek.
3. Hindari import duplikat.
4. Jangan mengubah import lain yang tidak berkaitan.

Jika file memerlukan `debugPrint()` dan `kDebugMode`, pastikan import yang sesuai tersedia.

## 9. Pemeriksaan Setelah Penambahan Log

Setelah selesai:

1. Periksa kembali setiap file target.
2. Pastikan penambahan log tidak mengubah logika program.
3. Pastikan setiap interpolasi menggunakan nama variabel yang benar.
4. Pastikan `L.i()`, `L.w()`, dan `L.e()` digunakan sesuai fungsinya.
5. Pastikan tidak ada pemanggilan `L.*` sebelum `L.init()` dijalankan.
6. Pastikan kode sebelum `L.init()` menggunakan `debugPrint()` dengan pengecekan `kDebugMode`.
7. Pastikan tidak ada data sensitif yang dicetak.
8. Periksa format kode agar tetap sesuai dengan formatter Dart.
9. Jalankan `flutter analyze` jika memungkinkan, kemudian laporkan hasilnya.
10. Jangan memperbaiki masalah lain yang tidak berkaitan dengan penambahan log.

## 10. Format Laporan Akhir

Setelah selesai, berikan laporan dengan format berikut:

# Laporan Penambahan Log Debug

## A. File yang Diperbarui

Tampilkan seluruh file yang ditentukan pengguna dan berhasil diberi log.

Format:

- `lib/path/nama_file.dart`
  - Jumlah log yang ditambahkan.
  - Jenis log: `L.i()`, `L.w()`, `L.e()`, atau `debugPrint()`.

## B. Lokasi Log

Tampilkan path dan nomor baris setiap bagian log yang ditambahkan.

Contoh:

- `lib/fitur/pengguna/controller/pengguna_controller.dart:25`
  - `L.i('idPengguna=$idPengguna, nama=$nama');`

## C. Variabel yang Dikecualikan

Sebutkan variabel sensitif yang tidak dicatat beserta path dan alasannya. Jangan tampilkan nilai sensitifnya.

## D. Pemeriksaan L.init()

Jelaskan apakah log menggunakan `L.*` atau `debugPrint()`, serta dasar penentuan urutan inisialisasinya.

## E. Hasil Pemeriksaan

Laporkan:

- Apakah penambahan log berhasil.
- Apakah ada kesalahan dari `flutter analyze`.
- Apakah ada bagian yang tidak dapat diberi log beserta alasannya.
- Pastikan tidak ada perubahan logika program.

## 11. Prinsip Pelaksanaan

**Fokus hanya pada penambahan log debug di file yang ditentukan pengguna.**

Log harus sederhana, berisi nilai variabel yang aktual, mudah dibaca, dan ditempatkan pada titik eksekusi yang tepat.

Jangan menjadikan pekerjaan ini sebagai kesempatan untuk memperbaiki, merapikan, atau mengubah implementasi program di luar kebutuhan logging.
