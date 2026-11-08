---
description: Evaluasi commit baru berdasarkan AGENTS.md dan source SDK/paket, lalu perbarui catatan dan saran tanpa mengubah kode.
agent: code
---

# Evaluasi Perubahan Commit Terbaru

## Tujuan

Lakukan evaluasi terhadap perubahan kode yang sudah di-commit pada branch aktif.

Tujuan evaluasi adalah memastikan perubahan yang sudah di-commit:

1. Sesuai dengan aturan yang berlaku di `AGENTS.md` dan aturan proyek lainnya.
2. Sesuai dengan SDK, framework, serta paket yang digunakan oleh proyek.
3. Menggunakan API, konstruktor, parameter, properti, dan metode yang masih berlaku.
4. Tidak menggunakan API yang sudah deprecated apabila tersedia alternatif yang sesuai.
5. Tidak menimbulkan masalah runtime, bug, atau ketidaksesuaian implementasi.
6. Memiliki rekomendasi perbaikan yang terdokumentasi apabila ditemukan kekurangan.

Jangan langsung melakukan perbaikan kode. Command ini merupakan proses evaluasi dan dokumentasi, bukan proses implementasi.

---

## 1. Batasan Eksekusi

Patuhi seluruh batasan berikut:

1. Jangan mengubah kode Dart.
2. Jangan mengubah kode sumber dalam bahasa pemrograman apa pun.
3. Jangan melakukan refactoring.
4. Jangan memperbaiki bug secara langsung.
5. Jangan mengubah konfigurasi proyek.
6. Jangan menjalankan formatter yang mengubah file.
7. Jangan melakukan commit, push, reset, rebase, checkout, atau operasi Git yang mengubah riwayat maupun kondisi repository.
8. Jangan memasukkan perubahan yang belum di-commit ke dalam evaluasi commit.
9. Jangan menghapus atau menimpa catatan evaluasi sebelumnya.
10. Jangan mengarang aturan, hasil pemeriksaan SDK, maupun kesimpulan yang belum memiliki bukti.

**File yang boleh diperbarui hanya:**

- `catatan.md` di root proyek.
- `saran.md` di root proyek.

Kedua file tersebut hanya boleh diperbarui sesuai ketentuan dalam command ini.

---

## 2. Pemeriksaan Awal Repository

Sebelum mengevaluasi commit:

1. Pastikan direktori kerja merupakan root repository Git.
2. Identifikasi branch aktif.
3. Identifikasi SHA lengkap commit HEAD.
4. Periksa kondisi working tree menggunakan `git status`.
5. Catat perubahan yang belum di-commit jika ada.

Tentukan SHA HEAD sebagai target evaluasi. Gunakan SHA tersebut secara konsisten selama seluruh proses.

Perubahan yang belum di-commit tidak boleh dicampurkan dengan perubahan commit yang sedang dievaluasi.

Apabila `catatan.md` atau `saran.md` memiliki perubahan lokal yang belum di-commit, pertahankan perubahan tersebut. Jangan menimpa pekerjaan pengguna.

Tetapkan SHA HEAD sebagai target evaluasi dan pastikan HEAD tidak berubah selama proses.

---

## 3. Baca Aturan Proyek dan Catatan Evaluasi

Sebelum menganalisis kode, baca terlebih dahulu dokumen yang menjadi dasar evaluasi.

### 3.1 Baca AGENTS.md

1. Baca `AGENTS.md` di root proyek.
2. Ikuti seluruh petunjuk yang dirujuk oleh file tersebut.
3. Identifikasi seluruh aturan proyek yang berlaku.
4. Periksa `AGENTS.md` tambahan yang berada di direktori kode yang akan dievaluasi.
5. Baca dokumen aturan yang relevan dengan file yang mengalami perubahan.

Jangan menganggap `AGENTS.md` sebagai satu-satunya sumber aturan apabila proyek memiliki dokumen aturan tambahan.

Cari aturan yang memang berlaku di proyek, termasuk dokumen yang berada di direktori seperti:

