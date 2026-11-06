---
description: Audit perubahan kode Dart yang belum di-commit berdasarkan AGENTS.md dan source Flutter/Dart SDK tanpa mengubah file.
agent: ask
---

# Audit Perubahan Kode Dart Sebelum Commit

## 1. Tujuan

Lakukan pemeriksaan terhadap seluruh perubahan kode Dart yang belum di-commit untuk memastikan kesesuaiannya dengan aturan dalam `AGENTS.md` dan implementasi API pada source Flutter/Dart SDK.

Tugas Anda hanya melakukan analisis dan menyampaikan hasil pemeriksaan kepada pengguna.

Pengguna berhak menentukan sendiri apakah temuan tersebut perlu diperbaiki atau tidak.

Jangan melakukan perbaikan otomatis.

## 2. Batasan Utama

Ikuti seluruh batasan berikut selama pemeriksaan:

1. Hanya periksa perubahan pada file berekstensi `.dart`.
2. Jangan memeriksa perubahan isi file non-Dart sebagai objek audit.
3. Jangan mengubah kode maupun file apa pun.
4. Jangan memperbaiki temuan secara otomatis.
5. Jangan melakukan refactoring.
6. Jangan menghapus, menambahkan, atau memindahkan file.
7. Jangan menjalankan formatter yang berpotensi mengubah file.
8. Jangan menjalankan perintah Git yang mengubah repository.
9. Jangan melakukan staging, commit, stash, checkout, reset, restore, atau operasi Git lainnya yang mengubah kondisi repository.
10. Jangan menganggap suatu kode salah hanya karena berbeda dengan preferensi pribadi Anda. Gunakan `AGENTS.md` dan source SDK sebagai dasar pemeriksaan.
11. Jangan mengubah aturan proyek atau `AGENTS.md` meskipun menemukan aturan yang kurang jelas atau bertentangan.
12. Jangan mengambil keputusan perbaikan atas nama pengguna.

Anda hanya diizinkan melakukan operasi baca-saja, seperti membaca file, memeriksa status Git, melihat diff, mencari referensi, dan membaca source SDK.

**Prioritas utama: jangan sampai proses pemeriksaan mengubah kondisi repository atau isi file proyek.**

## 3. Identifikasi Perubahan yang Belum Di-Commit

Pertama, pastikan Anda berada di direktori root repository Git yang benar.

Identifikasi seluruh perubahan kode Dart sejak commit terakhir (`HEAD`), mencakup:

- File Dart yang dimodifikasi.
- File Dart yang baru ditambahkan dan belum dilacak Git.
- File Dart yang dihapus.
- File Dart yang mengalami rename.
- Perubahan yang sudah masuk staging area.
- Perubahan yang belum masuk staging area.

Gunakan perintah Git baca-saja untuk mendapatkan informasi tersebut.

Periksa sekurang-kurangnya:

- `git status --short --untracked-files=all -- '*.dart'`
- `git diff --find-renames --name-status HEAD -- '*.dart'`
- `git diff --no-ext-diff --unified=80 HEAD -- '*.dart'`
- `git ls-files --others --exclude-standard -- '*.dart'`

Ketentuan:

1. Gunakan `git diff HEAD` sebagai pembanding agar perubahan staged dan unstaged terhadap commit terakhir dapat diperiksa bersama.
2. File Dart baru yang belum dilacak Git harus diperiksa dengan membaca isi file secara langsung karena tidak muncul dalam `git diff HEAD`.
3. File Dart yang dihapus tetap harus diperiksa melalui diff untuk memahami bagian kode yang dihapus.
4. Jangan sampai perubahan staged terlewat hanya karena Anda hanya membaca `git diff` tanpa membandingkannya dengan `HEAD`.
5. Jangan memeriksa isi file non-Dart yang berubah.
6. File non-Dart hanya boleh dilihat sebatas informasi metadata yang benar-benar diperlukan untuk menentukan versi SDK atau memahami konteks teknis pemeriksaan. Jangan menjadikannya objek audit.

Jika tidak terdapat perubahan kode Dart, sampaikan bahwa tidak ada perubahan Dart yang perlu diperiksa. Jangan memperluas pemeriksaan ke file lain.

