---
description: Audit perubahan kode Dart yang belum di-commit terhadap AGENTS.md dan source SDK tanpa mengubah kode.
agent: code
---

# Audit Perubahan Kode Dart Sebelum Commit

## Tujuan

Analisis seluruh perubahan kode Dart yang belum di-commit untuk memastikan kesesuaiannya dengan:

1. `AGENTS.md` dan aturan proyek yang berlaku.
2. Source code Flutter SDK dan Dart SDK.
3. Source code paket atau dependensi yang digunakan proyek.
4. Praktik implementasi yang sesuai dengan API dan versi SDK yang benar-benar digunakan.

Tujuan akhirnya adalah memberikan laporan audit yang akurat, menunjukkan setiap pelanggaran beserta lokasi kode dan aturan yang dilanggar, serta memberikan rekomendasi perbaikan sebelum pengguna melakukan commit.

## 1. Ketentuan Utama

1. Jalankan audit secara menyeluruh, teliti, dan berdasarkan bukti dari source code.
2. Jangan langsung memperbaiki kode Dart.
3. Jangan mengubah, menghapus, menambah, atau memindahkan kode Dart apa pun.
4. Jangan mengubah `AGENTS.md`, file aturan, konfigurasi proyek, maupun file lainnya.
5. Satu-satunya file yang boleh dibuat atau diperbarui adalah `saran.md` di root proyek, sesuai ketentuan pada bagian 5.
6. Jangan melakukan `git add`, `git commit`, `git reset`, `git checkout`, `git stash`, atau operasi Git lain yang mengubah kondisi perubahan pengguna.
7. Jangan menganggap kode sudah benar hanya karena berhasil dikompilasi atau tidak menampilkan error.
8. Jangan mengarang pelanggaran, lokasi baris, isi aturan, hasil pemeriksaan SDK, atau rekomendasi.
9. Setiap kesimpulan harus memiliki dasar pemeriksaan yang dapat ditelusuri.
10. Jika suatu pemeriksaan tidak dapat dilakukan, jelaskan keterbatasannya. Jangan mengklaim pemeriksaan sudah berhasil.

## 2. Identifikasi Perubahan yang Belum Di-commit

Sebelum melakukan audit:

1. Baca `AGENTS.md` di root proyek terlebih dahulu.
2. Temukan dan baca `AGENTS.md` lain yang berlaku untuk direktori kode yang berubah.
3. Baca file aturan tambahan yang dirujuk oleh `AGENTS.md`.
4. Periksa kondisi Git untuk mengidentifikasi seluruh perubahan yang belum di-commit.
5. Periksa perubahan staged, unstaged, file baru yang belum dilacak Git, file yang dihapus, serta file yang dipindahkan atau diganti namanya.
6. Gunakan `HEAD` sebagai acuan untuk mengidentifikasi perubahan yang belum masuk commit.

Gunakan pemeriksaan Git yang sesuai, seperti:

- `git status --short`
- `git diff HEAD --`
- `git diff --cached`

Periksa juga isi file baru yang belum dilacak Git karena file tersebut tidak selalu muncul dalam hasil `git diff`.

### Batasan cakupan pemeriksaan

- Hanya audit file kode dengan ekstensi `.dart`.
- Jangan melakukan audit terhadap perubahan isi file non-Dart.
- File non-Dart boleh dibaca apabila diperlukan untuk mengetahui konfigurasi, versi SDK, versi paket, atau informasi lain yang dibutuhkan dalam pemeriksaan kode Dart.
- Jangan mengabaikan perubahan Dart hanya karena file tersebut baru dibuat, dipindahkan, atau belum dilacak Git.

Jika tidak ditemukan perubahan kode Dart yang belum di-commit, laporkan kondisi tersebut. Jangan membuat perubahan apa pun pada `saran.md` apabila tidak ada temuan.

## 3. Audit Kesesuaian dengan AGENTS.md

Periksa setiap perubahan kode Dart terhadap seluruh aturan yang berlaku.

Lakukan pemeriksaan berikut:

1. Identifikasi aturan yang berkaitan dengan kode yang berubah.
2. Periksa implementasi kode terhadap isi aturan tersebut.
3. Pastikan aturan dibaca dari file aslinya, bukan hanya mengandalkan ingatan atau ringkasan sebelumnya.
4. Periksa aturan tambahan yang secara langsung dirujuk oleh `AGENTS.md`.
5. Identifikasi apakah kode melanggar aturan secara langsung atau hanya memiliki peluang untuk ditingkatkan.

### Ketentuan pelaporan pelanggaran

Untuk setiap pelanggaran, WAJIB tampilkan:

- **File kode:** path lengkap dan nomor baris kode yang bermasalah.
- **Aturan yang dilanggar:** nama aturan dan penjelasan aturan yang tidak dipatuhi.
- **Lokasi aturan:** path file aturan dan nomor baris yang memuat ketentuan tersebut.
- **Bukti:** penjelasan bagian kode yang menyebabkan pelanggaran.
- **Dampak:** risiko atau akibat dari implementasi tersebut.
- **Saran perbaikan:** cara memperbaikinya tanpa melakukan perubahan kode.

Contoh format:

### Pelanggaran 1 — Tidak mengikuti aturan pengelolaan state

- Kode bermasalah: `lib/fitur/contoh/page/contoh_page.dart:45-52`
- Aturan yang dilanggar: Aturan pengelolaan state.
- Lokasi aturan: `.agents/rules/proyek/aturan_state.md:20-27`
- Bukti: Jelaskan implementasi yang tidak sesuai.
- Dampak: Jelaskan risiko dari implementasi tersebut.
- Saran: Jelaskan perbaikan yang seharusnya dilakukan.

Jangan hanya mengatakan bahwa kode tidak sesuai aturan. Tunjukkan secara spesifik aturan mana yang dilanggar dan lokasi ketentuan tersebut.

Jika sebuah kode tidak melanggar aturan tertulis, jangan mengategorikannya sebagai pelanggaran AGENTS.md. Apabila ada peluang peningkatan, masukkan ke bagian rekomendasi.

## 4. Wajib Membaca Source Code SDK dan Paket

### 4.1. Ketentuan wajib

Jangan melewatkan pemeriksaan source code SDK hanya karena kode yang berubah terlihat sederhana.

Setiap API yang digunakan atau diubah dalam kode Dart wajib diperiksa, termasuk:

- Widget bawaan Flutter.
- Konstruktor widget.
- Parameter konstruktor.
- Properti dan method.
- Callback.
- Extension.
- Class dan interface.
- API Dart.
- API dari paket eksternal.
- API yang memiliki status deprecated.
- API yang mengalami perubahan pada versi SDK atau paket tertentu.

**Tidak ada pengecualian hanya karena sebuah widget atau API dianggap dasar, sederhana, atau umum digunakan.**

### 4.2. Sumber pemeriksaan

Gunakan source code sesuai dengan SDK dan versi dependensi yang benar-benar digunakan proyek.

Periksa sumber yang relevan:

1. **Flutter SDK:** source code framework Flutter yang terpasang pada lingkungan proyek.
2. **Dart SDK:** source code Dart SDK yang digunakan proyek.
3. **Paket eksternal:** source code paket yang terpasang pada pub cache atau lokasi dependensi sebenarnya.
4. **Dependensi proyek:** gunakan `pubspec.lock` dan konfigurasi paket untuk memastikan versi yang sedang digunakan.

Jangan menggunakan dokumentasi versi terbaru sebagai pengganti source code versi yang terpasang apabila versi proyek berbeda.

Jangan menggunakan asumsi berdasarkan pengetahuan sebelumnya sebagai pengganti pemeriksaan source code.

### 4.3. Hal yang wajib diperiksa

Untuk setiap API yang relevan dengan perubahan kode:

1. Temukan deklarasi class, method, properti, atau konstruktor pada source code aslinya.
2. Baca tanda tangan API (_API signature_) yang sebenarnya.
3. Periksa parameter wajib dan opsional.
4. Periksa tipe data dan nullability setiap parameter.
5. Periksa nilai default parameter jika tersedia.
6. Periksa apakah parameter atau API sudah deprecated.
7. Jika deprecated, periksa alternatif penggantinya yang disediakan SDK atau paket.
8. Periksa perubahan API berdasarkan versi yang digunakan proyek.
9. Periksa implementasi internal apabila diperlukan untuk memastikan perilaku API.
10. Bandingkan hasil pemeriksaan dengan cara API tersebut digunakan dalam kode proyek.

Jangan hanya mencari nama widget atau konstruktor lalu berhenti setelah menemukannya. Baca deklarasi dan bagian implementasi yang relevan agar pemahaman terhadap API tidak keliru.

### 4.4. Contoh pemeriksaan widget

Misalnya terdapat perubahan berikut:

```dart
ListView.builder(
  itemCount: items.length,
  itemBuilder: (context, index) {
    return Text(items[index].nama);
  },
)
```

Walaupun `ListView.builder` merupakan widget dasar Flutter, tetap lakukan pemeriksaan terhadap:

- Deklarasi konstruktor `ListView.builder`.
- Parameter `itemCount`.
- Parameter `itemBuilder`.
- Tipe callback yang diterima.
- Perubahan atau status deprecated pada API terkait.
- Perilaku implementasi apabila terdapat bagian kode yang membutuhkan pemeriksaan lebih lanjut.