- `.kilo/rules/`
- `.kilocode/rules/`
- `.agents/`
- `prompt/aturan/`
- Direktori aturan lainnya yang ditemukan di repository.

Jangan menganggap semua dokumen Markdown sebagai aturan. Pastikan dokumen tersebut memang berisi instruksi atau standar yang berlaku.

### 3.2 Baca catatan.md

Baca file `catatan.md` di root proyek sebelum menentukan commit yang akan dievaluasi.

Tujuannya adalah mengetahui:

- Apakah evaluasi sebelumnya pernah dilakukan.
- SHA commit terakhir yang sudah dievaluasi.
- Commit mana saja yang sudah tercatat.
- Apakah ada evaluasi sebelumnya yang belum selesai.

Jangan membaca ulang commit yang sudah dievaluasi secara lengkap apabila checkpoint-nya masih valid.

---

## 4. Menentukan Commit yang Harus Dievaluasi

Gunakan `catatan.md` sebagai penanda terakhir evaluasi.

Terdapat dua kondisi.

### Kondisi A: Sudah Pernah Dievaluasi

Apabila `catatan.md` memiliki SHA commit terakhir yang sudah dievaluasi secara lengkap:

1. Baca checkpoint milik `.kilo/commands/cek_perubahan_sekarang.md` di `catatan.md`.
2. Gunakan SHA lengkap.
3. Pastikan checkpoint merupakan ancestor dari HEAD aktif.
4. Ambil hanya commit setelah checkpoint sampai HEAD.
5. Jangan membaca ulang commit yang evaluasinya sudah selesai.
6. Apabila checkpoint sama dengan HEAD, laporkan tidak ada commit baru.

Jangan menggunakan checkpoint milik `.kilo/commands/evaluasi_aturan_khusus.md`.

### Kondisi B: Belum Pernah Dievaluasi

Apabila belum ditemukan checkpoint evaluasi yang valid:

1. Ambil maksimal 5 commit terakhir dari branch aktif.
2. Jika jumlah commit kurang dari 5, gunakan seluruh commit yang tersedia.
3. Evaluasi commit tersebut dari yang paling lama hingga yang paling baru.

Lima commit terakhir hanya digunakan sebagai batas awal ketika belum ada riwayat evaluasi yang dapat dikenali.

### Ketentuan Tambahan

1. Gunakan SHA lengkap agar identifikasi commit tidak ambigu.
2. Jangan mengandalkan judul commit saja.
3. Jangan mengulang evaluasi commit yang sudah selesai.
4. Jangan melewatkan commit yang belum dievaluasi.
5. Jika checkpoint tidak lagi merupakan ancestor HEAD, misalnya karena rebase atau force push, jangan menebak rentang evaluasi. Laporkan kondisi tersebut dan jangan mengubah checkpoint.
6. Jika tidak ada commit baru, hentikan proses evaluasi kode dan laporkan bahwa tidak ditemukan commit baru.
7. Jika checkpoint tidak ditemukan, kosong, atau tidak valid, gunakan kondisi B.
8. Apabila checkpoint tidak lagi merupakan ancestor HEAD karena perubahan riwayat Git, laporkan masalah tersebut dan jangan menebak rentang commit.

---

## 5. Analisis Perubahan Setiap Commit

Untuk setiap commit yang belum dievaluasi:

1. Periksa SHA commit.
2. Periksa tanggal commit.
3. Periksa judul commit.
4. Identifikasi seluruh file yang berubah.
5. Periksa file yang ditambahkan, diubah, dihapus, atau dipindahkan.
6. Periksa isi diff commit.
7. Identifikasi fungsi, class, widget, konstruktor, parameter, properti, metode, dan API yang berubah.

Jangan hanya membaca judul atau deskripsi commit.

Periksa perubahan kode sebenarnya.

Gunakan diff setiap commit untuk mengetahui perubahan yang diperkenalkan. Kemudian periksa kondisi kode pada HEAD agar tidak melaporkan masalah yang sudah diperbaiki oleh commit berikutnya.

