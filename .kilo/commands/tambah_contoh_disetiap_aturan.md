
---
description: Audit seluruh file aturan dan tambahkan contoh benar serta salah yang didasarkan pada SDK atau implementasi proyek yang terverifikasi.
agent: code
---

# Tugas: Audit dan Tambahkan Contoh pada File Aturan

## 1. Tujuan

Saya ingin setiap aturan dalam proyek memiliki contoh yang mempermudah AI memahami maksud, batasan, dan cara menerapkannya.

Tugas Anda adalah membaca seluruh file aturan yang berlaku di proyek, mengevaluasi apakah setiap aturan membutuhkan contoh, kemudian menambahkan contoh benar dan salah berdasarkan sumber teknis yang benar-benar tersedia.

Contoh harus membantu AI memahami:
- Seperti apa penerapan aturan yang benar.
- Seperti apa penerapan aturan yang salah.
- Mengapa penerapan pertama dianggap benar.
- Mengapa penerapan kedua dianggap salah.
- Bagaimana SDK atau implementasi proyek menjadi dasar penilaian tersebut.

## 2. Batasan Pekerjaan

1. Fokus pekerjaan hanya pada audit dan penambahan contoh di file aturan.
2. Jangan mengubah kode aplikasi, file Dart, konfigurasi proyek, atau file lainnya di luar cakupan pekerjaan.
3. Jangan membuat aturan baru.
4. Jangan mengubah tujuan, maksud, ketentuan, atau tingkat ketegasan aturan yang sudah ada.
5. Jangan menghapus aturan yang sudah ada.
6. Jangan menulis ulang seluruh file apabila perubahan kecil sudah mencukupi.
7. Pertahankan struktur, judul, urutan, dan format file selama tidak ada alasan kuat untuk mengubahnya.
8. Jangan menambahkan contoh hanya untuk memenuhi jumlah tertentu. Tambahkan contoh apabila memang memberikan manfaat dalam memahami atau menerapkan aturan.
9. Apabila menemukan aturan yang bertentangan, ambigu, atau tidak dapat dipastikan maksudnya, jangan menyelesaikannya dengan asumsi sendiri. Catat masalah tersebut dalam laporan.
10. Jangan menganggap contoh dari AI sebagai sumber kebenaran. Setiap contoh teknis wajib melalui verifikasi sumber.

## 3. Tahap 1 — Inventarisasi Seluruh File Aturan

Sebelum mengubah file apa pun, identifikasi seluruh file yang berisi aturan atau instruksi yang berlaku untuk proyek.

Periksa sumber aturan berikut apabila tersedia:

1. File `AGENTS.md` pada root proyek dan direktori induk yang berlaku.
2. File `CLAUDE.md` dan `CONTEXT.md` apabila digunakan.
3. Seluruh file di dalam `.agents/rules/`.
4. Seluruh file di dalam `.kilo/rules/`.
5. Seluruh file di dalam `prompt/aturan/`.
6. File referensi aturan lainnya seperti `optimasi_ui.md`, `optimasi_ux.md`, `desain.md`, atau `DESAINS.md`.
7. Seluruh file aturan tambahan yang didaftarkan melalui `instructions` di `kilo.jsonc`.
8. File aturan lain yang secara eksplisit dirujuk oleh file aturan utama.

Ketentuan inventarisasi:

- Jangan berasumsi bahwa seluruh aturan hanya berada dalam satu direktori.
- Periksa konfigurasi proyek untuk mengetahui sumber instruksi tambahan.
- Ikuti pola atau glob yang terdaftar dalam konfigurasi apabila memungkinkan.
- Perhatikan aturan global Kilo yang dapat diakses, khususnya `~/.config/kilo/AGENTS.md`.
- Jangan menganggap file yang tidak dapat diakses sudah berhasil diperiksa.
- Hindari membaca file yang sama berulang kali apabila isinya belum berubah.

Buat daftar seluruh file yang ditemukan beserta status pemeriksaannya.

Jangan mulai mengubah file sebelum inventarisasi selesai.

## 4. Tahap 2 — Baca dan Pahami Seluruh Aturan

Baca isi setiap file aturan secara menyeluruh, bukan hanya judul atau sebagian isinya.

Untuk setiap aturan:

1. Pahami tujuan dan maksud aturan.
2. Pahami tindakan yang diwajibkan atau dilarang.
3. Identifikasi kondisi ketika aturan tersebut berlaku.
4. Identifikasi batasan dan pengecualiannya.
5. Perhatikan ketergantungannya terhadap aturan lain.
6. Periksa apakah aturan tersebut sudah mempunyai contoh.
7. Tentukan apakah contoh yang tersedia masih sesuai dengan SDK dan implementasi proyek saat ini.

Jangan menilai kebutuhan contoh hanya berdasarkan panjang atau pendeknya aturan.

## 5. Tahap 3 — Evaluasi Kebutuhan Contoh

Evaluasi setiap aturan dan tentukan apakah aturan tersebut membutuhkan contoh.

### Prioritaskan penambahan contoh pada aturan yang:

1. Mengatur cara menulis atau menggunakan kode.
2. Mengatur penggunaan API, SDK, paket pihak ketiga, atau fungsi tertentu.
3. Memiliki ketentuan yang berpotensi ditafsirkan berbeda.
4. Memiliki beberapa kondisi atau pengecualian.
5. Melarang pola implementasi tertentu.
6. Mengatur struktur, arsitektur, atau pola implementasi proyek.
7. Sering berpotensi menimbulkan kesalahan penerapan.
8. Akan lebih mudah dipahami apabila disertai perbandingan benar dan salah.

### Aturan yang tidak wajib diberikan contoh

Jangan memaksakan contoh pada aturan yang sifatnya sederhana, administratif, atau sudah cukup jelas tanpa contoh.

Apabila contoh justru membuat aturan menjadi lebih panjang, membingungkan, atau menimbulkan kesalahpahaman, tidak perlu menambahkannya.

Catat alasan aturan tersebut tidak membutuhkan contoh dalam laporan akhir.

### Ketentuan evaluasi

Setiap aturan harus mendapatkan salah satu status berikut:

- **Perlu contoh:** aturan membutuhkan contoh untuk memperjelas penerapannya.
- **Sudah memiliki contoh:** contoh yang tersedia sudah jelas dan terverifikasi.
- **Tidak memerlukan contoh:** aturan sudah cukup jelas tanpa contoh.
- **Ditunda:** contoh belum dapat dibuat karena sumber teknis belum tersedia atau maksud aturan belum dapat dipastikan.

## 6. Tahap 4 — Verifikasi Sumber Teknis

Ini merupakan tahap wajib sebelum membuat atau memperbarui contoh.

Setiap contoh harus merujuk pada salah satu sumber berikut.

### A. Source Code SDK

Gunakan source code SDK yang benar-benar terpasang pada lingkungan proyek.

Untuk proyek Flutter dan Dart:

1. Periksa versi Flutter dan Dart yang digunakan.
2. Temukan lokasi SDK yang sebenarnya.
3. Baca source code SDK yang berkaitan langsung dengan aturan.
4. Periksa deklarasi class, method, constructor, parameter, return type, serta perilaku API yang relevan.
5. Pastikan contoh menggunakan API yang tersedia pada versi SDK proyek.

Jangan mengasumsikan lokasi SDK. Periksa lokasi sebenarnya melalui lingkungan kerja.

### B. Source Code Paket Pihak Ketiga

Apabila aturan berkaitan dengan paket pihak ketiga:

1. Periksa versi paket yang digunakan proyek melalui `pubspec.yaml` dan `pubspec.lock`.
2. Temukan lokasi source code paket yang terpasang.
3. Baca implementasi atau deklarasi API yang relevan.
4. Pastikan contoh sesuai dengan versi paket yang digunakan.

Untuk paket Dart dan Flutter, periksa `.pub-cache/hosted/pub.dev/` atau lokasi paket sebenarnya berdasarkan konfigurasi proyek.

### C. File Custom yang Sudah Dibuat

Utamakan implementasi custom proyek apabila aturan mengatur pola atau standar yang khusus berlaku dalam proyek tersebut.

Periksa file implementasi yang relevan, seperti:

- Helper dan utility.
- Service dan repository.
- Provider dan notifier.
- Widget dan komponen custom.
- Extension dan fungsi custom.
- Konfigurasi serta file pendukung.
- Implementasi lain yang menjadi standar proyek.

Apabila sudah ada implementasi custom yang benar dan sesuai aturan, gunakan implementasi tersebut sebagai referensi utama.

Jangan membuat contoh berdasarkan pola umum apabila proyek sudah mempunyai pola custom yang wajib digunakan.

### Prioritas pemilihan sumber

Gunakan urutan berikut:

1. Implementasi custom proyek yang menjadi standar.
2. Source code SDK sesuai versi yang digunakan.
3. Source code paket pihak ketiga sesuai versi yang digunakan.

Pilih sumber yang paling relevan dengan aturan. Urutan tersebut bukan alasan untuk mengabaikan sumber yang lebih tepat secara teknis.

### Larangan dalam verifikasi

- Jangan mengarang nama API, class, method, parameter, atau fungsi.
- Jangan menggunakan API yang tidak tersedia pada versi proyek.
- Jangan menganggap contoh dari dokumentasi internet otomatis sesuai dengan versi SDK proyek.
- Jangan menggunakan kode dari ingatan model tanpa memeriksa sumbernya.
- Jangan menganggap kode yang berhasil dikompilasi otomatis sudah sesuai aturan.
- Jangan mengutip file atau implementasi yang belum benar-benar dibaca.
- Jangan menggunakan sumber yang tidak dapat diakses sebagai dasar untuk mengklaim contoh sudah terverifikasi.

Jika sumber yang diperlukan tidak ditemukan, jangan memaksakan pembuatan contoh. Catat keterbatasannya dalam laporan.

## 7. Tahap 5 — Membuat Contoh Benar dan Salah

Apabila suatu aturan membutuhkan contoh, tambahkan dua jenis contoh berikut.

### A. Contoh Benar

Contoh harus:

1. Memenuhi seluruh ketentuan aturan yang sedang dijelaskan.
2. Mengikuti pola implementasi yang digunakan proyek.
3. Menggunakan API sesuai versi SDK atau paket proyek.
4. Memperlihatkan cara penerapan yang benar secara nyata.
5. Tidak memasukkan ketentuan tambahan yang tidak diwajibkan oleh aturan.

### B. Contoh Salah

Contoh harus:

1. Memperlihatkan pola implementasi yang secara nyata melanggar aturan.
2. Memiliki hubungan langsung dengan aturan yang sedang dijelaskan.
3. Menunjukkan kesalahan secara spesifik agar AI memahami hal yang harus dihindari.
4. Tidak menggunakan API fiktif hanya untuk membuat contoh terlihat salah.
5. Tidak memasukkan banyak kesalahan yang tidak berkaitan sehingga maksud contoh menjadi kabur.

Contoh salah boleh dibuat dengan memodifikasi contoh benar atau menggunakan pola yang bertentangan dengan ketentuan SDK maupun implementasi custom proyek.

Setiap contoh salah wajib disertai penjelasan mengenai bagian yang melanggar aturan.

### C. Penjelasan Setiap Contoh

Berikan penjelasan singkat dan spesifik:

- Mengapa contoh tersebut benar atau salah.
- Ketentuan aturan yang berkaitan.
- Perbedaan utama antara kedua contoh.

Jangan memberikan penjelasan yang hanya mengulang potongan kode.

### D. Format Penulisan

Gunakan format berikut apabila sesuai dengan jenis aturan:

#### Contoh benar

```dart
// Contoh implementasi yang memenuhi aturan.
```

**Alasan:** Penjelasan mengapa implementasi ini benar.

#### Contoh salah

```dart
// Contoh implementasi yang melanggar aturan.
```

**Kesalahan:** Penjelasan bagian yang melanggar aturan dan alasannya.

**Rujukan teknis:**
- `path/ke/file_referensi.dart` — `NamaClass` atau `namaMethod`.
- `path/ke/source_sdk.dart` — API atau implementasi SDK yang diverifikasi.

Sesuaikan bahasa kode dan format contoh dengan jenis aturan. Tidak semua aturan harus menggunakan contoh Dart.

## 8. Tahap 6 — Penempatan Contoh

1. Tempatkan contoh tepat di bawah aturan yang dijelaskannya.
2. Jangan mengumpulkan semua contoh pada satu bagian terpisah apabila hal tersebut membuat hubungan antara aturan dan contoh menjadi tidak jelas.
3. Gunakan judul yang konsisten: `Contoh benar`, `Contoh salah`, dan `Rujukan teknis`.
4. Pertahankan penomoran aturan yang sudah ada.
5. Jangan mengubah urutan aturan hanya untuk menempatkan contoh.
6. Apabila sebuah aturan mempunyai beberapa subketentuan, tempatkan contoh di bawah subketentuan yang relevan.
7. Hindari contoh yang terlalu panjang. Gunakan potongan kode sekecil mungkin selama maksudnya tetap jelas.
8. Hindari pengulangan contoh yang sama pada beberapa aturan. Gunakan rujukan silang apabila diperlukan.