Jika repository tidak memiliki commit `HEAD`, atau kondisi Git tidak memungkinkan perbandingan yang dapat dipercaya, sampaikan keterbatasannya dan jangan mengarang hasil pemeriksaan.

## 4. Baca AGENTS.md Terlebih Dahulu

Sebelum menganalisis kode, baca aturan `AGENTS.md` yang berlaku untuk setiap file Dart yang berubah.

Lakukan langkah berikut:

1. Temukan `AGENTS.md` di root proyek.
2. Temukan `AGENTS.md` di direktori induk maupun subdirektori yang aturannya berlaku terhadap file Dart yang berubah.
3. Baca aturan dari tingkat direktori paling atas menuju direktori yang lebih spesifik.
4. Jika `AGENTS.md` secara eksplisit merujuk ke file aturan lain yang wajib dibaca, baca juga aturan tersebut.
5. Pastikan setiap file Dart diperiksa berdasarkan seluruh aturan yang memang berlaku untuk lokasinya.

Jangan menganggap bahwa semua aturan berlaku untuk semua direktori. Perhatikan cakupan masing-masing file aturan.

### Hal yang harus diperiksa

Bandingkan kode yang berubah dengan aturan yang berlaku, termasuk:

- Struktur dan arsitektur kode.
- Penggunaan Riverpod dan manajemen state.
- Penggunaan provider, notifier, dan dependency.
- Pengelolaan lifecycle widget.
- Penanganan asynchronous.
- Penanganan error dan exception.
- Null safety dan keamanan tipe data.
- Penggunaan paket dan API.
- Pengelolaan resource dan memory.
- Konvensi penamaan dan struktur file.
- Aturan UX/UI apabila perubahan berkaitan dengan antarmuka.
- Ketentuan lain yang tercantum dalam `AGENTS.md`.

Daftar tersebut bukan pengganti isi `AGENTS.md`. Jadikan aturan proyek sebagai acuan utama.

### Ketentuan jika menemukan konflik aturan

Jika terdapat aturan yang saling bertentangan:

1. Jangan memilih salah satu aturan berdasarkan asumsi pribadi.
2. Tunjukkan kedua aturan yang bertentangan.
3. Cantumkan lokasi masing-masing aturan.
4. Jelaskan bagian kode yang terdampak.
5. Serahkan keputusan kepada pengguna.

Jangan mengubah atau mengabaikan aturan yang bertentangan secara sepihak.

## 5. Analisis Perubahan Kode Dart

Setelah memahami aturan yang berlaku, periksa perubahan kode Dart satu per satu.

Fokuskan pemeriksaan pada bagian kode yang benar-benar berubah.

Gunakan konteks kode di sekitarnya hanya apabila diperlukan untuk memahami implementasi, dependency, alur data, atau dampak perubahan.

Jangan melakukan audit menyeluruh terhadap bagian kode yang tidak berubah dan tidak berkaitan dengan perubahan tersebut.

Periksa beberapa aspek berikut:

1. Apakah implementasi sesuai dengan aturan `AGENTS.md`?
2. Apakah terdapat kesalahan penggunaan API?
3. Apakah tipe data yang digunakan sudah benar?
4. Apakah null safety sudah ditangani dengan benar?
5. Apakah terdapat kemungkinan runtime error?
6. Apakah terdapat kesalahan pada asynchronous operation?
7. Apakah lifecycle dan resource sudah dikelola dengan benar?
8. Apakah perubahan dapat menimbulkan efek samping terhadap kode yang sudah ada?
9. Apakah perubahan menggunakan API yang benar-benar tersedia pada SDK proyek?
10. Apakah implementasinya sesuai dengan perilaku yang ditentukan oleh source SDK?

Jangan menyimpulkan bahwa kode sudah benar hanya karena terlihat masuk akal atau tidak menunjukkan kesalahan secara visual.

## 6. Wajib Membaca Source Flutter/Dart SDK

Bagian ini wajib dilakukan.

Jangan hanya mengandalkan pengetahuan model, dokumentasi umum, contoh kode internet, atau asumsi mengenai perilaku API.

Anda harus membaca source code SDK yang berkaitan langsung dengan kode Dart yang berubah.

### 6.1 Identifikasi SDK yang digunakan proyek

Identifikasi versi Flutter dan Dart yang benar-benar digunakan oleh proyek.