Untuk merge commit, periksa perubahan terhadap first parent agar perubahan yang masuk melalui merge juga dapat dievaluasi.

Evaluasi seluruh jenis file yang relevan, termasuk:

- File Dart.
- File konfigurasi.
- File dependency.
- File database atau migrasi.
- File dokumentasi teknis yang memengaruhi implementasi.

Jangan mengabaikan perubahan hanya karena file tersebut bukan file Dart.

---

## 6. Pemeriksaan Kesesuaian dengan Aturan Proyek

Sebelum menganalisis kode, baca `AGENTS.md` dan seluruh aturan tambahan yang berlaku.

Pastikan pemeriksaan mencakup:

- Aturan global.
- Aturan khusus proyek.
- Aturan arsitektur.
- Aturan pemanfaatan SDK dan paket.
- Aturan runtime dan error handling.
- Aturan UX/UI.
- Aturan performa.
- Aturan testing.
- Aturan lainnya yang relevan dengan perubahan.

Bandingkan perubahan kode dengan aturan yang sudah dibaca.

Periksa seluruh aturan yang relevan, termasuk:

1. Ketentuan arsitektur proyek.
2. Aturan penulisan kode.
3. Aturan pemanfaatan SDK dan paket.
4. Aturan pengelolaan state.
5. Aturan database dan pengelolaan data.
6. Aturan penanganan error.
7. Aturan keamanan.
8. Aturan performa.
9. Aturan UX/UI apabila perubahan berkaitan dengan tampilan.
10. Aturan testing apabila perubahan berkaitan dengan pengujian.
11. Aturan lainnya yang ditemukan dalam repository.

Jangan menyimpulkan bahwa sebuah kode melanggar aturan tanpa menemukan aturan yang benar-benar mendukung kesimpulan tersebut.

Jika terdapat konflik antaraturan, laporkan kedua sumbernya tanpa menentukan prioritas sendiri apabila prioritasnya belum jelas.

### Bukti Pelanggaran

Setiap pelanggaran wajib menyertakan:

**A. Lokasi kode yang bermasalah**

- Path file.
- Nomor baris.
- Penjelasan bagian kode yang tidak sesuai.

**B. Lokasi aturan yang dilanggar**

- Path file aturan.
- Nomor baris aturan.
- Isi atau inti ketentuan yang dilanggar.

Contoh format:

```text
Pelanggaran:
- File kode: lib/fitur/contoh.dart:35-42
- File aturan: prompt/aturan/optimasi_bug_runtime.md:20-25
- Ketentuan: Setiap operasi asynchronous harus memastikan widget masih mounted sebelum menggunakan context.
- Masalah: Kode menggunakan context setelah await tanpa pemeriksaan mounted.
```

Jangan hanya menyebutkan nama aturan tanpa menunjukkan lokasi aturannya.

Jika terdapat pertentangan antaraturan, laporkan kedua sumber aturan beserta nomor barisnya. Jangan menentukan sendiri aturan mana yang harus diutamakan apabila prioritasnya tidak jelas.

---

## 7. Pemeriksaan Source SDK dan Paket (WAJIB)

Tahapan ini merupakan bagian wajib dari evaluasi.

**Dilarang menyimpulkan bahwa kode sudah sesuai SDK hanya berdasarkan pengetahuan model, pengalaman sebelumnya, atau dokumentasi umum.**

AI wajib membaca source aktual dari SDK dan paket yang digunakan proyek.

Ketentuan ini berlaku meskipun perubahan hanya melibatkan widget sederhana.

Contohnya:

- `Container`
- `SizedBox`
- `Padding`
- `Row`
- `Column`
- `ListView`
- `GridView`
- `Text`
- `Icon`
- `AppBar`
- `Scaffold`
- Widget lainnya.
- Konstruktor dan metode dari paket eksternal.

### 7.1 Identifikasi Versi SDK dan Paket