Jangan berasumsi bahwa API yang sudah sering digunakan pasti masih sesuai dengan versi Flutter yang terpasang.

### 4.5. Jika source code tidak ditemukan

Apabila source code SDK atau paket tidak dapat ditemukan:

1. Periksa kembali lokasi instalasi SDK atau dependensi.
2. Identifikasi versi SDK atau paket yang digunakan.
3. Coba telusuri lokasi source code sebenarnya.
4. Jangan mengarang tanda tangan API atau status deprecated.
5. Laporkan API yang belum berhasil diverifikasi beserta alasan dan lokasi kode yang menggunakannya.

Jangan menyatakan bahwa API sudah sesuai SDK apabila source code yang relevan belum diperiksa.

## 5. Memperbarui File saran.md

Apabila ditemukan pelanggaran, ketidaksesuaian SDK, atau peluang perbaikan yang relevan, catat rekomendasinya di file `saran.md` pada root proyek.

Path tujuan:

`saran.md`

### 5.1. Ketentuan pembaruan

1. Jika `saran.md` sudah tersedia, baca seluruh isinya sebelum melakukan pembaruan.
2. Jika belum tersedia dan ditemukan rekomendasi yang perlu dicatat, buat `saran.md` di root proyek.
3. Setiap rekomendasi baru harus ditempatkan di bagian paling atas dari daftar rekomendasi.
4. Jika rekomendasi yang sudah ada perlu diperbarui, perbarui isinya dan pindahkan rekomendasi tersebut ke posisi paling atas.
5. Jangan membuat rekomendasi duplikat.
6. Jika rekomendasi baru memiliki hubungan dengan rekomendasi lama, pertimbangkan untuk menggabungkan atau memperbarui rekomendasi lama.
7. Pertahankan rekomendasi lain yang masih relevan.
8. Jangan menghapus rekomendasi lama hanya karena rekomendasi baru ditambahkan.
9. Jangan mengubah struktur atau isi lain yang tidak berkaitan dengan pembaruan rekomendasi.
10. Jika terdapat judul utama dalam file, pertahankan judul tersebut dan letakkan rekomendasi terbaru tepat di bawahnya.

### 5.2. Isi rekomendasi

Setiap rekomendasi harus menjelaskan:

- Masalah atau peluang perbaikan.
- Path dan baris kode yang berkaitan.
- Aturan yang berkaitan, jika ada.
- Referensi source SDK atau paket, jika relevan.
- Saran perbaikan.
- Alasan rekomendasi tersebut perlu dipertimbangkan.

Gunakan tanggal ketika rekomendasi dibuat atau diperbarui agar urutan dan riwayatnya mudah dipahami.

### 5.3. Batasan

- `saran.md` berisi rekomendasi, bukan tempat untuk mengubah kode.
- Jangan langsung menerapkan rekomendasi ke kode Dart.
- Jangan mengubah file lain demi melengkapi rekomendasi.
- Jika tidak ditemukan hal yang layak direkomendasikan, jangan memperbarui `saran.md` hanya untuk membuat perubahan.

## 6. Saran Perbaikan

Selain menemukan pelanggaran aturan dan ketidaksesuaian SDK, berikan saran perbaikan apabila ditemukan peluang peningkatan.

Pisahkan dengan tegas:

1. **Pelanggaran aturan:** implementasi yang terbukti bertentangan dengan aturan tertulis.
2. **Ketidaksesuaian SDK:** implementasi yang tidak sesuai dengan source code SDK atau paket yang digunakan.
3. **Rekomendasi:** peluang peningkatan yang tidak secara langsung melanggar aturan.

Jangan menganggap semua rekomendasi sebagai kewajiban.

Setiap rekomendasi harus memiliki alasan teknis yang jelas, bukan sekadar preferensi pribadi atau asumsi.

Jika suatu rekomendasi berkaitan dengan API, sertakan referensi source code yang mendukung rekomendasi tersebut.

## 7. Ketentuan Path dan Nomor Baris

Setiap temuan wajib menyertakan path dan nomor baris yang akurat.

Ketentuannya:

1. Gunakan path relatif dari root proyek.
2. Sertakan nomor baris kode yang bermasalah.
3. Sertakan path dan nomor baris aturan yang dilanggar.
4. Sertakan path dan nomor baris source SDK atau paket apabila temuan berkaitan dengan API.
5. Gunakan nomor baris berdasarkan isi file yang sebenarnya, bukan perkiraan.
6. Periksa kembali nomor baris sebelum menyusun laporan akhir.
7. Untuk kode yang sudah dihapus, gunakan nomor baris lama dari diff dan jelaskan bahwa baris tersebut sudah dihapus.
8. Untuk file baru yang belum dilacak Git, baca isi file dan ambil nomor baris dari file tersebut.

