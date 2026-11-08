---
description: Evaluasi commit baru berdasarkan aturan proyek dan source SDK/paket, lalu perbarui catatan serta saran tanpa mengubah kode.
agent: code
---

# Evaluasi Perubahan Commit Terbaru

## Tujuan

Lakukan evaluasi terhadap perubahan yang sudah di-commit pada branch aktif.

Tujuan evaluasi adalah memastikan setiap perubahan:

1. Sesuai dengan aturan yang berlaku di `AGENTS.md` dan aturan proyek lainnya.
2. Sesuai dengan SDK, framework, dan paket yang benar-benar digunakan proyek.
3. Menggunakan API, konstruktor, parameter, properti, dan metode yang tersedia pada versi SDK atau paket terpasang.
4. Tidak menggunakan API deprecated apabila tersedia alternatif yang sesuai.
5. Tidak menimbulkan masalah runtime, bug, atau ketidaksesuaian implementasi.
6. Memiliki dokumentasi temuan dan rekomendasi apabila ditemukan kekurangan.

Command ini hanya bertugas melakukan evaluasi dan dokumentasi.

**Jangan melakukan perbaikan kode secara langsung.**

---

## 1. Batasan Eksekusi

Patuhi seluruh batasan berikut:

1. Jangan mengubah kode Dart.
2. Jangan mengubah kode sumber dalam bahasa pemrograman apa pun.
3. Jangan melakukan refactoring.
4. Jangan memperbaiki bug secara langsung.
5. Jangan menambahkan fitur.
6. Jangan mengubah konfigurasi proyek.
7. Jangan menjalankan formatter yang mengubah file.
8. Jangan melakukan commit, push, reset, rebase, checkout, atau operasi Git lain yang mengubah riwayat maupun kondisi repository.
9. Jangan memasukkan perubahan working tree yang belum di-commit ke dalam evaluasi commit.
10. Jangan menghapus atau menimpa catatan evaluasi sebelumnya.
11. Jangan mengarang aturan, hasil pemeriksaan SDK, maupun kesimpulan yang belum memiliki bukti.
12. Jangan menyatakan pemeriksaan selesai apabila masih ada tahapan wajib yang belum dilakukan.

**File yang boleh diperbarui selama command ini dijalankan hanya:**

- `catatan.md` di root proyek.
- `saran.md` di root proyek.

Kedua file hanya boleh diperbarui sesuai ketentuan pada command ini.

Jangan mengubah file aturan, file command, file kode, konfigurasi, atau dokumentasi lain.

---

## 2. Pemeriksaan Awal Repository

Sebelum mengevaluasi commit:

1. Pastikan direktori kerja merupakan root repository Git.
2. Identifikasi branch aktif.
3. Identifikasi SHA lengkap commit HEAD.
4. Periksa kondisi working tree menggunakan `git status`.
5. Catat perubahan yang belum di-commit.
6. Identifikasi apakah repository sedang berada pada detached HEAD.

Gunakan SHA lengkap HEAD sebagai target evaluasi.

Tetapkan target tersebut sejak awal dan gunakan secara konsisten selama seluruh proses.

Perubahan yang belum di-commit tidak boleh dicampurkan dengan perubahan commit yang sedang dievaluasi.

Jika `catatan.md` atau `saran.md` memiliki perubahan lokal yang belum di-commit:

- Pertahankan perubahan tersebut.
- Jangan menimpa pekerjaan pengguna.
- Periksa apakah pembaruan dokumentasi dapat dilakukan tanpa menghilangkan perubahan lokal.
- Apabila tidak dapat dilakukan dengan aman, jangan mengubah file tersebut dan laporkan kendalanya.

Jika HEAD berubah selama proses evaluasi, jangan menggunakan hasil pemeriksaan sebelumnya untuk memperbarui checkpoint terhadap HEAD yang berbeda.

---

## 3. Baca Aturan Proyek dan Catatan Evaluasi

Sebelum menganalisis kode, baca dokumen yang menjadi dasar evaluasi.

### 3.1 Baca AGENTS.md

1. Baca `AGENTS.md` di root proyek.
2. Ikuti seluruh petunjuk yang dirujuk oleh file tersebut.
3. Identifikasi seluruh aturan proyek yang berlaku.
4. Periksa `AGENTS.md` tambahan yang berada di direktori kode yang akan dievaluasi.
5. Baca seluruh dokumen aturan yang relevan dengan file yang mengalami perubahan.
6. Perhatikan ketentuan prioritas antaraturan yang dinyatakan dalam `AGENTS.md` maupun dokumen aturan lainnya.

Jangan menganggap `AGENTS.md` sebagai satu-satunya sumber aturan apabila proyek memiliki dokumen aturan tambahan.