Periksa:

1. Versi Flutter.
2. Versi Dart.
3. `pubspec.yaml`.
4. `pubspec.lock`.
5. `.dart_tool/package_config.json`.

Gunakan versi yang benar-benar digunakan oleh proyek, bukan langsung membandingkannya dengan versi terbaru yang belum tentu terpasang.

### 7.2 Temukan Source Aktual

Untuk Flutter SDK:

- Temukan direktori SDK Flutter.
- Baca source framework yang berkaitan dengan API yang berubah.
- Periksa deklarasi class, konstruktor, parameter, properti, dan metode.

Untuk Dart SDK:

- Temukan direktori SDK Dart.
- Baca source API yang berkaitan dengan perubahan.

Untuk paket eksternal:

- Identifikasi paket berdasarkan `package_config.json`.
- Cocokkan versinya dengan `pubspec.lock`.
- Temukan direktori source paket yang benar.
- Baca implementasi API yang digunakan.

Jangan hanya membaca README atau dokumentasi paket.

### 7.3 Hal yang Wajib Diperiksa

AI tidak boleh hanya mengandalkan:

- Pengetahuan model.
- Pengalaman sebelumnya.
- Dokumentasi umum.
- README paket.
- Hasil `flutter analyze`.

Pemeriksaan harus dilakukan terhadap versi SDK dan paket yang benar-benar digunakan proyek.

Wajib memeriksa setiap API yang penggunaan atau parameternya berubah dalam commit.

Ketentuan ini juga berlaku untuk widget sederhana seperti:

- Container.
- SizedBox.
- Padding.
- Row.
- Column.
- ListView.
- GridView.
- Text.
- Icon.
- AppBar.
- Scaffold.

Untuk setiap API yang relevan, baca source aktual dan periksa:

1. Deklarasi class.
2. Konstruktor.
3. Parameter.
4. Tipe data parameter.
5. Parameter wajib.
6. Nilai default.
7. Parameter atau konstruktor baru.
8. API deprecated.
9. Perubahan signature.
10. Ketentuan penggunaan dalam implementasi SDK.

Jangan mengabaikan pemeriksaan hanya karena API tersebut sudah sering digunakan.

Jangan hanya menyatakan kode dapat dikompilasi. AI harus membaca deklarasi dan implementasi source API yang digunakan agar pemeriksaannya juga memberikan pengetahuan teknis tentang SDK.

### 7.4 Jangan Melewatkan Pemeriksaan Widget Sederhana

Tidak ada pengecualian untuk widget yang dianggap sederhana atau sudah sering digunakan.

Apabila commit mengubah penggunaan suatu widget, buka source widget tersebut dan periksa konstruktor serta parameter yang digunakan.

Contoh:

Jika perubahan menggunakan:

```dart
Container(
  width: 100,
  height: 100,
)
```

Jangan langsung menyatakan bahwa penggunaan tersebut benar.

Temukan source `Container`, buka deklarasi konstruktor, periksa parameter `width` dan `height`, tipe datanya, serta perilaku implementasinya.

Lakukan hal yang sama untuk setiap widget atau API yang relevan dengan perubahan.

Tujuannya bukan sekadar membuktikan bahwa kode dapat dikompilasi, melainkan memahami API yang benar-benar disediakan SDK.

### 7.5 Bukti Pemeriksaan SDK

Setiap pemeriksaan wajib menyertakan:

- Nama API.
- Path dan baris kode proyek.
- Path dan baris source SDK atau paket.
- Versi SDK atau paket.
- Hasil pemeriksaan.
- Penjelasan ketidaksesuaian apabila ditemukan.

Contoh:

```text
API: Container

Kode proyek:
- lib/fitur/contoh.dart:35-42

Source SDK:
- /path/flutter/packages/flutter/lib/src/widgets/container.dart:240-280

Hasil:
- Konstruktor tersedia.
- Parameter width dan height tersedia.
- Tipe parameter sesuai.
- Tidak ditemukan penggunaan API deprecated pada bagian yang diperiksa.

Status: Sesuai.
```

