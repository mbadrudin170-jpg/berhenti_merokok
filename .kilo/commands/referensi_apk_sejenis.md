---
description: Riset aplikasi Android sejenis, temukan fitur baru, evaluasi optimasi fitur, analisis UI/UX dan layout, lalu perbarui refrensi_apk.md di root proyek
agent: code
---

# Riset Referensi Aplikasi Mobile Sejenis

## 1. Tujuan dan batas pekerjaan

Lakukan penelitian terhadap aplikasi mobile yang memiliki kategori, tujuan, atau fitur yang relevan dengan proyek ini.

Gunakan tools pencarian, browser, inspeksi gambar, screenshot, MCP, dan kemampuan lainnya yang benar-benar tersedia pada sesi Kilo Code.

Penelitian memiliki tiga ruang lingkup:

1. Menemukan fitur baru dari aplikasi sejenis yang layak dipertimbangkan untuk proyek.
2. Menemukan peluang optimasi terhadap fitur yang sudah tersedia pada proyek.
3. Menganalisis pola UI, UX, dan layout aplikasi kompetitor untuk menghasilkan saran yang dapat dipertimbangkan pemilik proyek.

Seluruh hasil penelitian harus ditulis ke:

`./refrensi_apk.md`

### Batas pekerjaan

Command ini hanya boleh:

- Membaca aturan dan kondisi proyek.
- Melakukan riset aplikasi mobile.
- Membandingkan fitur aplikasi kompetitor.
- Menganalisis UI, UX, dan layout berdasarkan bukti.
- Menyusun rekomendasi.
- Membuat atau memperbarui `./refrensi_apk.md`.

Dilarang:

- Mengimplementasikan fitur baru.
- Mengubah kode aplikasi.
- Mengubah desain atau UI aplikasi.
- Mengubah dependency.
- Mengubah konfigurasi proyek.
- Mengubah aturan atau command lain.
- Membuat roadmap atau task implementasi.
- Membuat commit.

Hasil penelitian merupakan bahan pertimbangan. Pemilik proyek yang menentukan rekomendasi mana yang akan digunakan.

---

## 2. Baca aturan dan pahami proyek

Jangan memulai penelitian eksternal sebelum memahami proyek.

### 2.1. Baca aturan

1. Baca `AGENTS.md` di root proyek terlebih dahulu.
2. Ikuti instruksi yang terdapat di dalamnya.
3. Periksa aturan tambahan pada direktori terkait, termasuk `.agents/`, `.kilo/rules/`, `.kilocode/rules/`, dan lokasi lain yang secara eksplisit disebutkan oleh aturan proyek.
4. Baca aturan dokumentasi dan penelitian apabila tersedia.
5. Jangan menganggap seluruh file Markdown sebagai aturan.
6. Apabila ditemukan konflik aturan, catat path dan isi aturan yang bertentangan. Ikuti prioritas yang dinyatakan secara eksplisit. Jika tidak ada prioritas yang jelas, jangan membuat keputusan sendiri.

### 2.2. Identifikasi kondisi proyek

Periksa kode dan dokumentasi proyek untuk memahami:

- Nama dan tujuan aplikasi.
- Kategori aplikasi.
- Platform yang didukung.
- Target pengguna.
- Masalah utama yang diselesaikan aplikasi.
- Fitur yang sudah tersedia.
- Fitur yang masih dalam pengembangan.
- Fitur yang belum tersedia.
- Struktur navigasi.
- Halaman dan komponen utama.
- Alur penggunaan aplikasi.
- Teknologi dan keterbatasan teknis yang relevan.

Gunakan implementasi aktual sebagai sumber utama.

Periksa file seperti:

- `README.md`
- `pubspec.yaml`
- Konfigurasi Android dan iOS.
- Direktori `lib/`.
- Halaman dan widget.
- Model dan notifier.
- Navigasi.
- Dokumentasi fitur.
- Dokumen perencanaan yang benar-benar tersedia.

Untuk setiap fitur yang relevan, catat:

- Nama fitur.
- Tujuan fitur.
- Status implementasi.
- Path implementasi.
- Halaman atau komponen terkait.
- Keterangan kondisi saat ini.

Jangan menganggap fitur belum tersedia hanya karena tidak ditemukan dari nama file. Lakukan pencarian dan pemeriksaan kode yang relevan terlebih dahulu.

### 2.3. Periksa dokumen penelitian lama

Periksa keberadaan `./refrensi_apk.md`.

Jika sudah tersedia:

