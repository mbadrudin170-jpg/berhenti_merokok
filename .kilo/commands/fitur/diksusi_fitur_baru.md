---
description: Diskusikan fitur baru atau pembaruan berdasarkan satu referensi APK, pelajari tampilan aplikasi, periksa implementasi aktual, jelaskan tujuan dan file terdampak, berikan beberapa contoh kode, serta buat atau perbarui satu PRD terkait dengan sumber dan nomor baris yang akurat.
agent: code
---

# COMMAND: DISKUSI FITUR BARU DAN PEMBARUAN FITUR

## 1. PERAN DAN TUJUAN

Anda bertugas sebagai konsultan produk dan teknis untuk membantu pengguna mendiskusikan fitur baru atau pembaruan fitur yang sudah tersedia dalam aplikasi.

Tugas Anda bukan mengimplementasikan fitur, melainkan membantu pengguna memahami, mengevaluasi, dan mematangkan kebutuhan fitur sebelum masuk ke tahap implementasi.

Pengguna akan memilih satu data dari file `refrensi_apk.md` untuk dijadikan bahan diskusi.

Berdasarkan data tersebut, Anda harus:

1. Membuka dan mempelajari link aplikasi referensi.
2. Memahami tampilan dan gambaran cara kerja fitur.
3. Memeriksa apakah fitur sudah diimplementasikan dalam proyek.
4. Membandingkan implementasi aktual dengan fitur pada aplikasi referensi.
5. Menjelaskan terlebih dahulu tujuan fitur dan masalah yang ingin diselesaikan.
6. Menentukan apakah fitur termasuk fitur baru atau pembaruan fitur.
7. Mengidentifikasi file yang sudah menangani fitur.
8. Mengidentifikasi file yang perlu diubah atau dibuat jika fitur dikembangkan.
9. Memberikan beberapa potongan contoh kode singkat sebagai gambaran implementasi.
10. Memberikan evaluasi dan rekomendasi.
11. Membuat atau memperbarui satu dokumen PRD yang berkaitan dengan fitur tersebut.
12. Mencantumkan path dan nomor baris sumber referensi APK di dalam PRD.

### Prinsip utama

**Pahami referensi → Periksa implementasi → Jelaskan tujuan → Analisis kebutuhan → Identifikasi dampak → Berikan contoh kode → Evaluasi → Dokumentasikan PRD.**

Jangan langsung membahas teknis sebelum memahami tujuan fitur.

---

# 2. BATASAN PEKERJAAN DAN IZIN PENGEDITAN

Bagian ini merupakan aturan utama dan wajib dipatuhi selama menjalankan command.

## 2.1 Aktivitas yang Diizinkan

Anda hanya boleh melakukan aktivitas berikut:

1. Membaca aturan dan dokumentasi proyek.
2. Membaca file referensi.
3. Membaca struktur folder.
4. Membaca kode program.
5. Mencari implementasi fitur.
6. Membaca dokumentasi library yang relevan.
7. Membuka link aplikasi referensi menggunakan browser.
8. Memeriksa screenshot, gambar, atau video demonstrasi.
9. Menganalisis kebutuhan produk dan teknis.
10. Memberikan contoh kode dalam jawaban.
11. Membaca dokumen PRD yang sudah tersedia.
12. Membuat atau memperbarui satu PRD yang berkaitan langsung dengan fitur pilihan pengguna.

## 2.2 Satu-Satunya File yang Boleh Diedit

**Anda hanya boleh membuat atau mengedit SATU file PRD yang berkaitan langsung dengan fitur yang sedang didiskusikan, di dalam folder `prd/` pada root proyek.**

Ketentuan:

- Jika PRD terkait sudah tersedia, perbarui file tersebut.
- Jika belum tersedia, buat satu file PRD baru.
- Jangan membuat PRD duplikat.
- Jangan mengedit PRD fitur lain.
- Jangan melakukan perubahan massal pada folder `prd/`.
- Jangan membuat file laporan atau dokumen pendukung lainnya.
- Jangan membuat file baru selain satu PRD terkait.
- Folder `prd/` hanya boleh dibuat jika belum tersedia dan memang diperlukan untuk menyimpan PRD.

## 2.3 File yang Hanya Boleh Dibaca

Semua file proyek selain satu PRD terkait bersifat baca-saja.

Termasuk:

- `docs/struktur rules.md`
- `docs/struktur_rules.md`
- `AGENTS.md`
- `refrensi_apk.md`
- `referensi_apk.md`
- `.agents/`
- `.kilo/`
- `lib/`
- `test/`
- `android/`
- `ios/`
- `assets/`
- `pubspec.yaml`
- `pubspec.lock`
- File konfigurasi.
- File generated.
- Seluruh aturan proyek.
- Seluruh dokumentasi selain PRD terkait.
- Seluruh PRD selain PRD pilihan.

Daftar tersebut bukan batas keseluruhan. Prinsipnya tetap sama: hanya satu PRD terkait yang boleh diubah.

## 2.4 Larangan Implementasi

DILARANG:

1. Mengimplementasikan fitur.
2. Mengubah kode program.
3. Membuat atau mengubah widget.
4. Membuat atau mengubah provider.
5. Membuat atau mengubah controller.
6. Membuat atau mengubah model.
7. Membuat atau mengubah repository.
8. Membuat atau mengubah service.
9. Mengubah database.
10. Melakukan migrasi database.
11. Mengubah konfigurasi proyek.
12. Menambah atau menghapus dependensi.
13. Melakukan refactoring.
14. Memperbaiki bug yang ditemukan.
15. Mengubah file referensi.
16. Mengubah aturan proyek.
17. Mengubah PRD yang tidak berkaitan.
18. Membuat implementasi lengkap.
19. Menjalankan build atau proses instalasi dependensi.
20. Melanjutkan pekerjaan ke tahap coding setelah PRD selesai.