## 9. Tahap 7 — Menangani Aturan yang Bertentangan atau Ambigu

Apabila selama audit ditemukan:

- Dua aturan memiliki ketentuan yang saling bertentangan.
- Sebuah aturan memiliki maksud yang tidak jelas.
- Contoh yang ada bertentangan dengan isi aturan.
- Implementasi custom proyek tidak konsisten dengan aturan.
- Aturan tidak sesuai dengan perilaku SDK yang sebenarnya.

Jangan menentukan sendiri aturan mana yang harus diutamakan.

Lakukan hal berikut:

1. Catat lokasi kedua aturan atau sumber yang bermasalah.
2. Jelaskan letak pertentangannya secara spesifik.
3. Jelaskan dampaknya terhadap pembuatan contoh.
4. Jangan membuat contoh yang seolah-olah menyelesaikan pertentangan.
5. Jangan mengubah isi aturan untuk memperbaiki konflik tanpa dasar yang jelas.

Penambahan contoh pada bagian yang tidak bermasalah tetap boleh dilanjutkan.

## 10. Tahap 8 — Pemeriksaan Setelah Perubahan

Setelah penambahan contoh selesai:

1. Baca kembali seluruh file yang diubah.
2. Pastikan setiap contoh benar-benar sesuai dengan aturan terkait.
3. Periksa kembali seluruh rujukan teknis.
4. Pastikan tidak ada nama API, parameter, class, atau method yang keliru.
5. Pastikan contoh salah benar-benar menunjukkan pelanggaran aturan.
6. Pastikan contoh benar tidak melanggar aturan lain yang berlaku.
7. Pastikan tidak ada aturan asli yang terhapus atau berubah maksudnya.
8. Pastikan tidak ada contoh duplikat yang tidak diperlukan.
9. Pastikan format Markdown tetap rapi.
10. Periksa perubahan menggunakan `git diff` apabila Git tersedia.

Jangan menyatakan pekerjaan selesai apabila masih terdapat contoh yang belum diverifikasi.

## 11. Tahap 9 — Laporan Hasil

Setelah pekerjaan selesai, berikan laporan dengan struktur berikut.

### A. Ringkasan Audit

- Jumlah file aturan yang ditemukan.
- Jumlah file yang berhasil dibaca.
- Jumlah aturan yang diperiksa.
- Jumlah aturan yang membutuhkan contoh.
- Jumlah aturan yang sudah memiliki contoh memadai.
- Jumlah aturan yang tidak memerlukan contoh.
- Jumlah aturan yang ditunda.

### B. File yang Diubah

Tuliskan path lengkap setiap file yang diubah.

Untuk setiap file, jelaskan secara singkat contoh apa saja yang ditambahkan atau diperbaiki.

### C. Aturan yang Tidak Diberi Contoh

Tuliskan aturan yang tidak membutuhkan contoh beserta alasannya.

### D. Kendala dan Temuan

Laporkan:
- Sumber SDK atau paket yang tidak ditemukan.
- File custom yang tidak dapat diakses.
- Aturan yang ambigu.
- Aturan yang bertentangan.
- Contoh yang belum dapat diverifikasi.

### E. Hasil Pemeriksaan

Nyatakan apakah pemeriksaan akhir berhasil atau masih terdapat masalah.

Jangan menyembunyikan bagian yang belum selesai.

## 12. Kriteria Keberhasilan

Pekerjaan dinyatakan selesai apabila:

1. Seluruh file aturan yang berhasil diidentifikasi telah diperiksa.
2. Setiap aturan telah dievaluasi kebutuhan contohnya.
3. Contoh benar dan salah telah ditambahkan pada aturan yang memang membutuhkannya.
4. Seluruh contoh teknis mempunyai rujukan SDK, paket, atau implementasi custom yang telah dibaca.
5. Contoh benar sesuai dengan aturan dan implementasi yang berlaku.
6. Contoh salah menunjukkan pelanggaran yang spesifik.
7. Isi aturan asli tidak berubah maksudnya.
8. Tidak ada file kode aplikasi yang diubah.
9. Laporan akhir mencerminkan pekerjaan yang benar-benar dilakukan.

**Prinsip utama:** Jangan membuat contoh hanya agar file aturan terlihat lengkap. Buat contoh yang akurat, dapat diverifikasi, relevan dengan proyek, dan benar-benar membantu AI memahami serta menjalankan aturan.