1. Baca seluruh isi dokumen.
2. Pelajari referensi dan rekomendasi yang telah tercatat.
3. Identifikasi informasi yang masih relevan.
4. Identifikasi informasi yang sudah tidak sesuai dengan kondisi proyek.
5. Hindari membuat rekomendasi duplikat.
6. Pertahankan informasi lama yang masih relevan.
7. Perbarui informasi lama apabila ditemukan bukti yang lebih akurat.

Jangan langsung menimpa seluruh isi dokumen.

---

## 3. Temukan dan gunakan tools penelitian

### 3.1. Periksa tools yang tersedia

Periksa terlebih dahulu tools yang tersedia pada sesi Kilo Code.

Prioritaskan:

1. Pencarian web.
2. Browser atau browser automation.
3. Pengambilan isi halaman web.
4. Pencarian gambar aplikasi.
5. Inspeksi screenshot.
6. MCP yang menyediakan data aplikasi atau informasi tambahan.

Jangan menganggap tool tertentu pasti tersedia.

Jangan memasang MCP, meminta API key, atau mengubah konfigurasi Kilo Code untuk menyelesaikan penelitian.

### 3.2. Strategi pencarian aplikasi

Utamakan aplikasi Android yang tersedia di Google Play Store.

Cari aplikasi berdasarkan:

- Kategori aplikasi proyek.
- Tujuan aplikasi.
- Fitur utama proyek.
- Nama fitur yang ingin dibandingkan.
- Permasalahan pengguna yang ingin diselesaikan.

Gunakan App Store sebagai referensi tambahan apabila memiliki fitur atau alur yang relevan.

Jangan menyebut aplikasi iOS sebagai APK Android.

Cari aplikasi kompetitor langsung dan aplikasi dari kategori lain yang memiliki implementasi fitur yang dapat dibandingkan secara masuk akal.

Jangan memasukkan aplikasi hanya karena populer. Utamakan kesesuaian fitur dan kebutuhan pengguna.

### 3.3. Kualitas sumber

Gunakan urutan sumber berikut:

1. Google Play Store dan App Store.
2. Situs resmi pengembang.
3. Dokumentasi dan panduan penggunaan resmi.
4. Screenshot resmi aplikasi.
5. Video demonstrasi aplikasi.
6. Ulasan pengguna dan sumber pihak ketiga tepercaya.

Pastikan sumber benar-benar berkaitan dengan aplikasi dan fitur yang sedang diteliti.

Hindari menggunakan deskripsi promosi sebagai satu-satunya bukti keberadaan suatu fitur apabila informasi tambahan dapat diperiksa.

Jangan mengunduh atau memasang APK dari situs mirror yang tidak tepercaya. Instalasi APK tidak diperlukan untuk menyelesaikan penelitian.

### 3.4. Keterbatasan tools

Jika tools tertentu tidak tersedia:

- Cari alternatif yang memang tersedia.
- Jangan mengaku telah memeriksa screenshot jika tidak melakukannya.
- Jangan mengaku telah mencoba aplikasi jika tidak benar-benar melakukannya.
- Jangan membuat URL, screenshot, fitur, atau hasil penelitian fiktif.
- Cantumkan keterbatasan yang ditemukan.

Jika penelitian eksternal tidak dapat diverifikasi, jangan mengisi dokumen menggunakan dugaan.

---

## 4. Ruang lingkup A: Penelitian fitur baru

Tujuan penelitian ini adalah menemukan fitur tambahan dari aplikasi sejenis yang belum tersedia pada proyek.

### 4.1. Batasan fitur

Hanya sarankan fitur yang dapat digunakan melalui aplikasi pada perangkat mobile.

Fitur yang dapat dipertimbangkan:

- Fitur yang seluruh alur utamanya dapat dijalankan melalui Android atau iOS.
- Fitur yang menggunakan kamera, lokasi, notifikasi, sensor, penyimpanan lokal, biometrik, atau kemampuan perangkat mobile.
- Fitur yang menggunakan backend, API, atau layanan cloud selama interaksi utamanya tetap dapat dilakukan melalui aplikasi mobile.
- Fitur yang mendukung penggunaan offline apabila relevan.

Jangan sarankan:

- Fitur yang hanya berjalan pada desktop.
- Fitur yang mengharuskan pengguna menyelesaikan alur utama melalui dashboard web.
- Fitur administratif yang tidak relevan dengan pengguna aplikasi mobile.
- Kemampuan backend yang tidak memiliki manfaat atau alur penggunaan jelas pada aplikasi mobile.

### 4.2. Penelitian setiap fitur

Untuk setiap fitur yang ditemukan:

1. Pastikan fitur benar-benar tersedia pada aplikasi referensi.
2. Pastikan fitur belum tersedia pada proyek.
3. Jika fungsi serupa sudah tersedia, masukkan ke bagian optimasi fitur yang sudah ada, bukan fitur baru.
4. Jelaskan nama dan tujuan fitur.
5. Jelaskan masalah pengguna yang diselesaikan.
6. Jelaskan manfaatnya.
7. Jelaskan alur penggunaan dari tindakan pengguna sampai hasil yang diterima.
8. Jelaskan aplikasi referensinya.
9. Sertakan tautan Google Play atau App Store.
10. Sertakan sumber yang membuktikan keberadaan fitur.
11. Jelaskan ketergantungan penting seperti internet, akun, API, izin perangkat, backend, atau layanan pihak ketiga.
12. Jelaskan relevansinya dengan proyek.
13. Berikan alasan prioritas.

Jangan membuat desain kode atau rancangan implementasi teknis.

Tujuannya adalah memberikan alternatif fitur kepada pemilik proyek.

---

## 5. Ruang lingkup B: Optimasi fitur yang sudah ada

Tujuan penelitian ini adalah menemukan cara meningkatkan fitur yang sudah tersedia pada proyek berdasarkan implementasi aplikasi kompetitor.

Untuk setiap fitur:

1. Catat kondisi implementasi proyek saat ini.
2. Sertakan path file dan halaman yang relevan apabila ditemukan.
3. Cari aplikasi kompetitor yang memiliki fungsi atau alur serupa.
4. Periksa bagaimana kompetitor menyajikan fitur tersebut.
5. Identifikasi kelebihan implementasi referensi.
6. Bandingkan dengan implementasi proyek.
7. Identifikasi peluang peningkatan yang realistis.
8. Berikan saran optimasi yang spesifik.
9. Jelaskan tujuan dan manfaat optimasi.
10. Sertakan tautan referensi.
11. Berikan prioritas dan alasannya.

Perhatikan peluang peningkatan seperti:

- Penyederhanaan alur.
- Pengurangan langkah pengguna.
- Kemudahan menemukan fitur.
- Kejelasan informasi.
- Pengelompokan data.
- Kemudahan input.
- Feedback tindakan.
- Pengelolaan data.
- Efisiensi penggunaan.
- Konsistensi perilaku.
- Dukungan kondisi offline.

Jangan menyebut sesuatu sebagai kekurangan proyek tanpa bukti dari implementasi aktual.

Jangan merekomendasikan penggantian keseluruhan fitur apabila peningkatan kecil sudah mencukupi.

---

## 6. Ruang lingkup C: Analisis UI, UX, dan layout

Cari aplikasi kompetitor yang memiliki fitur sama atau alur pengguna yang sebanding dengan proyek.

Tujuannya bukan menyalin desain aplikasi lain, melainkan menemukan pola yang dapat meningkatkan pengalaman pengguna.

### 6.1. Analisis UI

Periksa:

- Susunan elemen pada halaman.
- Struktur kartu dan daftar.
- Penggunaan warna.
- Hierarki visual.
- Pengelompokan informasi.
- Judul dan label.
- Ikon dan tombol.
- Kepadatan konten.
- Konsistensi komponen.

### 6.2. Analisis UX

Periksa:

- Kemudahan menemukan fitur.
- Urutan langkah penggunaan.
- Kejelasan fungsi tombol.
- Kemudahan menyelesaikan aktivitas.
- Pencegahan kesalahan.
- Konsistensi interaksi.
- Feedback tindakan.
- Penanganan loading.
- Penanganan error.
- Kondisi kosong.
- Konfirmasi tindakan penting.

### 6.3. Analisis layout

Periksa:

- Navigasi utama.
- Struktur tab dan menu.
- Hierarki halaman.
- Penempatan fitur utama.
- Susunan section.
- Layout formulir.
- Layout daftar.
- Penggunaan dialog dan bottom sheet.
- Penggunaan scroll.
- Penempatan tombol aksi.
- Kesesuaian dengan layar perangkat mobile.

### 6.4. Bukti visual

Gunakan screenshot resmi, video demonstrasi, atau sumber visual yang dapat diperiksa.

Jangan menyimpulkan detail tampilan hanya dari deskripsi teks aplikasi.

Jika screenshot atau demonstrasi tidak tersedia:

- Jangan mengarang posisi tombol.
- Jangan mengarang warna.
- Jangan mengarang struktur halaman.
- Jangan mengarang jumlah tab.
- Jangan mengarang perilaku interaksi.

Tandai bagian tersebut sebagai belum dapat diverifikasi secara visual.

### 6.5. Hasil analisis