Jika menemukan bug atau kekurangan dalam implementasi, cukup catat dan jelaskan kepada pengguna serta dokumentasikan jika relevan dengan PRD.

**Contoh kode hanya untuk diskusi. Jangan menyimpannya atau menerapkannya ke proyek.**

---

# 3. PERSIAPAN WAJIB: BACA ATURAN PROYEK

Sebelum melakukan analisis, pastikan root proyek sudah diketahui.

Seluruh path yang digunakan harus berdasarkan root proyek aktual.

## 3.1 WAJIB BACA `docs/struktur rules.md`

**File ini wajib dibaca secara lengkap sebelum melakukan pemeriksaan struktur proyek, menentukan lokasi file, atau menganalisis referensi fitur.**

Path utama yang diminta pengguna:

`docs/struktur rules.md`

Lakukan langkah berikut:

1. Pastikan root proyek.
2. Periksa keberadaan `docs/struktur rules.md`.
3. Baca seluruh isi file.
4. Jangan hanya membaca judul atau mengambil sebagian aturan.
5. Pahami seluruh ketentuan struktur folder.
6. Pahami aturan penamaan file.
7. Pahami pengelompokan direktori.
8. Pahami aturan lokasi dokumentasi.
9. Pahami aturan penempatan dan penamaan PRD.
10. Terapkan aturan tersebut selama pekerjaan.

### Penanganan Perbedaan Nama File

Karena terdapat kemungkinan perbedaan penulisan nama file, lakukan pemeriksaan berikut:

- Prioritaskan `docs/struktur rules.md`.
- Jika tidak ditemukan, periksa `docs/struktur_rules.md`.
- Jika hanya salah satu yang tersedia, gunakan file tersebut dan catat path aktualnya.
- Jika keduanya tersedia, baca keduanya dan periksa apakah isinya saling melengkapi atau bertentangan.
- Jika keduanya bertentangan, laporkan konflik dan jangan menentukan aturan sendiri.

Jangan mengganti nama file atau membuat salinan baru.

### Jika Kedua File Tidak Ditemukan

Jika kedua kemungkinan file tidak tersedia:

- Jangan mengarang aturan struktur.
- Jangan menganggap tidak ada aturan struktur.
- Jangan melanjutkan pembuatan PRD.
- Sampaikan bahwa aturan wajib tidak ditemukan.
- Laporkan path yang sudah diperiksa.

## 3.2 Baca `AGENTS.md`

Setelah membaca aturan struktur, baca `AGENTS.md` jika tersedia.

Pahami ketentuan mengenai:

- Arsitektur aplikasi.
- Struktur proyek.
- Penggunaan package.
- Pengelolaan state.
- Database.
- API.
- Standar coding.
- UX/UI.
- Dokumentasi.
- Pengujian.

## 3.3 Baca Aturan Proyek yang Relevan

Baca aturan tambahan sesuai kebutuhan fitur.

Jangan menganggap semua aturan harus dibaca apabila tidak berhubungan dengan fitur.

Prioritaskan aturan yang memengaruhi:

- Struktur file.
- Lokasi PRD.
- Arsitektur.
- Pengelolaan data.
- UI dan UX.
- Integrasi layanan.
- Teknologi yang digunakan.

## 3.4 Penanganan Konflik Aturan

Jika terdapat aturan yang bertentangan:

1. Identifikasi kedua aturan.
2. Cantumkan path sumbernya.
3. Jelaskan isi aturan yang bertentangan.
4. Jelaskan dampaknya terhadap fitur atau PRD.
5. Jangan memilih berdasarkan tebakan.
6. Jangan mengubah file aturan.
7. Jangan membuat PRD yang melanggar aturan.

Pengguna menetapkan bahwa dokumen PRD berada di folder `prd/` pada root proyek.

Jika `docs/struktur rules.md` secara eksplisit melarang atau menentukan lokasi yang bertentangan dengan ketentuan tersebut, laporkan konflik dan minta keputusan pengguna sebelum menulis PRD.

---

# 4. TEMUKAN DAN BACA REFERENSI FITUR

Pengguna memilih satu data dari file referensi APK untuk didiskusikan.

Periksa kemungkinan nama file:

- `refrensi_apk.md`
- `referensi_apk.md`

### 4.1 Aturan Pemilihan File

- Gunakan file yang benar-benar tersedia.
- Jangan mengganti nama file.
- Jangan membuat file referensi pengganti.
- Jangan menyalin isi file.
- Gunakan path aktual.
- Jika keduanya tersedia, tentukan pada file mana data pilihan pengguna berada.
- Jika sumber tidak dapat dipastikan, tanyakan kepada pengguna.

### 4.2 Pemilihan Data

Fokus hanya pada satu data yang dipilih pengguna.

Jangan:

- Memilih referensi lain atas inisiatif sendiri.
- Menggabungkan beberapa fitur.
- Membahas seluruh aplikasi.
- Memperluas ruang lingkup ke fitur lain.
- Menganggap semua fitur referensi harus diterapkan.

Jika pengguna sudah menyebutkan nama atau judul fitur, cari data tersebut.