Cari aturan yang memang berlaku di proyek, termasuk dokumen yang berada di direktori seperti:

- `.kilo/rules/`
- `.kilocode/rules/`
- `.agents/`
- `prompt/aturan/`
- Direktori aturan lainnya yang ditemukan di repository.

Jangan menganggap semua dokumen Markdown sebagai aturan.

Pastikan dokumen tersebut memang berisi instruksi atau standar yang berlaku.

### 3.2 Penanganan Konflik Aturan

Apabila terdapat konflik antaraturan:

1. Identifikasi seluruh aturan yang bertentangan.
2. Catat path dan nomor baris masing-masing aturan.
3. Periksa apakah `AGENTS.md` atau aturan lain sudah menentukan prioritas.
4. Jika prioritas sudah ditentukan secara eksplisit, ikuti ketentuan prioritas tersebut.
5. Jika prioritas belum jelas, jangan menentukan sendiri aturan mana yang harus diutamakan.
6. Laporkan konflik tersebut sebagai temuan yang membutuhkan keputusan.

Jangan menyimpulkan bahwa kode melanggar aturan tanpa memperhitungkan prioritas aturan yang berlaku.

### 3.3 Baca catatan.md

Baca `catatan.md` di root proyek sebelum menentukan commit yang akan dievaluasi.

Tujuannya mengetahui:

- Apakah evaluasi sebelumnya pernah dilakukan.
- SHA commit terakhir yang sudah dievaluasi secara lengkap.
- Commit mana saja yang sudah tercatat.
- Apakah ada evaluasi sebelumnya yang belum selesai.
- Apakah terdapat checkpoint khusus command ini.

Perhatikan bahwa `catatan.md` dapat memiliki checkpoint dari beberapa command.

Untuk command ini, hanya gunakan checkpoint di antara penanda:

`CEK_PERUBAHAN_SEKARANG: CHECKPOINT START`

dan

`CEK_PERUBAHAN_SEKARANG: CHECKPOINT END`

Abaikan checkpoint milik command lainnya.

Jangan menggunakan checkpoint milik:

`.kilo/commands/evaluasi_aturan_khusus.md`

Jangan menyimpulkan checkpoint dari judul commit, tanggal commit, atau posisi entri riwayat terakhir.

### 3.4 Baca saran.md

Baca `saran.md` di root proyek sebelum melakukan evaluasi.

Tujuannya mengetahui:

- Saran yang sudah pernah dicatat.
- Masalah yang sudah pernah ditemukan.
- Masalah yang sudah diperbaiki.
- Masalah yang masih belum diperbaiki.
- Saran yang perlu diperbarui.
- Kemungkinan duplikasi temuan.

Jangan membuat saran baru untuk masalah identik yang sudah tercatat.

---

## 4. Menentukan Commit yang Harus Dievaluasi

Gunakan checkpoint khusus `.kilo/commands/cek_perubahan_sekarang.md` di `catatan.md`.

Tentukan rentang evaluasi berdasarkan dua kondisi berikut.

### Kondisi A: Checkpoint Sudah Tersedia dan Valid

Apabila checkpoint khusus command ini sudah tersedia:

1. Ambil SHA lengkap dari checkpoint tersebut.
2. Pastikan SHA dapat ditemukan dalam riwayat Git.
3. Pastikan checkpoint merupakan ancestor dari HEAD aktif.
4. Identifikasi seluruh commit setelah checkpoint hingga HEAD.
5. Evaluasi hanya commit yang belum dievaluasi.
6. Urutkan commit dari yang paling lama hingga paling baru.

Gunakan riwayat Git untuk menentukan hubungan antarcommit.

Jangan menentukan rentang berdasarkan perkiraan tanggal atau judul commit.

Jika checkpoint sama dengan HEAD, berarti tidak ada commit baru.

Laporkan kondisi tersebut dan hentikan evaluasi tanpa mengubah `catatan.md` maupun `saran.md`.

### Kondisi B: Belum Pernah Memiliki Checkpoint

Apabila penanda checkpoint khusus command ini memang belum tersedia atau masih kosong karena belum pernah dilakukan evaluasi:

1. Ambil maksimal 5 commit terakhir dari branch aktif.
2. Jika jumlah commit kurang dari 5, gunakan seluruh commit yang tersedia.
3. Evaluasi commit dari yang paling lama hingga paling baru.

Lima commit terakhir hanya digunakan sebagai batas awal ketika command ini memang belum memiliki checkpoint sebelumnya.

### Ketentuan Checkpoint Tidak Valid

Perhatikan perbedaan berikut:

**Belum pernah memiliki checkpoint:**

- Penanda checkpoint command ini belum tersedia.
- Penanda tersedia tetapi belum pernah diisi.
- Belum ditemukan riwayat evaluasi untuk command ini.