Untuk setiap pola yang ditemukan, jelaskan:

1. Nama aplikasi.
2. Nama fitur atau halaman.
3. Pola UI yang ditemukan.
4. Pola UX yang ditemukan.
5. Pola layout yang ditemukan.
6. Tujuan pola tersebut.
7. Manfaat bagi pengguna.
8. Kondisi tampilan proyek saat ini jika dapat diperiksa.
9. Saran yang dapat diterapkan pada proyek.
10. Alasan prioritas.
11. Link aplikasi.
12. Link screenshot atau sumber visual.

Jangan memberikan saran generik seperti "buat lebih menarik".

Hubungkan setiap saran dengan kegunaan, keterbacaan, konsistensi, efisiensi alur, atau pengurangan beban kognitif.

---

## 7. Standar bukti penelitian

Setiap rekomendasi wajib memiliki tautan referensi yang dapat dibuka.

Untuk setiap aplikasi, catat jika tersedia:

- Nama aplikasi.
- Nama pengembang.
- Platform.
- Link Google Play.
- Link App Store jika relevan.
- Link situs pengembang.
- Link dokumentasi.
- Link screenshot atau video.
- Fitur yang menjadi referensi.
- Versi aplikasi.
- Tanggal pembaruan aplikasi.
- Tanggal penelitian.

Bedakan jenis informasi:

- **Terverifikasi:** tercantum dalam sumber resmi atau dapat diperiksa langsung.
- **Teramati:** terlihat pada screenshot, video, atau halaman yang diperiksa.
- **Interpretasi:** hasil analisis berdasarkan bukti.
- **Saran:** rekomendasi untuk proyek.
- **Belum terverifikasi:** informasi yang belum dapat dipastikan.

Jangan menyamarkan interpretasi sebagai fakta.

Jangan menggunakan tautan hasil pencarian umum apabila tersedia tautan langsung ke aplikasi atau sumber spesifik.

---

## 8. Sistem prioritas

Semua rekomendasi harus disusun berdasarkan:

1. Prioritas Tinggi.
2. Prioritas Sedang.
3. Prioritas Rendah.

Terapkan secara terpisah pada:

- Fitur baru.
- Optimasi fitur yang sudah ada.
- UI, UX, dan layout.

Gunakan kriteria:

**Tinggi**

- Sangat sesuai dengan tujuan aplikasi.
- Menjawab kebutuhan pengguna utama.
- Memiliki manfaat jelas.
- Didukung bukti yang kuat.
- Dapat digunakan melalui mobile.
- Tidak memiliki hambatan kelayakan yang besar.

**Sedang**

- Relevan dan bermanfaat.
- Dampaknya lebih terbatas.
- Memerlukan pertimbangan tambahan.
- Cocok untuk sebagian pengguna atau alur.

**Rendah**

- Bersifat tambahan.
- Dampaknya belum terlalu kuat.
- Bukti masih terbatas.
- Kompleksitas lebih besar dibanding manfaatnya.

Setiap rekomendasi harus memiliki alasan penetapan prioritas.

Jangan menghilangkan rekomendasi prioritas rendah hanya karena terdapat rekomendasi prioritas tinggi.

Prioritas hanya merupakan urutan pertimbangan. Pemilik proyek yang menentukan pilihan akhir.

---

## 9. Format file hasil penelitian

Path wajib:

`./refrensi_apk.md`

Gunakan struktur berikut:

# Referensi APK Sejenis

## Informasi Riset

- Nama proyek:
- Kategori aplikasi:
- Platform:
- Tanggal penelitian:
- Ringkasan cakupan:
- Keterbatasan penelitian:

## Ringkasan Temuan

Berikan ringkasan hasil penelitian tanpa menentukan fitur atau desain yang harus diimplementasikan.

## A. Rekomendasi Fitur Baru

### Prioritas Tinggi

#### 1. Nama Fitur

- **Tujuan:**
- **Masalah pengguna:**
- **Cara kerja di mobile:**
- **Aplikasi referensi:**
- **Link aplikasi:**
- **Link bukti:**
- **Manfaat untuk proyek:**
- **Ketergantungan/keterbatasan:**
- **Alasan prioritas:**

### Prioritas Sedang

### Prioritas Rendah

## B. Optimasi Fitur yang Sudah Ada

### Prioritas Tinggi

#### 1. Nama Fitur

- **Kondisi fitur pada proyek:**
- **Status implementasi:**
- **Path implementasi proyek:**
- **Aplikasi pembanding:**
- **Implementasi referensi:**
- **Peluang optimasi:**
- **Saran optimasi:**
- **Tujuan dan manfaat:**
- **Link aplikasi:**
- **Link bukti:**
- **Alasan prioritas:**