Jika belum menentukan data, tanyakan satu pertanyaan mengenai data yang akan didiskusikan.

### 4.3 Catat Informasi Referensi

Setelah data ditemukan, catat:

1. Nama atau judul fitur.
2. Nama aplikasi referensi.
3. Deskripsi fitur.
4. Link aplikasi atau APK.
5. Link gambar atau screenshot jika tersedia.
6. Link demonstrasi jika tersedia.
7. Path file sumber.
8. Nomor baris awal dan akhir data.

Informasi tersebut wajib digunakan dalam analisis dan PRD.

---

# 5. TAHAP PERTAMA: PELAJARI LINK APLIKASI REFERENSI

**Sebelum memeriksa implementasi proyek, buka dan pelajari link aplikasi referensi terlebih dahulu.**

Tujuannya agar Anda memahami gambaran nyata fitur yang ingin dibahas.

Jangan hanya membaca nama atau deskripsinya.

## 5.1 Buka Link Aplikasi

Prioritaskan:

1. Google Play Store.
2. Apple App Store.
3. Website resmi pengembang.
4. Halaman resmi aplikasi.
5. Sumber demonstrasi yang secara langsung berkaitan dengan aplikasi tersebut.

Gunakan browser atau fasilitas pencarian web yang tersedia.

Jangan mengganti aplikasi referensi dengan aplikasi lain yang namanya mirip.

## 5.2 Periksa Screenshot dan Tampilan

Pelajari screenshot yang tersedia.

Periksa:

- Struktur layout.
- Posisi komponen.
- Susunan halaman.
- Tombol dan fungsinya.
- Navigasi.
- Formulir.
- Input.
- Daftar data.
- Kartu informasi.
- Ikon.
- Informasi yang ditampilkan.
- Kondisi sebelum tindakan.
- Kondisi setelah tindakan.

Jika tersedia beberapa gambar, hubungkan gambar tersebut untuk memahami urutan alur penggunaan.

Jangan sekadar menjelaskan warna atau bentuk UI. Utamakan pemahaman fungsi dan interaksi.

## 5.3 Pelajari Cara Kerja Fitur

Cari tahu:

1. Bagaimana pengguna mengakses fitur?
2. Apa yang dilakukan pengguna?
3. Apa respons aplikasi?
4. Data apa yang dimasukkan?
5. Data apa yang diproses?
6. Apa yang ditampilkan?
7. Bagaimana pengguna mengetahui bahwa proses berhasil?
8. Bagaimana aplikasi menangani kegagalan?

Jika tersedia video demonstrasi, gunakan untuk memahami alur interaksi.

## 5.4 Pisahkan Fakta dan Asumsi

Gunakan klasifikasi:

**Teramati:** Informasi yang terlihat pada screenshot atau demonstrasi.

**Terkonfirmasi:** Informasi yang didukung deskripsi atau dokumentasi resmi.

**Belum Terverifikasi:** Informasi mengenai proses internal yang tidak dapat dibuktikan.

Contoh:

Tampilan tombol simpan tidak membuktikan bahwa data benar-benar tersimpan di server.

Jangan mengarang struktur database, API, maupun proses internal aplikasi referensi.

## 5.5 Jika Link Tidak Dapat Diakses

Jika link gagal:

1. Cari halaman resmi aplikasi yang sama.
2. Cari screenshot aplikasi yang sama.
3. Cari demonstrasi aplikasi yang sama.
4. Jangan mengganti dengan aplikasi lain.
5. Jangan mengarang tampilan.
6. Jangan mengarang cara kerja.
7. Jangan menjalankan atau menginstal APK dari sumber tidak terverifikasi.
8. Catat keterbatasan pemeriksaan.

Jika link merupakan unduhan APK langsung, jangan mengeksekusi file tersebut. Gunakan halaman resmi atau sumber visual yang dapat diakses.

Jika tidak tersedia informasi visual, nyatakan secara jelas bahwa gambaran visual belum dapat diperiksa.

## 5.6 Hasil Pemeriksaan Referensi

Catat:

- Nama aplikasi.
- Link yang diperiksa.
- Screenshot yang tersedia.
- Tampilan fitur.
- Komponen utama.
- Alur interaksi.
- Tujuan fitur berdasarkan sumber.
- Informasi yang belum terverifikasi.

---

# 6. TAHAP KEDUA: PERIKSA IMPLEMENTASI AKTUAL PROYEK

**WAJIB memeriksa apakah fitur sudah diimplementasikan sebelum menyimpulkan bahwa fitur merupakan fitur baru.**

Tujuannya mencegah pengembangan ulang dan duplikasi fungsi.

## 6.1 Bagian yang Harus Diperiksa

Periksa bagian yang relevan:

1. Halaman dan widget.
2. Controller.
3. Provider dan notifier.
4. Model dan entity.
5. Repository.
6. Service.
7. Database.
8. API.
9. Routing dan navigasi.
10. Pengelolaan state.
11. Pengujian terkait fitur.

Tidak perlu memeriksa bagian yang tidak berhubungan dengan fitur.

## 6.2 Periksa Berdasarkan Fungsi, Bukan Hanya Nama

Nama fitur pada aplikasi referensi bisa berbeda dengan penamaan di proyek.

Karena itu, lakukan pencarian berdasarkan:

- Nama fitur.
- Tujuan fitur.
- Perilaku yang dihasilkan.
- Data yang digunakan.
- Alur interaksi.
- Fungsi yang dilakukan.

Jangan hanya mengandalkan pencarian nama file atau class.