Gunakan format:

`lib/path/nama_file.dart:baris-awal-bar​​is-akhir`

Jangan menyertakan hyperlink atau tautan yang dapat diklik.

Cukup tampilkan path dan nomor baris agar saya dapat langsung membuka lokasi yang bermasalah di editor.

## 8. Format Laporan Akhir

Susun hasil audit dengan format yang terstruktur, jelas, dan mudah dibaca.

Gunakan urutan berikut:

# Laporan Audit Perubahan Kode Dart

## A. Ringkasan Pemeriksaan

- Status perubahan Git.
- Jumlah file Dart yang berubah.
- Jumlah file yang diperiksa.
- Jumlah pelanggaran aturan.
- Jumlah ketidaksesuaian SDK.
- Jumlah rekomendasi.
- Status pembaruan `saran.md`.

## B. Daftar Perubahan

Tampilkan daftar file Dart yang berubah beserta statusnya:

- Modified.
- Added.
- Deleted.
- Renamed.

## C. Pelanggaran AGENTS.md

Untuk setiap pelanggaran, tampilkan:

- Nama pelanggaran.
- Path dan baris kode.
- Nama aturan yang dilanggar.
- Path dan baris aturan.
- Bukti ketidaksesuaian.
- Dampak.
- Saran perbaikan.

Jika tidak ditemukan, nyatakan secara jelas bahwa tidak ada pelanggaran aturan yang teridentifikasi.

## D. Hasil Pemeriksaan Source SDK dan Paket

Tampilkan API yang diperiksa dengan informasi:

- Path dan baris kode yang menggunakan API.
- Nama API, widget, atau konstruktor.
- Versi SDK atau paket yang digunakan.
- Path dan baris source code yang diperiksa.
- Hasil pemeriksaan.
- Status deprecated jika ada.
- Penjelasan ketidaksesuaian atau perubahan API jika ditemukan.

Jangan hanya menuliskan bahwa SDK sudah diperiksa. Tampilkan bukti lokasi source code yang benar-benar dibaca.

Jika ada API yang belum berhasil diverifikasi, tampilkan secara terpisah.

## E. Rekomendasi Perbaikan

Tampilkan rekomendasi yang tidak termasuk pelanggaran aturan, tetapi layak dipertimbangkan untuk meningkatkan kualitas implementasi.

Untuk setiap rekomendasi, sertakan:

- Path dan baris kode.
- Alasan teknis.
- Saran perbaikan.
- Referensi source SDK atau paket jika relevan.

## F. Pembaruan saran.md

Laporkan:

- Apakah `saran.md` dibuat, diperbarui, atau tidak diubah.
- Rekomendasi apa saja yang ditambahkan atau diperbarui.
- Pastikan rekomendasi terbaru sudah berada di bagian paling atas.

## G. Kesimpulan

Berikan kesimpulan apakah perubahan kode Dart sudah sesuai untuk dipertimbangkan sebelum commit.

Gunakan salah satu status berikut:

- **Tidak ditemukan masalah:** tidak ditemukan pelanggaran aturan maupun ketidaksesuaian SDK.
- **Perlu perbaikan:** terdapat pelanggaran aturan atau ketidaksesuaian SDK.
- **Perlu verifikasi lanjutan:** terdapat bagian yang belum dapat diverifikasi karena keterbatasan source code atau informasi yang tersedia.

Jangan memberikan status tidak ditemukan masalah apabila masih ada API atau bagian kode penting yang belum berhasil diperiksa.

## 9. Larangan Akhir

1. Jangan mengubah kode Dart dalam keadaan apa pun selama command ini dijalankan.
2. Jangan langsung memperbaiki pelanggaran yang ditemukan.
3. Jangan mengubah aturan proyek.
4. Jangan melakukan commit.
5. Jangan mengubah staging Git.
6. Jangan melakukan refactoring.
7. Jangan menambahkan fitur.
8. Jangan mengarang hasil pemeriksaan.
9. Jangan melewatkan pembacaan source SDK untuk widget atau API yang dianggap sederhana.
10. Jangan memberikan laporan yang hanya berisi kesimpulan tanpa bukti path dan nomor baris.

**Fokus utama command ini adalah melakukan audit, membaca source code, menemukan ketidaksesuaian, memperbarui saran.md apabila diperlukan, dan menyajikan hasil pemeriksaan. Seluruh keputusan untuk memperbaiki kode tetap berada di tangan pengguna.**