Path dan nomor baris contoh di atas hanya ilustrasi. Gunakan lokasi sebenarnya dari source yang dibaca.

### 7.6 Jika Source Tidak Ditemukan

Apabila source SDK atau paket tidak tersedia:

1. Cari lokasi SDK atau paket yang benar.
2. Periksa kembali konfigurasi proyek.
3. Jangan langsung menyatakan API sudah sesuai.
4. Catat API yang belum dapat diverifikasi.
5. Jelaskan penyebabnya.
6. Tandai pemeriksaan sebagai belum terverifikasi.

Jangan mengaku telah membaca source SDK apabila source tersebut tidak benar-benar dibuka.

Jika source tidak berhasil ditemukan atau dibaca, tandai sebagai **Belum Terverifikasi**. Jangan mengklaim pemeriksaan telah dilakukan.

Pemeriksaan SDK yang belum selesai tidak boleh dianggap sebagai evaluasi commit yang selesai sepenuhnya.

---

## 8. Susun Hasil Pelanggaran dan Saran Perbaikan

Pisahkan hasil menjadi tiga kategori.

### A. Pelanggaran Aturan

Masukkan temuan yang terbukti tidak sesuai dengan aturan proyek.

Setiap temuan wajib memiliki:

- Prioritas.
- Path dan baris kode.
- Path dan baris aturan.
- Penjelasan pelanggaran.
- Dampak atau risiko.

Hanya berisi kode yang terbukti melanggar aturan proyek.

Cantumkan prioritas, path dan baris kode, path dan baris aturan, penjelasan, serta dampaknya.

### B. Ketidaksesuaian SDK atau Paket

Masukkan temuan seperti:

- Konstruktor tidak tersedia.
- Parameter tidak sesuai.
- API deprecated.
- Tipe parameter tidak sesuai.
- Penggunaan API tidak sesuai implementasi SDK.
- Perbedaan perilaku antara implementasi kode dan source SDK.

Sertakan path dan nomor baris kode serta source SDK.

Berisi masalah konstruktor, parameter, tipe data, penggunaan API, perubahan signature, atau deprecated.

Cantumkan path dan baris kode serta source SDK.

### C. Rekomendasi Perbaikan

Masukkan saran yang meningkatkan kualitas implementasi, walaupun tidak ditemukan pelanggaran aturan.

Contohnya:

- Penggunaan API yang lebih tepat.
- Pemanfaatan fitur SDK yang lebih sesuai.
- Potensi optimasi performa.
- Penyederhanaan implementasi.
- Peningkatan keterbacaan kode.
- Pengurangan risiko bug.

Jangan menyamakan rekomendasi dengan pelanggaran.

Apabila suatu kode hanya dapat ditingkatkan tetapi tidak melanggar aturan, masukkan ke rekomendasi, bukan pelanggaran.

Berisi saran peningkatan kualitas kode yang tidak selalu merupakan pelanggaran aturan.

Pisahkan prioritas:

- Kritis.
- Tinggi.
- Sedang.
- Rendah.

Jangan menyamakan rekomendasi dengan pelanggaran.

---

## 9. Perbarui catatan.md

Setelah evaluasi selesai, perbarui `catatan.md` di root proyek.

Tujuannya adalah menyimpan riwayat commit yang sudah dievaluasi agar proses berikutnya tidak membaca ulang commit yang sama.

### Ketentuan

1. Pertahankan isi catatan sebelumnya.
2. Jangan menghapus riwayat evaluasi lama.
3. Catat setiap commit yang berhasil dievaluasi.
4. Cantumkan SHA lengkap setiap commit.
5. Cantumkan tanggal dan judul commit.
6. Berikan ringkasan singkat hasil evaluasi.
7. Catat temuan penting yang masih perlu ditindaklanjuti.
8. Simpan SHA commit terakhir yang sudah dievaluasi secara lengkap sebagai checkpoint.