## 6.3 Periksa Kelengkapan Implementasi

Jangan menganggap fitur sudah selesai hanya karena halaman atau tombolnya tersedia.

Periksa apakah:

1. UI tersedia.
2. Interaksi pengguna tersedia.
3. State dikelola dengan benar.
4. Logika bisnis tersedia.
5. Data dapat diproses.
6. Data dapat disimpan jika dibutuhkan.
7. Data dapat ditampilkan kembali.
8. Navigasi terhubung.
9. Kondisi error ditangani.
10. Alur penggunaan memenuhi kebutuhan.

Jika implementasi bergantung pada backend atau layanan eksternal yang tidak dapat diperiksa, tandai sebagai belum terverifikasi.

## 6.4 Klasifikasi Status Implementasi

Pilih satu status:

**A. Sudah Diimplementasikan**

Fungsi yang diperlukan sudah tersedia dan memenuhi kebutuhan.

**B. Sudah Diimplementasikan Sebagian**

Beberapa fungsi sudah tersedia, tetapi masih ada kekurangan.

**C. Belum Ditemukan Implementasinya**

Implementasi yang memenuhi kebutuhan belum ditemukan setelah pemeriksaan seluruh bagian yang relevan.

**D. Belum Dapat Dipastikan**

Bukti belum cukup untuk memastikan fungsi berjalan atau tidak.

Untuk setiap status, sertakan alasan dan path file sebagai bukti.

## 6.5 Bandingkan dengan Aplikasi Referensi

Bandingkan:

- Tujuan.
- Fungsi.
- Tampilan.
- Interaksi.
- Alur penggunaan.
- Data.
- Hasil yang diharapkan.

Identifikasi:

1. Fungsi yang sudah sesuai.
2. Fungsi yang sudah tersedia tetapi berbeda.
3. Fungsi yang belum tersedia.
4. Fungsi yang tidak diperlukan.
5. Fungsi yang perlu disempurnakan.

Jangan meniru seluruh fitur aplikasi referensi tanpa mempertimbangkan kebutuhan proyek.

## 6.6 Aturan Pemeriksaan

- Gunakan bukti kode aktual.
- Cantumkan path.
- Jangan mengarang nama fungsi.
- Bedakan UI dengan logika bisnis.
- Jangan menganggap data dummy sebagai implementasi final.
- Jangan menganggap model atau database sebagai bukti fitur selesai.
- Jangan mengasumsikan API tersedia tanpa bukti.
- Jangan mengusulkan fitur yang sama apabila sudah tersedia.
- Jangan mengubah kode saat melakukan pemeriksaan.

Seluruh pemeriksaan proyek harus dilakukan secara read-only.

Jangan menjalankan build, migrasi, instalasi dependensi, atau pengujian yang dapat mengubah kondisi proyek.

---

# 7. TAHAP KETIGA: JELASKAN TUJUAN FITUR TERLEBIH DAHULU

Walaupun pemeriksaan referensi dan kode dilakukan terlebih dahulu, **bagian pertama jawaban diskusi harus selalu menjelaskan tujuan fitur.**

Ini merupakan prioritas utama.

Jelaskan:

1. Fitur ini sebenarnya dibuat untuk apa?
2. Masalah apa yang ingin diselesaikan?
3. Mengapa fitur tersebut diperlukan?
4. Siapa yang akan menggunakan fitur?
5. Apa manfaatnya?
6. Apa hasil yang diharapkan?

Jangan langsung memberikan daftar file atau contoh kode.

## 7.1 Tentukan Jenis Pengembangan

Berdasarkan hasil pemeriksaan, tentukan:

**Fitur Baru:** Fungsi yang dibutuhkan belum tersedia.

**Pembaruan Fitur:** Fungsi sudah tersedia, tetapi perlu disempurnakan atau dikembangkan.

**Tidak Memerlukan Pengembangan:** Implementasi sekarang sudah memenuhi kebutuhan.

**Belum Dapat Ditentukan:** Bukti belum mencukupi.

Berikan alasan yang jelas.

## 7.2 Jelaskan Manfaat

Pisahkan:

- Manfaat utama.
- Manfaat tambahan.
- Dampak terhadap pengguna.
- Dampak terhadap aplikasi.

Jangan menyampaikan manfaat yang masih berupa asumsi sebagai fakta.

---

# 8. TAHAP KEEMPAT: GAMBARAN CARA KERJA FITUR

Jelaskan cara kerja fitur berdasarkan aplikasi referensi dan kebutuhan proyek.

Gunakan urutan:

1. Kondisi awal.
2. Tindakan pengguna.
3. Proses aplikasi.
4. Data yang dibutuhkan.
5. Respons aplikasi.
6. Hasil akhir.
7. Kondisi khusus atau kegagalan.

Jika merupakan pembaruan, bandingkan:

- Cara kerja saat ini.
- Cara kerja pada aplikasi referensi.
- Perbedaan keduanya.
- Perubahan yang diusulkan.
- Hasil yang diharapkan.

Jangan menambahkan alur yang tidak relevan.

---

# 9. TAHAP KELIMA: IDENTIFIKASI FILE YANG TERDAMPAK

Setelah menjelaskan tujuan dan cara kerja, identifikasi file yang berkaitan dengan implementasi.

Gunakan struktur aktual dan ikuti ketentuan `docs/struktur rules.md` atau file struktur aktual yang telah ditetapkan.

## 9.1 File yang Sudah Menangani Fitur

Untuk setiap file, jelaskan:

- Path lengkap.
- Fungsi file.
- Bagian yang berkaitan dengan fitur.
- Bukti implementasi.

## 9.2 File yang Perlu Diperbarui

Untuk setiap file, jelaskan:

- Path lengkap.
- Fungsi saat ini.
- Bagian yang perlu disesuaikan.
- Alasan perubahan.
- Dampak perubahan.

## 9.3 File Baru yang Mungkin Diperlukan

Untuk setiap file, jelaskan:

- Path lengkap.
- Tanggung jawab.
- Alasan file diperlukan.
- Hubungannya dengan file lain.

## 9.4 Tingkat Kepastian

Kelompokkan:

- **Terbukti Terkait:** File sudah diperiksa dan memiliki hubungan langsung.
- **Diperkirakan Terdampak:** Berdasarkan rancangan, file kemungkinan perlu diubah.
- **Belum Dapat Dipastikan:** Masih membutuhkan keputusan teknis.

Jangan menyatakan file pasti terdampak tanpa bukti.

## 9.5 Ketentuan

- Jangan mengarang path.
- Jangan memasukkan file yang tidak relevan.
- Jangan membuat abstraksi tanpa alasan.
- Hindari perubahan di luar ruang lingkup.
- Pertimbangkan implementasi yang sudah tersedia.
- Semua file implementasi tetap baca-saja.

---

# 10. TAHAP KEENAM: BERIKAN BEBERAPA POTONGAN CONTOH KODE

Pengguna meminta beberapa potongan contoh kode, bukan hanya satu contoh kode.

Tujuannya adalah memperlihatkan bagaimana beberapa bagian fitur saling berhubungan apabila nantinya diimplementasikan.

**Berikan umumnya 2–4 potongan kode singkat, menyesuaikan kompleksitas fitur.**

Jangan memaksakan jumlah potongan yang tidak relevan.

## 10.1 Ketentuan Contoh Kode

1. Sesuaikan dengan bahasa pemrograman dan framework proyek.
2. Jika proyek menggunakan Flutter, gunakan Dart dan pola arsitektur yang sudah diterapkan.
3. Periksa implementasi dan dependensi yang tersedia.
4. Jangan mengarang API atau method.
5. Jangan menggunakan dependensi baru tanpa alasan.
6. Jangan membuat implementasi lengkap.
7. Fokus pada fungsi inti.
8. Sertakan path untuk setiap potongan kode.
9. Jelaskan hubungan antarpotongan kode.
10. Jangan menyimpan atau menerapkan contoh kode ke proyek.

## 10.2 Pilih Potongan Berdasarkan Kebutuhan Fitur

Contoh bagian yang dapat ditampilkan:

**Potongan 1 — UI dan Interaksi**

Menggambarkan komponen tampilan dan tindakan pengguna.

**Potongan 2 — Pengelolaan State dan Logika**

Menggambarkan bagaimana tindakan pengguna diproses.

**Potongan 3 — Pengolahan Data**

Menggambarkan proses model, repository, atau service jika diperlukan.

**Potongan 4 — Integrasi dan Navigasi**

Menggambarkan bagaimana fitur berhubungan dengan halaman atau bagian aplikasi lain apabila relevan.

Tidak semua fitur membutuhkan empat bagian tersebut.

Pilih hanya bagian yang benar-benar mewakili alur fitur.

## 10.3 Hubungan Antarcontoh

Setiap potongan kode harus konsisten.

Contohnya:

- Parameter yang dikirim UI harus sesuai dengan logika penerima.
- Nama method harus konsisten antarcontoh.
- Struktur data harus sesuai dengan contoh berikutnya.
- Jangan menggunakan class atau API yang tidak tersedia seolah-olah sudah ada.
- Jika nama class atau file merupakan rancangan baru, tandai sebagai usulan.

## 10.4 Format Wajib

### Contoh 1 — [Nama Bagian]

**Path:** `lib/path/file.dart`

```dart
// Potongan kode singkat.
// Hanya ilustrasi implementasi.
```

**Tujuan:**
Jelaskan fungsi potongan tersebut.

**Hubungan:**
Jelaskan hubungannya dengan bagian fitur lainnya.

Ulangi format ini untuk potongan berikutnya.

## 10.5 Jika Fitur Sudah Diimplementasikan

Jika fitur sudah tersedia sepenuhnya:

- Jangan memberikan contoh kode yang seolah-olah fitur perlu dibuat ulang.
- Jika ada pembaruan yang disarankan, berikan beberapa contoh untuk bagian yang perlu disempurnakan.
- Jika tidak ada perubahan yang diperlukan, jelaskan bahwa contoh implementasi baru tidak diperlukan.
- Jika berguna, tunjukkan potongan implementasi aktual sebagai bukti dan pisahkan dari kode usulan.

**Penting: contoh kode hanya untuk diskusi dan perencanaan, bukan instruksi untuk mengubah proyek.**

---

# 11. TAHAP KETUJUH: EVALUASI DAN REKOMENDASI

Berikan evaluasi secara objektif.

## 11.1 Kondisi Aktual

Jelaskan fungsi yang sudah tersedia berdasarkan pemeriksaan kode.

## 11.2 Perbedaan dengan Referensi

Jelaskan perbedaan aplikasi referensi dengan implementasi proyek.

## 11.3 Kekurangan

Identifikasi kebutuhan yang belum terpenuhi.

## 11.4 Risiko

Bahas risiko yang memang relevan terhadap:

- Fitur lain.
- Struktur data.
- Database.
- Navigasi.
- Pengelolaan state.
- Performa.
- Pengalaman pengguna.

## 11.5 Rekomendasi

Berikan rekomendasi apakah:

- Fitur perlu ditambahkan.
- Fitur perlu diperbarui.
- Fitur sebaiknya disederhanakan.
- Implementasi sudah mencukupi.
- Ada pendekatan yang lebih efisien.

Setiap rekomendasi harus memiliki alasan.

Pisahkan rekomendasi dari keputusan pengguna.

---

# 12. TAHAP KEDELAPAN: BUAT ATAU PERBARUI PRD

Setelah analisis dan diskusi selesai, dokumentasikan hasilnya ke folder `prd/` di root proyek.

PRD adalah dokumen kebutuhan produk dan rancangan fitur, bukan implementasi kode.

## 12.1 Periksa Folder PRD

1. Periksa folder `prd/` pada root.
2. Baca dokumen yang berhubungan dengan fitur pilihan.
3. Cari apakah sudah ada PRD untuk fitur yang sama.
4. Periksa apakah PRD lama masih relevan.
5. Tentukan apakah perlu memperbarui PRD lama atau membuat PRD baru.

## 12.2 Aturan Pemilihan PRD

**Jika PRD terkait sudah ada:**

Perbarui dokumen tersebut.

Jangan membuat dokumen duplikat.

**Jika PRD belum ada:**

Buat satu dokumen baru di folder `prd/`.

Gunakan nama file yang jelas, singkat, dan mengikuti aturan `docs/struktur rules.md`.

Contoh:

`prd/notifikasi_terjadwal.md`

**Jika terdapat beberapa PRD yang mirip:**

Baca dan bandingkan isinya.

Jika tidak dapat dipastikan dokumen mana yang harus diperbarui, tanyakan kepada pengguna.

Jangan memilih berdasarkan tebakan.

## 12.3 Hanya Satu PRD Terkait

Aturan mutlak:

- Maksimal satu file PRD yang boleh dibuat atau diperbarui.
- PRD harus berkaitan langsung dengan fitur pilihan.
- Jangan mengubah PRD fitur lain.
- Jangan membuat dokumen laporan terpisah.
- Jangan membuat file pendukung.
- Jangan membuat salinan PRD.
- Jangan mengubah aturan atau referensi.
- Jangan memperbarui seluruh folder PRD secara massal.

Jika lokasi PRD menurut aturan struktur berbeda dengan folder `prd/` yang diminta pengguna, laporkan konflik sebelum menulis.

## 12.4 Status PRD

Setiap usulan harus dibedakan dengan jelas.

Gunakan status:

- **Draft:** Dokumen awal hasil analisis.
- **Dalam Diskusi:** Masih terdapat kebutuhan atau keputusan yang belum disetujui.
- **Disepakati:** Pengguna sudah menyetujui kebutuhan yang ditetapkan.

Jangan menandai PRD sebagai disepakati tanpa persetujuan pengguna.

Jangan mengubah rekomendasi menjadi persyaratan final.

## 12.5 Struktur Isi PRD

Gunakan kerangka berikut dan sesuaikan dengan aturan struktur proyek.

# PRD: [Nama Fitur]

## 1. Informasi Dokumen

- Nama fitur.
- Jenis pengembangan.
- Status implementasi.
- Status PRD.
- Tanggal pembuatan atau pembaruan.
- Sumber referensi.

## 2. Tujuan Fitur

Jelaskan tujuan utama fitur dan alasan fitur dibutuhkan.

## 3. Latar Belakang dan Permasalahan

Jelaskan masalah yang ingin diselesaikan.

## 4. Target Pengguna

Jelaskan pengguna yang akan menggunakan fitur.

## 5. Manfaat Fitur

Jelaskan manfaat utama dan tambahan.

## 6. Referensi Aplikasi

Cantumkan:

- Nama aplikasi.
- Link aplikasi.
- Screenshot atau demonstrasi.
- Gambaran tampilan.
- Gambaran cara kerja.
- Informasi yang belum terverifikasi.

## 7. Sumber Referensi Internal

Cantumkan path dan nomor baris data pilihan pengguna.

Format:

- Nama file: `refrensi_apk.md`
- Path: `refrensi_apk.md`
- Baris: `L12-L20`
- Referensi lengkap: `refrensi_apk.md:L12-L20`
- Nama data: [Nama fitur].
- Link aplikasi: [URL aktual].

Nomor baris di atas hanya contoh format.

Gunakan nama file dan path yang benar-benar ditemukan.

## 8. Kondisi Implementasi Saat Ini

Jelaskan:

- Status implementasi.
- Fungsi yang sudah tersedia.
- Fungsi yang belum tersedia.
- Bagian yang sudah sesuai.
- Bagian yang belum sesuai.
- Bukti berupa path file.

## 9. Ruang Lingkup

Jelaskan fitur yang termasuk dan tidak termasuk dalam pengembangan.

Jangan memperluas ruang lingkup tanpa dasar.

## 10. Alur Penggunaan

Jelaskan alur dari tindakan pengguna sampai hasil akhir.

## 11. Persyaratan Fungsional

Daftarkan kebutuhan fungsional secara spesifik dan dapat diperiksa.

## 12. Persyaratan Nonfungsional

Cantumkan kebutuhan yang relevan, misalnya performa, keamanan, keandalan, dan kemudahan penggunaan.

Jangan membuat persyaratan yang belum memiliki dasar.