Dalam kondisi tersebut, gunakan Kondisi B.

**Checkpoint pernah tersedia tetapi tidak valid:**

- SHA tidak ditemukan dalam riwayat Git.
- SHA bukan ancestor dari HEAD.
- Riwayat Git berubah karena rebase atau force push.
- Terdapat lebih dari satu penanda checkpoint yang membuat posisi checkpoint tidak jelas.
- Format checkpoint rusak atau tidak dapat diidentifikasi.

Dalam kondisi tersebut:

1. Jangan menggunakan fallback lima commit.
2. Jangan menebak rentang commit.
3. Jangan mengubah checkpoint.
4. Laporkan alasan checkpoint tidak dapat digunakan.
5. Hentikan penentuan rentang sampai masalah checkpoint dapat diselesaikan.

Fallback lima commit hanya berlaku untuk evaluasi pertama, bukan untuk menggantikan checkpoint yang rusak.

### Ketentuan Tambahan

1. Gunakan SHA lengkap.
2. Jangan mengandalkan judul commit saja.
3. Jangan mengulang evaluasi commit yang sudah selesai.
4. Jangan melewatkan commit yang belum dievaluasi.
5. Jangan menggunakan checkpoint milik command lain.
6. Jangan memajukan checkpoint melewati commit yang belum selesai.
7. Jangan melanjutkan evaluasi commit berikutnya apabila commit sebelumnya belum berhasil dievaluasi secara lengkap.
8. Tetapkan SHA HEAD sebagai target evaluasi dan pastikan target tersebut tetap sama hingga pencatatan selesai.

---

## 5. Analisis Perubahan Setiap Commit

Untuk setiap commit yang belum dievaluasi:

1. Periksa SHA commit.
2. Periksa tanggal commit.
3. Periksa judul commit.
4. Identifikasi seluruh file yang berubah.
5. Periksa file yang ditambahkan.
6. Periksa file yang diubah.
7. Periksa file yang dihapus.
8. Periksa file yang dipindahkan atau diganti nama.
9. Periksa isi diff commit.
10. Identifikasi fungsi, class, widget, konstruktor, parameter, properti, metode, dan API yang berubah.

Jangan hanya membaca judul atau deskripsi commit.

Periksa perubahan sebenarnya melalui diff.

Gunakan diff setiap commit untuk mengetahui perubahan yang diperkenalkan oleh commit tersebut.

Kemudian periksa kondisi kode pada HEAD untuk mengetahui apakah masalah yang ditemukan masih berlaku atau sudah diperbaiki oleh commit berikutnya.

Tujuannya adalah:

- Mengetahui commit yang memperkenalkan masalah.
- Mengetahui lokasi perubahan yang menyebabkan masalah.
- Mengetahui apakah masalah masih ada pada kondisi HEAD.
- Menghindari pelaporan masalah yang sebenarnya sudah diperbaiki.

Jika suatu masalah diperkenalkan oleh commit tertentu lalu diperbaiki oleh commit berikutnya, catat riwayatnya secara tepat dan tandai statusnya sebagai sudah diperbaiki apabila bukti mendukung kesimpulan tersebut.

Untuk merge commit, periksa perubahan terhadap first parent agar perubahan yang masuk melalui merge juga dapat dievaluasi.

Evaluasi seluruh jenis file yang relevan, termasuk:

- File Dart.
- File konfigurasi.
- File dependency.
- File database atau migrasi.
- File dokumentasi teknis yang memengaruhi implementasi.
- File lainnya yang berkaitan dengan perubahan.

Jangan mengabaikan perubahan hanya karena file tersebut bukan file Dart.

---

## 6. Pemeriksaan Kesesuaian dengan Aturan Proyek

Bandingkan perubahan kode dengan seluruh aturan yang relevan dan sudah dibaca.

Periksa sekurang-kurangnya:

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

Jangan menganggap seluruh aturan harus diperiksa dengan bobot yang sama untuk setiap perubahan.

Pilih aturan berdasarkan bagian kode dan jenis perubahan yang sedang dievaluasi.

Namun, jangan melewatkan aturan yang relevan hanya karena perubahan terlihat sederhana.

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

Contoh:

```text
Pelanggaran:
- File kode: lib/fitur/contoh.dart:35-42
- File aturan: .agents/rules/global/optimasi_bug_runtime.md:20-25
- Ketentuan: Operasi asynchronous harus memastikan widget masih mounted sebelum menggunakan context.
- Masalah: Kode menggunakan context setelah await tanpa pemeriksaan mounted.
- Dampak: Berpotensi menimbulkan kesalahan ketika widget sudah tidak terpasang.
```