Gunakan penanda checkpoint yang konsisten dan mudah ditemukan.

Contoh:

```markdown
<!-- CEK_PERUBAHAN_SEKARANG: CHECKPOINT START -->

Commit terakhir dievaluasi penuh: FULL_COMMIT_SHA
Tanggal evaluasi: 2026-11-08

<!-- CEK_PERUBAHAN_SEKARANG: CHECKPOINT END -->

## Riwayat Evaluasi Commit

### Commit: FULL_COMMIT_SHA

- Tanggal:
- Judul:
- Status evaluasi:
- Ringkasan:
- Temuan penting:
```

Format tersebut merupakan format penanda yang harus dipertahankan pada evaluasi berikutnya.

### Ketentuan Checkpoint

Perhatikan bahwa file tersebut memiliki checkpoint terpisah untuk:

- `.kilo/commands/cek_perubahan_sekarang.md`
- `.kilo/commands/evaluasi_aturan_khusus.md`

Setiap command hanya boleh membaca dan memperbarui checkpoint miliknya sendiri.

Jangan menghapus atau mengubah checkpoint command lainnya.

Checkpoint berarti **commit terakhir yang berhasil dievaluasi sepenuhnya**, bukan sekadar commit terakhir yang pernah dibaca.

Checkpoint hanya boleh maju apabila semua commit sebelumnya dalam rentang evaluasi telah selesai diperiksa, termasuk source SDK dan aturan proyek.

Jika terdapat evaluasi yang belum selesai:

- Catat status sementara.
- Jangan menandainya sebagai selesai.
- Jangan melewati commit yang belum selesai.
- Jangan memajukan checkpoint melewati commit tersebut.

Jangan mengubah `catatan.md` apabila tidak ada commit baru yang perlu dievaluasi.

Setiap riwayat evaluasi harus mencantumkan:

- SHA lengkap.
- Tanggal commit.
- Judul commit.
- Tanggal evaluasi.
- Status evaluasi.
- Ringkasan hasil.
- Temuan yang perlu ditindaklanjuti.

---

## 10. Perbarui saran.md

Apabila ditemukan pelanggaran, ketidaksesuaian SDK, atau rekomendasi perbaikan, tambahkan atau perbarui `saran.md` di root proyek.

### Ketentuan

1. Baca isi `saran.md` terlebih dahulu apabila file sudah tersedia.
2. Pertahankan saran lama yang masih relevan.
3. Jangan menghapus saran lama hanya karena ditemukan saran baru.
4. Letakkan saran terbaru pada urutan paling atas.
5. Perbarui saran lama apabila masalah yang sama sudah pernah dicatat.
6. Hindari duplikasi saran untuk masalah yang identik.
7. Jika saran lama sudah tidak relevan, tandai statusnya berdasarkan hasil evaluasi terbaru. Jangan menghapus riwayat tanpa alasan.
8. Kelompokkan saran berdasarkan prioritas.

### Ketentuan Tambahan

Pertahankan seluruh saran lama yang masih relevan.

Apabila ditemukan saran baru:

1. Tambahkan di bagian paling atas setelah judul utama.
2. Perbarui saran lama apabila membahas masalah yang sama.
3. Hindari duplikasi.
4. Tandai saran yang sudah diperbaiki berdasarkan bukti commit terbaru.
5. Pertahankan riwayat saran lama.

Setiap saran wajib memiliki:

- Tanggal dan SHA commit.
- Prioritas.
- Path dan nomor baris kode.
- Path dan nomor baris aturan atau source SDK jika relevan.
- Masalah.
- Dampak.
- Rekomendasi perbaikan.
- Status.

Jika tidak ada saran baru atau perubahan status saran lama, jangan mengubah `saran.md`.

### Format Saran