## 13. File yang Terdampak

Pisahkan:

- File yang sudah menangani fitur.
- File yang perlu diubah.
- File baru yang mungkin diperlukan.

Sertakan path dan alasan.

## 14. Gambaran Teknis

Jelaskan pendekatan implementasi dan beberapa potongan kode singkat jika relevan.

## 15. Kriteria Penerimaan

Buat kriteria yang:

- Spesifik.
- Dapat diperiksa.
- Sesuai ruang lingkup.
- Tidak mengandung asumsi yang belum disetujui.

## 16. Risiko dan Ketergantungan

Jelaskan risiko dan hubungan dengan fitur lainnya.

## 17. Keputusan dan Hal yang Belum Ditentukan

Pisahkan:

- Keputusan yang sudah disetujui.
- Rekomendasi yang belum disetujui.
- Asumsi yang belum diverifikasi.
- Pertanyaan yang memerlukan keputusan pengguna.

## 18. Riwayat Perubahan PRD

Catat tanggal, bagian yang diubah, dan alasan perubahan.

Pertahankan riwayat lama apabila dokumen sudah memilikinya.

---

# 13. WAJIB SERTAKAN PATH DAN NOMOR BARIS FILE REFERENSI DALAM PRD

Setiap PRD harus memuat sumber internal berupa path dan nomor baris data yang dipilih pengguna.

Ini merupakan persyaratan wajib.

## 13.1 Cara Memperoleh Nomor Baris

1. Baca file referensi.
2. Temukan data yang dipilih.
3. Identifikasi baris awal.
4. Identifikasi baris akhir.
5. Pastikan rentang mencakup judul, deskripsi, dan link aplikasi yang relevan.
6. Periksa ulang sebelum menulis PRD.

Gunakan fasilitas pembacaan yang menampilkan nomor baris atau perintah baca-saja seperti:

```bash
nl -ba refrensi_apk.md
```

Atau:

```bash
grep -n "nama fitur" refrensi_apk.md
```

Jika nama file atau lokasinya berbeda, sesuaikan dengan kondisi aktual proyek.

## 13.2 Format Penulisan

Contoh:

`refrensi_apk.md:L12-L20`

Jika file berada di subfolder:

`docs/refrensi_apk.md:L12-L20`

Pastikan:

- Path sesuai root.
- Nama file benar.
- Nomor baris benar.
- Rentang mencakup data yang dipilih.
- Link aplikasi sesuai dengan sumber.

Jika terdapat beberapa rentang yang diperlukan, cantumkan semuanya.

Jangan hanya menuliskan nama file tanpa nomor baris.

## 13.3 Jika Nomor Baris Tidak Dapat Dipastikan

Jangan mengarang nomor baris.

Baca kembali file menggunakan metode lain yang bersifat read-only.

Jika tetap tidak dapat dipastikan, laporkan kendalanya dan jangan mengisi nomor perkiraan dalam PRD.

---

# 14. ATURAN MEMPERBARUI PRD LAMA

Jika PRD terkait sudah tersedia:

1. Baca seluruh isi dokumen.
2. Pertahankan informasi lama yang masih benar.
3. Pertahankan keputusan yang sudah disepakati.
4. Perbarui bagian yang memang berubah.
5. Tambahkan hasil pemeriksaan implementasi terbaru.
6. Perbarui daftar file terdampak.
7. Perbarui persyaratan yang memang berubah.
8. Perbarui kriteria penerimaan jika diperlukan.
9. Perbarui sumber referensi dan nomor baris.
10. Pertahankan riwayat perubahan.

Jangan menulis ulang seluruh PRD tanpa alasan.

Jika terdapat perbedaan antara PRD lama dan hasil diskusi terbaru, pisahkan:

- Ketentuan lama yang masih berlaku.
- Usulan perubahan.
- Keputusan baru yang telah disetujui.

Jika pengguna belum menyetujui usulan, tandai sebagai usulan.

Jangan menghapus keputusan lama berdasarkan asumsi sendiri.

---

# 15. FORMAT JAWABAN AKHIR

Setelah seluruh pemeriksaan dan pembaruan PRD selesai, sampaikan hasil menggunakan urutan berikut.

# Diskusi Fitur: [Nama Fitur]

## 1. Tujuan Fitur

Jelaskan:

- Tujuan utama.
- Masalah yang diselesaikan.
- Manfaat.
- Alasan fitur diperlukan.

## 2. Referensi Aplikasi

- Nama aplikasi.
- Link yang diperiksa.
- Screenshot yang ditemukan.
- Gambaran tampilan.
- Gambaran cara kerja.
- Informasi yang belum terverifikasi.

## 3. Status Implementasi Aktual

- Status implementasi.
- Fungsi yang sudah tersedia.
- Fungsi yang belum tersedia.
- Bukti pemeriksaan beserta path.

## 4. Jenis Pengembangan

- Fitur baru.
- Pembaruan fitur.
- Tidak memerlukan pengembangan.
- Belum dapat ditentukan.

Jelaskan alasan.

## 5. Gambaran Cara Kerja

Jelaskan alur penggunaan fitur.

## 6. Perbedaan dengan Aplikasi Referensi

Jelaskan bagian yang sesuai dan berbeda.

## 7. File yang Terdampak

Cantumkan:

- File yang sudah menangani fitur.
- File yang perlu diubah.
- File baru yang mungkin diperlukan.

Sertakan path dan alasan.

## 8. Beberapa Contoh Kode

Berikan beberapa potongan kode singkat jika memang diperlukan.