Gunakan informasi dari environment proyek, misalnya:

- `flutter --version`
- `dart --version`
- Lokasi executable Flutter dan Dart.
- Lokasi instalasi SDK yang digunakan.

Jangan menggunakan source dari SDK versi lain sebagai dasar untuk menyatakan bahwa implementasi proyek sudah sesuai.

Jangan mengasumsikan lokasi SDK tanpa memverifikasinya terlebih dahulu.

### 6.2 Tentukan source SDK yang relevan

Gunakan source SDK sesuai API yang digunakan dalam perubahan kode.

Beberapa lokasi yang dapat diperiksa:

- Flutter Framework: `FLUTTER_ROOT/packages/flutter/lib/src/`
- Dart SDK: `DART_SDK/lib/`
- Flutter Engine API yang tersedia melalui SDK: `FLUTTER_ROOT/bin/cache/pkg/sky_engine/lib/`

Lokasi tersebut merupakan acuan pencarian. Gunakan lokasi aktual SDK yang ditemukan pada environment proyek.

### 6.3 Cara memeriksa source SDK

Untuk setiap penggunaan API yang relevan pada kode yang berubah:

1. Identifikasi nama class, method, property, constructor, atau fungsi yang digunakan.
2. Temukan deklarasi API tersebut pada source SDK.
3. Baca deklarasi dan implementasi yang relevan.
4. Periksa parameter, tipe data, generic type, nullability, return type, dan batasan penggunaannya.
5. Periksa implementasi internal apabila diperlukan untuk memahami perilaku sebenarnya.
6. Cocokkan penggunaan API dalam kode proyek dengan source SDK.
7. Periksa apakah perilaku kode sesuai dengan kontrak dan implementasi API pada SDK.
8. Catat lokasi source SDK yang menjadi bukti pemeriksaan.

Periksa pula perubahan yang berkaitan dengan:

- Widget dan Element lifecycle.
- State dan rebuild.
- Provider dan dependency apabila berkaitan dengan API Flutter/Dart.
- Future, Stream, async, dan await.
- Collection dan operasi data.
- Callback dan event handling.
- Resource management dan disposal.
- API lainnya yang benar-benar digunakan oleh perubahan kode.

Tidak perlu membaca seluruh source SDK. Fokus pada class, method, dan implementasi yang relevan dengan perubahan.

### 6.4 Jika menggunakan API dari paket pihak ketiga

Apabila kode yang berubah menggunakan API dari paket pihak ketiga:

1. Jangan menganggap source paket pihak ketiga sebagai source Flutter/Dart SDK.
2. Identifikasi paket yang menyediakan API tersebut.
3. Jika diperlukan untuk memastikan ketepatan penggunaan API, periksa source paket pada lokasi dependensi yang digunakan proyek.
4. Bedakan dengan jelas hasil pemeriksaan source SDK dan source paket pihak ketiga.
5. Jangan menyatakan API paket pihak ketiga telah diverifikasi melalui source SDK.

### 6.5 Jika source SDK tidak ditemukan

Jika source SDK tidak dapat ditemukan atau dibaca:

1. Jangan menebak implementasi internal SDK.
2. Jangan menyatakan kode sudah sesuai SDK tanpa bukti.
3. Tandai pemeriksaan API terkait sebagai belum dapat diverifikasi.
4. Cantumkan source atau informasi yang tidak dapat diakses.
5. Lanjutkan pemeriksaan bagian lain yang masih dapat diverifikasi.

## 7. Standar Pembuktian Temuan

Jangan melaporkan dugaan sebagai kesalahan yang sudah terbukti.

Setiap temuan harus memiliki bukti yang dapat diperiksa.

Sebuah temuan harus mencantumkan:

1. Lokasi file Dart yang berubah.
2. Nomor baris kode yang bermasalah.
3. Potongan kode yang relevan apabila diperlukan.
4. Aturan `AGENTS.md` yang berkaitan, termasuk lokasi atau judul bagiannya.
5. Lokasi source SDK yang relevan apabila temuan berkaitan dengan API SDK.
6. Penjelasan teknis mengenai ketidaksesuaian.
7. Dampak atau risiko yang mungkin terjadi.
8. Tingkat keyakinan pemeriksaan.