```markdown
# Saran Perbaikan

## [2026-11-08] [SHA COMMIT]

### Prioritas: Tinggi

**File:**

- lib/fitur/contoh.dart:35-42

**Masalah:**
Jelaskan masalah yang ditemukan.

**Bukti aturan atau SDK:**

- prompt/aturan/contoh.md:10-15
- path/source/sdk.dart:100-120

**Dampak:**
Jelaskan dampak apabila tidak diperbaiki.

**Rekomendasi:**
Jelaskan perbaikan yang disarankan tanpa langsung mengubah kode.

**Status:** Belum diperbaiki.
```

Jika menemukan saran baru, letakkan di bawah judul utama dan sebelum seluruh saran lama.

Jika tidak ditemukan saran baru maupun perubahan terhadap saran lama, jangan mengubah `saran.md`.

---

## 11. Format Laporan Akhir

Susun hasil evaluasi dalam format yang rapi, sistematis, dan mudah dibaca.

Jangan membuat laporan berupa paragraf panjang tanpa pengelompokan.

Gunakan struktur berikut.

# Laporan Evaluasi Commit

## A. Ringkasan Evaluasi

- Branch aktif:
- HEAD:
- Jumlah commit yang dievaluasi:
- Rentang commit:
- Jumlah file yang berubah:
- Status evaluasi keseluruhan:

## B. Daftar Commit

| No. | SHA Commit | Tanggal | Judul |
| --- | ---------- | ------- | ----- |

Urutkan dari commit paling lama ke paling baru.

## C. Ringkasan Hasil Pemeriksaan

Pisahkan jumlah:

- Pelanggaran aturan.
- Ketidaksesuaian SDK.
- Masalah runtime yang teridentifikasi.
- Rekomendasi perbaikan.
- Pemeriksaan yang belum dapat diverifikasi.

Jangan menyatakan pemeriksaan selesai apabila masih ada tahap wajib yang belum dilakukan.

## D. Pelanggaran Aturan

Untuk setiap temuan gunakan format:

```text
Prioritas:
Lokasi kode:
Lokasi aturan:
Ketentuan yang dilanggar:
Penjelasan:
Dampak:
Rekomendasi:
```

Pastikan lokasi kode dan lokasi aturan sama-sama memiliki nomor baris.

## E. Pemeriksaan Source SDK dan Paket

Gunakan tabel:

| API/Widget | Lokasi Kode | Lokasi Source SDK/Paket | Hasil |
| ---------- | ----------- | ----------------------- | ----- |

Jelaskan secara terperinci apabila ada perbedaan konstruktor, parameter, tipe data, atau status deprecated.

Jangan menyatukan banyak API menjadi satu kesimpulan tanpa bukti masing-masing.

## F. Rekomendasi Perbaikan

Pisahkan berdasarkan prioritas:

1. Kritis.
2. Tinggi.
3. Sedang.
4. Rendah.

Setiap rekomendasi harus memuat:

- Path file.
- Nomor baris.
- Masalah atau potensi peningkatan.
- Alasan rekomendasi.
- Solusi yang disarankan.

Jangan mencantumkan rekomendasi sebagai pelanggaran apabila tidak ditemukan aturan yang dilanggar.

## G. Perubahan Dokumentasi

Laporkan apakah:

- `catatan.md` diperbarui.
- `saran.md` diperbarui.
- SHA checkpoint berhasil diperbarui.
- Ada evaluasi yang masih tertunda.

## H. Pemeriksaan yang Belum Selesai

Laporkan pemeriksaan yang belum selesai, jika ada.

## I. Kesimpulan

Sampaikan kondisi perubahan commit secara objektif.

Gunakan status yang jelas:

- Sesuai.
- Tidak sesuai.
- Perlu perbaikan.
- Belum terverifikasi.

---

## 12. Aturan Penulisan Lokasi Temuan

Setiap temuan harus menggunakan path file dan nomor baris.

Gunakan format:

```text
lib/fitur/contoh.dart:35-42
prompt/aturan/contoh.md:10-15
```

Jangan menggunakan hyperlink.

Jangan hanya menuliskan nama file tanpa lokasi direktori.