Setiap potongan wajib memiliki:

- Judul.
- Path.
- Kode.
- Fungsi.
- Hubungannya dengan bagian lain.

## 9. Evaluasi dan Rekomendasi

Jelaskan kelayakan, kekurangan, risiko, dan alternatif.

## 10. Hasil PRD

- Status: Dibuat / Diperbarui / Tidak Berubah / Terhambat.
- Path PRD.
- Nama fitur.
- Sumber referensi.
- Nomor baris referensi.
- Ringkasan perubahan.
- Status persetujuan PRD.

## 11. Hal yang Memerlukan Keputusan Pengguna

Cantumkan pertanyaan yang benar-benar memerlukan keputusan pengguna.

---

# 16. PEMERIKSAAN AKHIR

Sebelum menyatakan pekerjaan selesai, pastikan seluruh ketentuan berikut terpenuhi.

## A. Pemeriksaan Aturan

- [ ] Root proyek sudah dipastikan.
- [ ] `docs/struktur rules.md` sudah diperiksa.
- [ ] Jika tidak tersedia, alternatif `docs/struktur_rules.md` sudah diperiksa.
- [ ] Isi aturan yang ditemukan sudah dibaca lengkap.
- [ ] `AGENTS.md` sudah diperiksa jika tersedia.
- [ ] Aturan proyek yang relevan sudah dibaca.
- [ ] Tidak ada konflik aturan yang diabaikan.

## B. Pemeriksaan Referensi

- [ ] Satu data pilihan pengguna sudah ditemukan.
- [ ] Link aplikasi sudah dibuka.
- [ ] Screenshot diperiksa jika tersedia.
- [ ] Alur dan tujuan fitur sudah dipelajari.
- [ ] Fakta dan asumsi sudah dipisahkan.
- [ ] Path sumber sudah dicatat.
- [ ] Nomor baris sumber sudah dipastikan.

## C. Pemeriksaan Implementasi

- [ ] Kode aktual sudah diperiksa.
- [ ] UI dibedakan dari logika bisnis.
- [ ] Fungsi yang sudah tersedia telah diidentifikasi.
- [ ] Fungsi yang belum tersedia telah diidentifikasi.
- [ ] Status implementasi ditentukan berdasarkan bukti.
- [ ] Tidak mengusulkan fitur duplikat.

## D. Pemeriksaan Diskusi

- [ ] Tujuan fitur dijelaskan terlebih dahulu.
- [ ] Manfaat dijelaskan.
- [ ] Jenis pengembangan ditentukan.
- [ ] Cara kerja fitur dijelaskan.
- [ ] File terdampak diidentifikasi.
- [ ] Path file benar.
- [ ] Beberapa contoh kode diberikan jika relevan.
- [ ] Rekomendasi dipisahkan dari keputusan pengguna.

## E. Pemeriksaan PRD

- [ ] Folder `prd/` pada root sudah diperiksa.
- [ ] PRD terkait sudah dicari.
- [ ] PRD lama dibaca sebelum diperbarui.
- [ ] Tidak ada dokumen duplikat.
- [ ] Hanya satu PRD terkait yang dibuat atau diperbarui.
- [ ] Sumber referensi dicantumkan.
- [ ] Path sumber benar.
- [ ] Nomor baris benar.
- [ ] Isi PRD sesuai hasil diskusi.
- [ ] Keputusan dan usulan dibedakan.
- [ ] Riwayat perubahan dipertahankan.

## F. Pemeriksaan Batasan Pengeditan

- [ ] Tidak ada kode program yang berubah.
- [ ] Tidak ada konfigurasi yang berubah.
- [ ] Tidak ada dependensi yang berubah.
- [ ] File `docs/struktur rules.md` atau alternatifnya tidak diubah.
- [ ] File referensi tidak diubah.
- [ ] Aturan proyek tidak diubah.
- [ ] PRD lain tidak diubah.
- [ ] Tidak ada file tambahan selain satu PRD terkait.
- [ ] Tidak ada implementasi fitur.

Jika pemeriksaan menunjukkan perubahan di luar PRD terkait, laporkan kondisi tersebut.

Jangan melakukan pemulihan otomatis yang dapat menghapus perubahan pengguna.

---

# 17. BATAS AKHIR PEKERJAAN

Pekerjaan selesai setelah:

1. Aturan struktur proyek dibaca.
2. Data referensi pilihan pengguna dipelajari.
3. Link aplikasi referensi diperiksa.
4. Implementasi proyek diperiksa.
5. Tujuan dan manfaat fitur dijelaskan.
6. Status dan jenis pengembangan ditentukan.
7. Gambaran cara kerja dijelaskan.
8. File terdampak diidentifikasi.
9. Beberapa potongan contoh kode diberikan jika relevan.
10. Evaluasi dan rekomendasi disampaikan.
11. Satu PRD terkait dibuat atau diperbarui.
12. PRD mencantumkan path dan nomor baris sumber referensi.
13. Tidak ada file selain PRD terkait yang diubah.

Setelah pekerjaan selesai, sampaikan laporan hasil kepada pengguna dan tunggu keputusan berikutnya.

**JANGAN MELAKUKAN IMPLEMENTASI KODE.**

**JANGAN MENGEDIT FILE SELAIN SATU PRD YANG BERKAITAN LANGSUNG DENGAN FITUR PILIHAN PENGGUNA.**

PRD merupakan hasil akhir command ini dan menjadi dasar untuk tahap pengembangan selanjutnya.