Gunakan klasifikasi berikut:

- **Kritis:** Ketidaksesuaian yang dapat menyebabkan kerusakan data serius, kegagalan aplikasi, atau masalah runtime yang sangat serius.
- **Tinggi:** Ketidaksesuaian yang berpotensi menyebabkan kegagalan fungsi utama atau kesalahan runtime serius.
- **Sedang:** Ketidaksesuaian yang dapat menyebabkan perilaku tidak sesuai, bug, atau masalah pemeliharaan.
- **Rendah:** Ketidaksesuaian kecil terhadap standar proyek yang tidak menimbulkan dampak besar.
- **Belum Terverifikasi:** Belum tersedia cukup bukti untuk memastikan apakah implementasi benar atau salah.

Jangan memberikan tingkat risiko tinggi hanya berdasarkan kemungkinan yang belum memiliki bukti memadai.

## 8. Format Laporan Pemeriksaan

Setelah seluruh pemeriksaan selesai, tampilkan hasil dengan susunan berikut.

### A. Ringkasan Pemeriksaan

Tampilkan:

- Jumlah file Dart yang dimodifikasi.
- Jumlah file Dart baru.
- Jumlah file Dart yang dihapus.
- Jumlah file Dart yang di-rename.
- Jumlah file yang berhasil diperiksa.
- Status pemeriksaan `AGENTS.md`.
- Status pemeriksaan source SDK.

### B. Temuan Ketidaksesuaian

Jika ditemukan masalah, tampilkan setiap masalah secara terpisah.

Gunakan format berikut:

#### Temuan [nomor] — [Tingkat Risiko]

**File:** `path/to/file.dart`

**Baris:** Nomor baris yang berkaitan.

**Kode yang diperiksa:**
Tampilkan potongan kode yang relevan.

**Aturan AGENTS.md:**
Jelaskan aturan yang tidak dipatuhi dan lokasi aturannya.

**Bukti dari source SDK:**
Cantumkan lokasi source SDK, class atau method yang diperiksa, serta bagian implementasi yang relevan.

**Analisis:**
Jelaskan secara teknis mengapa kode tersebut tidak sesuai atau berpotensi bermasalah.

**Dampak:**
Jelaskan konsekuensi yang mungkin terjadi.

**Keyakinan:** Tinggi / Sedang / Rendah.

Jangan mencantumkan bagian yang tidak memiliki bukti sebagai kesalahan yang sudah dipastikan.

### C. Pemeriksaan yang Belum Dapat Diverifikasi

Cantumkan bagian yang tidak dapat dipastikan karena keterbatasan source, informasi versi SDK, atau bukti teknis lainnya.

Jelaskan alasan keterbatasannya.

### D. Kesimpulan

Gunakan salah satu kesimpulan berikut:

- **Tidak ditemukan ketidaksesuaian:** Seluruh bagian yang diperiksa tidak menunjukkan pelanggaran yang dapat dibuktikan.
- **Ditemukan ketidaksesuaian:** Terdapat satu atau lebih masalah yang perlu diketahui pengguna.
- **Pemeriksaan belum lengkap:** Terdapat bagian penting yang belum dapat diverifikasi.

Jangan memberikan status lulus sepenuhnya apabila masih terdapat bagian penting yang belum diperiksa.

## 9. Ketentuan Setelah Pemeriksaan

Setelah laporan selesai:

1. Hentikan pemeriksaan.
2. Jangan memperbaiki kode.
3. Jangan menawarkan untuk langsung menerapkan perbaikan.
4. Jangan mengubah file apa pun.
5. Jangan melakukan commit.
6. Tunggu keputusan pengguna.

Pengguna yang akan menentukan apakah temuan perlu diperbaiki, dibiarkan, atau diperiksa lebih lanjut.

## 10. Prinsip Utama

Ingat tujuan command ini:

**Memastikan pengguna mengetahui apakah perubahan kode Dart yang belum di-commit sudah sesuai dengan AGENTS.md dan source Flutter/Dart SDK sebelum pengguna melakukan commit.**

Tugas Anda adalah menjadi pemeriksa teknis, bukan pelaksana perbaikan.

Laporkan fakta, bukti, dan risiko secara objektif. Jangan mengambil keputusan yang menjadi hak pengguna.