Jangan menyebut suatu aturan dilanggar tanpa menunjukkan baris aturan yang menjadi dasar kesimpulan.

Apabila lokasi baris berubah karena commit berikutnya, gunakan nomor baris dari kondisi kode yang sedang dievaluasi dan jelaskan SHA commit terkait.

---

## 13. Pemeriksaan Akhir Sebelum Menyelesaikan Command

Sebelum menyampaikan laporan, pastikan:

- [ ] Semua commit yang belum dievaluasi sudah diperiksa.
- [ ] Tidak ada commit lama yang dievaluasi ulang tanpa alasan.
- [ ] Aturan `AGENTS.md` sudah dibaca.
- [ ] Aturan tambahan yang relevan sudah dibaca.
- [ ] Seluruh file yang berubah sudah diperiksa.
- [ ] Perubahan kode yang relevan sudah dibandingkan dengan source SDK.
- [ ] Konstruktor widget dan parameter yang digunakan sudah diverifikasi.
- [ ] Status deprecated sudah diperiksa.
- [ ] Pelanggaran memiliki bukti path dan nomor baris.
- [ ] Lokasi aturan yang dilanggar memiliki path dan nomor baris.
- [ ] Rekomendasi sudah dipisahkan dari pelanggaran.
- [ ] `catatan.md` menyimpan riwayat dan checkpoint yang benar.
- [ ] `saran.md` menempatkan saran terbaru di bagian paling atas.
- [ ] Tidak ada kode sumber yang diubah.
- [ ] SHA HEAD masih sama dengan target evaluasi ketika pencatatan diselesaikan.

Apabila ada tahapan yang belum berhasil, laporkan secara transparan. Jangan menganggapnya sudah selesai.

**Penting:** Jangan mengakhiri evaluasi hanya dengan mengatakan kode sudah benar atau tidak ditemukan masalah. Setiap kesimpulan harus didukung oleh pemeriksaan aturan proyek dan source SDK yang benar-benar dibaca.

---

## 14. Pemeriksaan Konsistensi Akhir

Sebelum menyelesaikan revisi command:

- Pastikan seluruh instruksi lama yang masih relevan dipertahankan.
- Pastikan tidak ada ketentuan yang saling bertentangan.
- Pastikan checkpoint kedua command terpisah.
- Pastikan evaluasi pertama menggunakan maksimal lima commit.
- Pastikan evaluasi berikutnya hanya membaca commit setelah checkpoint.
- Pastikan source SDK wajib dibaca untuk setiap API yang berubah.
- Pastikan widget sederhana tidak dikecualikan.
- Pastikan setiap pelanggaran menunjukkan path dan baris kode serta aturan.
- Pastikan rekomendasi terpisah dari pelanggaran.
- Pastikan saran terbaru selalu berada di paling atas.
- Pastikan command hanya mengubah dokumentasi evaluasi ketika dijalankan.
- Pastikan laporan akhir memiliki struktur yang konsisten.

---

## 15. Batas Pekerjaan Revisi Ini

Pada pekerjaan revisi command ini:

- Hanya ubah `.kilo/commands/cek_perubahan_sekarang.md`.
- Jangan menjalankan workflow evaluasi commit.
- Jangan mengubah `catatan.md`.
- Jangan mengubah `saran.md`.
- Jangan mengubah kode Dart maupun file sumber lainnya.
- Jangan membuat command baru.
- Jangan mengubah command `evaluasi_aturan_khusus.md`.

Setelah selesai, laporkan:

1. Path file yang diubah.
2. Bagian yang disempurnakan.
3. Konflik atau ambiguitas yang ditemukan dan penyelesaiannya.
4. Konfirmasi bahwa tidak ada kode sumber atau dokumentasi evaluasi yang diubah.

Jangan menyatakan pekerjaan selesai sebelum memeriksa diff dan memastikan hanya file target yang berubah.
filePath">
/home/mbadrudin170/berhenti_merokok/.kilo/commands/cek_perubahan_sekarang.md