### Prioritas Sedang

### Prioritas Rendah

## C. Rekomendasi UI, UX, dan Layout

### Prioritas Tinggi

#### 1. Nama Pola atau Halaman

- **Fitur/halaman yang dibandingkan:**
- **Aplikasi referensi:**
- **Pola UI:**
- **Pola UX:**
- **Pola layout:**
- **Tujuan pola:**
- **Kondisi pada proyek:**
- **Saran untuk proyek:**
- **Link aplikasi:**
- **Link screenshot atau sumber visual:**
- **Alasan prioritas:**

### Prioritas Sedang

### Prioritas Rendah

## D. Daftar Aplikasi Kompetitor

| Aplikasi | Pengembang | Platform | Fitur Relevan | Link Store | Sumber Tambahan |
| -------- | ---------- | -------- | ------------- | ---------- | --------------- |

## E. Catatan Validasi dan Keterbatasan

- Informasi yang belum terverifikasi.
- Screenshot atau alur yang belum dapat diperiksa.
- Tools yang tidak tersedia.
- Hal yang perlu diperiksa lebih lanjut.

### Aturan format

1. Jangan menyisakan judul kosong.
2. Jangan menambahkan placeholder.
3. Setiap rekomendasi wajib menyertakan tautan referensi.
4. Kelompokkan berdasarkan fitur dan UI/UX.
5. Jangan mengelompokkan seluruh isi hanya berdasarkan nama aplikasi.
6. Hindari penjelasan duplikat.
7. Jangan menebak path implementasi proyek.
8. Gunakan bahasa Indonesia yang baku dan jelas.
9. Pertahankan tautan Markdown yang dapat diklik.
10. Tulis hanya informasi yang didukung hasil penelitian.

---

## 10. Aturan pembaruan dokumen

1. Hanya buat atau ubah `./refrensi_apk.md`.
2. Baca seluruh isi dokumen lama sebelum memperbaruinya.
3. Gabungkan hasil baru dengan hasil lama yang masih relevan.
4. Pertahankan referensi lama yang masih valid.
5. Perbarui informasi lama apabila tersedia bukti baru.
6. Hapus duplikasi secara hati-hati.
7. Jangan menghapus keputusan atau catatan pemilik proyek yang masih relevan.
8. Jangan mengubah hasil penelitian menjadi keputusan implementasi.
9. Jangan mengubah file proyek lainnya.

---

## 11. Validasi akhir

Sebelum menyelesaikan pekerjaan:

1. Baca kembali seluruh `refrensi_apk.md`.
2. Pastikan seluruh fitur baru benar-benar dapat digunakan melalui perangkat mobile.
3. Pastikan fitur yang sudah tersedia tidak keliru dikategorikan sebagai fitur baru.
4. Pastikan rekomendasi optimasi didasarkan pada perbandingan yang nyata.
5. Pastikan analisis UI/UX didukung bukti visual yang benar-benar diperiksa.
6. Pastikan fakta, pengamatan, interpretasi, dan saran dibedakan.
7. Pastikan prioritas tersusun Tinggi, Sedang, dan Rendah.
8. Pastikan setiap temuan memiliki tujuan dan manfaat.
9. Pastikan semua tautan berasal dari sumber yang ditemukan.
10. Pastikan tidak ada rekomendasi duplikat.
11. Pastikan hanya `refrensi_apk.md` yang diubah oleh pelaksanaan command.
12. Jangan membuat commit.

---

## 12. Laporan akhir

Berikan laporan dengan format:

### Status Penelitian

Selesai, sebagian selesai, atau terhambat.

### File Hasil

`./refrensi_apk.md`

### Aplikasi Referensi

Daftar aplikasi kompetitor yang berhasil diperiksa.

### Jumlah Temuan

| Kategori         | Tinggi | Sedang | Rendah |
| ---------------- | -----: | -----: | -----: |
| Fitur baru       |        |        |        |
| Optimasi fitur   |        |        |        |
| UI/UX dan layout |        |        |        |

### Sumber

Daftar tautan utama yang berhasil diperiksa.

### Keterbatasan

Jelaskan informasi atau visual yang belum berhasil diverifikasi.

### Perubahan File

Konfirmasikan bahwa hanya `refrensi_apk.md` yang diubah.

Jangan menyatakan penelitian selesai apabila sumber atau bukti utama belum berhasil diperiksa.

Jangan mengimplementasikan rekomendasi. Hasil penelitian harus menjadi bahan pertimbangan agar pemilik proyek dapat menyortir sendiri.
