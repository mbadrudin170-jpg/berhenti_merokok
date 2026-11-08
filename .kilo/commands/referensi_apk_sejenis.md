---
description: Riset aplikasi sejenis, fitur mobile, dan pola UI/UX kompetitor untuk memperbarui referensi proyek
agent: code
---

# RISET REFERENSI APK SEJENIS

## 1. TUJUAN UTAMA

Lakukan riset mendalam terhadap aplikasi-aplikasi yang terdaftar di file `apk_serupa.md` pada root proyek.

Tujuan riset:

1. Menemukan sebanyak mungkin referensi fitur dari aplikasi sejenis yang berpotensi ditambahkan ke proyek.
2. Menemukan fitur dari aplikasi sejenis yang sudah tersedia di proyek dan mengidentifikasi peluang optimalisasinya.
3. Mengidentifikasi aplikasi kompetitor yang memiliki fitur serupa dengan proyek.
4. Menganalisis pola UI, UX, dan layout aplikasi kompetitor.
5. Memberikan rekomendasi berdasarkan hasil riset, disertai alasan dan referensi yang dapat diperiksa.
6. Memperbarui hasil riset ke file `refrensi_apk.md` di root proyek.

**PENTING: Tugas ini merupakan riset dan penyusunan rekomendasi. Jangan mengimplementasikan fitur, mengubah kode aplikasi, atau mengambil keputusan untuk memilih rekomendasi. Pengguna yang akan menyortir dan menentukan rekomendasi mana yang akan digunakan.**

---

## 2. BATASAN SUMBER APLIKASI

### 2.1. Sumber daftar aplikasi

Gunakan hanya:

`[ROOT_PROYEK]/apk_serupa.md`

Ketentuan:

1. Baca seluruh isi `apk_serupa.md` di root proyek.
2. Identifikasi semua aplikasi yang terdaftar di dalamnya.
3. Wajib melakukan riset terhadap setiap aplikasi yang terdaftar. Jangan hanya memilih beberapa aplikasi.
4. Jangan melewatkan aplikasi karena dianggap kurang populer, sulit ditemukan, atau memiliki informasi terbatas.
5. Jangan mengambil daftar aplikasi pengganti dari file lain.
6. Jangan mengubah isi `apk_serupa.md`.
7. Jangan memperluas daftar aplikasi di luar sumber tersebut. Seluruh referensi aplikasi yang dianalisis harus berasal dari daftar itu.

Apabila file `apk_serupa.md` tidak ditemukan, jangan membuat daftar aplikasi sendiri. Laporkan kendala tersebut dan hentikan riset sampai sumber daftar tersedia.

### 2.2. Kelengkapan pencarian

Cari informasi sebanyak mungkin untuk setiap aplikasi yang terdaftar.

Gunakan berbagai jenis sumber yang tersedia, dengan mengutamakan:

- Google Play Store.
- Apple App Store apabila tersedia.
- Website resmi pengembang.
- Dokumentasi atau halaman bantuan resmi.
- Screenshot dan gambar promosi aplikasi.
- Video demonstrasi aplikasi.
- Catatan pembaruan atau changelog.
- Ulasan pengguna yang relevan.
- Artikel atau pembahasan pihak ketiga yang memiliki informasi konkret.

Lakukan pencarian menggunakan nama aplikasi, nama pengembang, fitur aplikasi, cara penggunaan, screenshot, serta istilah lain yang relevan.

Jangan berhenti setelah menemukan satu halaman referensi. Telusuri sumber tambahan sampai informasi yang ditemukan mulai berulang atau tidak lagi menghasilkan temuan relevan.

Prioritaskan sumber yang memperlihatkan fitur atau tampilan aplikasi secara langsung.

### 2.3. Validitas sumber

1. Setiap temuan harus didukung oleh sumber yang dapat diperiksa.
2. Utamakan sumber resmi untuk memastikan identitas aplikasi dan ketersediaan fitur.
3. Jangan menganggap fitur tersedia hanya berdasarkan nama atau deskripsi singkat aplikasi.
4. Bedakan informasi yang sudah terverifikasi dengan informasi yang belum dapat dipastikan.
5. Jangan membuat tautan, nama aplikasi, fitur, atau bukti penggunaan yang tidak ditemukan.
6. Apabila aplikasi sudah tidak tersedia, tandai statusnya dan gunakan sumber historis yang masih dapat diperiksa.
7. Jika informasi tidak cukup, tuliskan bahwa informasi belum tersedia. Jangan mengarang kesimpulan.
8. Jangan mengunduh, memasang, atau menjalankan APK dari sumber yang tidak diperlukan untuk riset.

---

## 3. MEMAHAMI PROYEK SEBELUM MELAKUKAN RISET

Sebelum mencari referensi, pahami terlebih dahulu proyek yang sedang dikerjakan.

### 3.1. Baca aturan proyek

Periksa dan baca aturan yang berlaku di repositori, terutama:

- `AGENTS.md`.
- Aturan khusus yang berlaku untuk pekerjaan ini.
- Dokumentasi proyek yang relevan.

Jangan mengabaikan aturan repositori.

### 3.2. Identifikasi kondisi proyek

Pelajari informasi proyek melalui dokumentasi dan kode yang relevan, termasuk:

- Nama dan tujuan aplikasi.
- Fungsi utama aplikasi.
- Target pengguna.
- Platform yang didukung.
- Fitur yang sudah selesai dibuat.
- Fitur yang sedang dikembangkan.
- Fitur yang sudah direncanakan.
- Alur penggunaan aplikasi.
- Struktur navigasi dan halaman.
- Komponen UI yang sudah tersedia.

Bedakan secara tegas antara:

1. Fitur yang sudah diterapkan dan dapat digunakan.
2. Fitur yang baru diterapkan sebagian.
3. Fitur yang masih direncanakan.
4. Fitur yang belum tersedia.

Jangan menganggap fitur sudah selesai hanya karena terdapat nama atau rancangan fiturnya di dokumentasi.

Gunakan kondisi proyek yang sebenarnya sebagai dasar perbandingan.

---

# 4. RISET FITUR APLIKASI SEJENIS

Bagian ini bertujuan menemukan peluang penambahan dan optimalisasi fitur.

## 4.1. Menemukan fitur baru

Cari fitur dari seluruh aplikasi dalam `apk_serupa.md` yang berpotensi ditambahkan ke proyek.

Ketentuan:

1. Rekomendasi hanya boleh mencakup fitur yang dapat digunakan melalui aplikasi mobile.
2. Utamakan fitur yang bisa dioperasikan langsung oleh pengguna melalui perangkat Android atau iOS.
3. Fitur yang membutuhkan server atau layanan backend tetap boleh direkomendasikan selama pengguna dapat mengoperasikannya melalui aplikasi mobile.
4. Jangan merekomendasikan fitur yang hanya bisa digunakan melalui website, dashboard desktop, atau komputer.
5. Jangan merekomendasikan fitur yang tidak relevan dengan tujuan proyek.
6. Jangan menyarankan fitur hanya karena tersedia di aplikasi kompetitor. Jelaskan manfaat dan relevansinya terhadap proyek.

Untuk setiap fitur yang ditemukan, jelaskan:

- Nama fitur.
- Aplikasi yang memiliki fitur tersebut.
- Tujuan fitur.
- Masalah pengguna yang diselesaikan.
- Cara kerja fitur.
- Gambaran alur penggunaan di perangkat mobile.
- Manfaat apabila ditambahkan ke proyek.
- Syarat atau ketergantungan teknis apabila ada.
- Alasan tingkat prioritas.
- Tautan referensi yang membuktikan keberadaan fitur.

## 4.2. Mengidentifikasi fitur yang sudah tersedia

Cari fitur aplikasi kompetitor yang memiliki fungsi sama atau mendekati fitur yang sudah terdapat di proyek.

Jangan hanya mencari fitur baru.

Periksa apakah fitur yang sudah ada di proyek masih memiliki peluang peningkatan berdasarkan implementasi pada aplikasi sejenis.

Untuk setiap fitur yang memiliki kesamaan, jelaskan:

- Nama fitur di proyek.
- Kondisi fitur saat ini di proyek.
- Nama aplikasi pembanding.
- Fitur serupa yang tersedia di aplikasi pembanding.
- Persamaan dan perbedaan penerapannya.
- Kelebihan pendekatan aplikasi pembanding.
- Kekurangan atau keterbatasan yang terlihat.
- Peluang optimalisasi pada fitur proyek.
- Rekomendasi perbaikan yang konkret.
- Alasan tingkat prioritas.
- Tautan referensi.

**Jangan merekomendasikan penambahan ulang fitur yang sebenarnya sudah tersedia. Apabila fungsinya sudah ada, fokuskan rekomendasi pada peningkatan kualitas, kemudahan penggunaan, kelengkapan fungsi, atau efisiensinya.**

## 4.3. Penentuan prioritas fitur

Kelompokkan seluruh rekomendasi ke dalam:

**Prioritas Tinggi**

- Sangat berkaitan dengan fungsi utama proyek.
- Memberikan manfaat langsung kepada pengguna.
- Menyelesaikan kebutuhan atau masalah yang penting.
- Memiliki alasan dan bukti referensi yang kuat.

**Prioritas Menengah**

- Memberikan manfaat tambahan yang cukup berarti.
- Meningkatkan pengalaman atau efisiensi penggunaan.
- Tidak sepenting kebutuhan utama aplikasi.

**Prioritas Rendah**

- Bersifat tambahan atau opsional.
- Manfaatnya lebih terbatas.
- Tidak terlalu berpengaruh terhadap fungsi utama proyek.

Berikan alasan untuk setiap prioritas. Jangan menentukan bahwa rekomendasi wajib diterapkan.

---

# 5. RISET UI, UX, DAN LAYOUT KOMPETITOR

Tujuan bagian ini adalah mencari referensi tampilan dan pengalaman penggunaan dari aplikasi kompetitor yang memiliki fitur sama atau serupa dengan proyek.

## 5.1. Menentukan aplikasi pembanding

Gunakan aplikasi yang terdaftar di `apk_serupa.md`.

Identifikasi aplikasi yang memiliki:

- Fungsi utama yang sama.
- Fitur tertentu yang sama.
- Alur penggunaan yang serupa.
- Jenis pengguna atau kebutuhan yang serupa.

Jangan menganggap dua aplikasi memiliki pola penggunaan yang sama hanya karena berada dalam kategori yang sama.

Utamakan aplikasi yang mempunyai bukti fitur dan tampilan yang dapat diperiksa.

## 5.2. Analisis UI

Identifikasi pola tampilan aplikasi kompetitor, meliputi:

- Struktur halaman.
- Susunan komponen.
- Navigasi dan menu.
- Penempatan tombol tindakan.
- Hierarki informasi.
- Penggunaan kartu dan daftar.
- Susunan formulir.
- Penempatan informasi penting.
- Penggunaan ruang dan jarak antarkomponen.
- Konsistensi tampilan ant halaman.
- Penggunaan warna dan tipografi apabila dapat diamati.

Jelaskan tujuan dari pola UI yang ditemukan dan alasan pola tersebut digunakan.

## 5.3. Analisis UX

Identifikasi pengalaman penggunaan aplikasi kompetitor, meliputi:

- Kemudahan memahami fungsi aplikasi.
- Kemudahan menemukan fitur.
- Jumlah langkah dalam menyelesaikan tindakan.
- Kejelasan alur penggunaan.
- Kemudahan mengisi formulir.
- Kejelasan fungsi tombol.
- Umpan balik setelah tindakan pengguna.
- Tampilan loading.
- Tampilan ketika data kosong.
- Tampilan ketika terjadi kesalahan.
- Konfirmasi tindakan penting.
- Kemudahan berpindah halaman.
- Konsistensi perilaku komponen.

Jelaskan bagaimana pola UX tersebut membantu atau justru menyulitkan pengguna.

## 5.4. Analisis layout mobile

Fokuskan pengamatan pada tampilan perangkat mobile.

Periksa:

- Penempatan elemen berdasarkan ukuran layar.
- Susunan informasi dari atas ke bawah.
- Penggunaan area layar.
- Kemudahan menjangkau tombol.
- Kepadatan informasi.
- Keterbacaan teks.
- Hubungan antarbagian dalam satu halaman.
- Kemudahan penggunaan dengan satu tangan apabila relevan.

Jangan menggunakan pola layout website desktop sebagai rekomendasi untuk aplikasi mobile.

## 5.5. Rekomendasi UI, UX, dan layout

Untuk setiap temuan, berikan:

1. Nama fitur atau halaman proyek yang berkaitan.
2. Nama aplikasi kompetitor sebagai referensi.
3. Pola UI, UX, atau layout yang ditemukan.
4. Tujuan pola tersebut.
5. Kelebihan pola tersebut.
6. Potensi kekurangan atau risiko apabila diterapkan.
7. Rekomendasi yang dapat dipertimbangkan untuk proyek.
8. Alasan tingkat prioritas.
9. Tautan sumber, screenshot, atau demonstrasi yang mendukung temuan.

Pisahkan dengan jelas:

- **Temuan:** hal yang benar-benar terlihat atau dapat diverifikasi dari aplikasi referensi.
- **Analisis:** penjelasan mengenai tujuan, kelebihan, dan kekurangan pola tersebut.
- **Rekomendasi:** usulan penerapan atau penyesuaian untuk proyek.

Jangan mengubah UI, UX, atau layout proyek. Pengguna akan menentukan sendiri rekomendasi yang akan dipilih.

---

# 6. ATURAN PENYUSUNAN HASIL RISET

## 6.1. Pengelompokan

Semua temuan wajib dikelompokkan berdasarkan dua kategori utama:

**A. FITUR**

- Fitur baru yang berpotensi ditambahkan.
- Fitur yang sudah ada dan berpotensi dioptimalkan.

**B. UI, UX, DAN LAYOUT**

- Referensi UI.
- Referensi UX.
- Referensi layout mobile.
- Rekomendasi peningkatan tampilan dan pengalaman penggunaan.

Di dalam setiap kelompok, susun berdasarkan prioritas tinggi, menengah, lalu rendah.

Jangan mencampur rekomendasi fitur dengan rekomendasi UI/UX tanpa pengelompokan yang jelas.

## 6.2. Standar referensi

Setiap temuan wajib memiliki tautan sumber yang relevan.

Ketentuan:

1. Cantumkan tautan halaman aplikasi resmi apabila tersedia.
2. Cantumkan tautan spesifik yang mendukung fitur atau pola UI/UX yang dibahas.
3. Apabila menggunakan screenshot atau video, sertakan tautan sumbernya.
4. Jangan hanya mencantumkan halaman utama website apabila terdapat sumber yang lebih spesifik.
5. Jangan menggunakan satu tautan sebagai bukti untuk banyak klaim yang sebenarnya tidak didukung oleh tautan tersebut.
6. Apabila temuan didukung beberapa aplikasi, cantumkan semua aplikasi dan tautan pendukung yang relevan.
7. Jangan menghilangkan sumber hanya karena informasi sudah dijelaskan menggunakan kata-kata sendiri.

## 6.3. Hindari duplikasi

Apabila beberapa aplikasi memiliki fitur atau pola UI/UX yang sama:

- Gabungkan temuan yang benar-benar setara.
- Sebutkan seluruh aplikasi yang menjadi referensi.
- Jelaskan perbedaan pendekatan jika terdapat perbedaan.
- Jangan membuat rekomendasi berulang hanya karena ditemukan pada aplikasi yang berbeda.

Tetap pisahkan fitur yang mempunyai tujuan atau alur penggunaan berbeda meskipun namanya mirip.

## 6.4. Jangan mengambil keputusan untuk pengguna

Tugas AI hanya mengumpulkan, membandingkan, menganalisis, dan memberikan rekomendasi.

Jangan:

- Menetapkan fitur yang wajib ditambahkan.
- Menghapus rekomendasi yang dianggap kurang menarik tanpa alasan.
- Memilih satu aplikasi sebagai satu-satunya referensi terbaik.
- Mengubah kode proyek.
- Mengimplementasikan desain.
- Membuat perubahan pada rencana fitur proyek.

Berikan cukup informasi agar pengguna dapat melakukan penyortiran dan pemilihan sendiri.

---

# 7. FORMAT FILE HASIL

Simpan dan perbarui seluruh hasil riset di:

`[ROOT_PROYEK]/refrensi_apk.md`

Ketentuan:

1. Jika file belum tersedia, buat file tersebut.
2. Jika file sudah tersedia, baca isinya terlebih dahulu.
3. Pertahankan temuan lama yang masih relevan dan memiliki sumber valid.
4. Perbarui informasi yang sudah berubah atau tidak lagi akurat.
5. Gabungkan temuan baru tanpa membuat duplikasi.
6. Susun ulang jika struktur sebelumnya tidak sesuai dengan format yang ditentukan.
7. Jangan menghapus temuan valid hanya untuk mempersingkat laporan.
8. Jangan membuat file hasil riset alternatif dengan nama berbeda.
9. Gunakan bahasa Indonesia yang baik dan benar.
10. Gunakan Markdown dengan heading, subheading, tabel jika diperlukan, serta tautan yang dapat diklik.

## 7.1. Struktur wajib `refrensi_apk.md`

Susun laporan menggunakan struktur berikut:

# REFERENSI APLIKASI SEJENIS

## 1. Informasi Riset

- Tanggal riset terakhir.
- Tujuan riset.
- Nama proyek.
- Deskripsi singkat proyek.
- Target pengguna.
- Platform yang menjadi fokus.
- File sumber daftar aplikasi.

## 2. Daftar Aplikasi yang Diteliti

Cantumkan seluruh aplikasi yang berasal dari `apk_serupa.md`.

Untuk setiap aplikasi, tuliskan:

- Nama aplikasi.
- Pengembang.
- Platform.
- Status ketersediaan.
- Fungsi utama.
- Tautan resmi.
- Keterangan kelengkapan informasi riset.

Jangan melewatkan aplikasi yang informasinya terbatas. Berikan keterangan apabila informasi aplikasi tersebut belum berhasil ditemukan.

## 3. Rekomendasi Fitur

### 3.1. Prioritas Tinggi

Temuan fitur baru dan optimalisasi yang termasuk prioritas tinggi.

### 3.2. Prioritas Menengah

Temuan fitur baru dan optimalisasi yang termasuk prioritas menengah.

### 3.3. Prioritas Rendah

Temuan fitur baru dan optimalisasi yang termasuk prioritas rendah.

Kelompokkan setiap temuan menjadi:

- Fitur baru.
- Optimalisasi fitur yang sudah ada.

Untuk setiap temuan, cantumkan tujuan, manfaat, cara kerja, kondisi fitur proyek, rekomendasi, alasan prioritas, dan tautan referensi.

## 4. Referensi UI, UX, dan Layout

### 4.1. Prioritas Tinggi

### 4.2. Prioritas Menengah

### 4.3. Prioritas Rendah

Kelompokkan berdasarkan fitur atau halaman proyek yang berkaitan.

Untuk setiap temuan, cantumkan:

- Nama aplikasi referensi.
- Nama fitur atau halaman.
- Pola UI yang ditemukan.
- Pola UX yang ditemukan.
- Pola layout mobile.
- Tujuan pola tersebut.
- Kelebihan dan kekurangan.
- Rekomendasi untuk proyek.
- Alasan prioritas.
- Tautan referensi visual atau dokumentasi.

## 5. Ringkasan Perbandingan

Berikan ringkasan yang memudahkan pengguna membandingkan:

- Fitur yang belum tersedia di proyek.
- Fitur yang sudah tersedia tetapi berpotensi dioptimalkan.
- Aplikasi yang memiliki fitur serupa.
- Pola UI/UX yang paling relevan sebagai bahan pertimbangan.

## 6. Daftar Referensi dan Sumber

Cantumkan tautan sumber yang digunakan dan kelompokkan berdasarkan aplikasi.

Pastikan tautan mengarah ke sumber yang benar-benar digunakan selama riset.

## 7. Catatan dan Keterbatasan Riset

Tuliskan:

- Aplikasi yang informasinya sulit ditemukan.
- Fitur yang belum dapat diverifikasi.
- Screenshot atau demonstrasi yang tidak tersedia.
- Informasi yang masih membutuhkan pemeriksaan lebih lanjut.
- Keterbatasan akses terhadap aplikasi.

---

# 8. BATASAN PERUBAHAN FILE

Tugas ini hanya memperbolehkan perubahan pada:

`[ROOT_PROYEK]/refrensi_apk.md`

Dilarang mengubah:

- Kode aplikasi.
- File konfigurasi proyek.
- `pubspec.yaml`.
- `apk_serupa.md`.
- Dokumentasi proyek lainnya.
- File aturan repositori.
- File perencanaan fitur.
- File desain.
- File pengujian.

Jangan membuat file tambahan untuk menyimpan hasil sementara atau laporan alternatif.

Apabila terdapat informasi proyek yang tidak cukup untuk membuat perbandingan, catat kekurangan tersebut di laporan. Jangan mengubah file lain untuk melengkapi informasi.

---

# 9. VERIFIKASI SEBELUM SELESAI

Sebelum menyelesaikan tugas, lakukan pemeriksaan berikut:

1. Pastikan semua aplikasi dalam `apk_serupa.md` sudah masuk dalam daftar penelitian.
2. Pastikan setiap aplikasi telah ditelusuri, bukan hanya aplikasi yang paling populer.
3. Pastikan seluruh rekomendasi fitur dapat digunakan melalui aplikasi mobile.
4. Pastikan fitur baru dibedakan dari optimalisasi fitur yang sudah tersedia.
5. Pastikan aplikasi pembanding memiliki fitur yang relevan dengan proyek.
6. Pastikan temuan UI, UX, dan layout didasarkan pada sumber visual atau informasi yang dapat diperiksa.
7. Pastikan temuan, analisis, dan rekomendasi tidak tercampur.
8. Pastikan setiap temuan memiliki tautan referensi yang relevan.
9. Pastikan rekomendasi dikelompokkan berdasarkan prioritas.
10. Pastikan tidak ada rekomendasi yang terduplikasi.
11. Pastikan temuan lama yang masih valid tidak hilang.
12. Pastikan hanya `refrensi_apk.md` yang mengalami perubahan.

Jika terdapat bagian yang belum berhasil diteliti, jangan menyembunyikan kekurangannya. Cantumkan secara transparan di bagian keterbatasan riset.

---

# 10. LAPORAN PENYELESAIAN

Setelah selesai, berikan laporan kepada pengguna yang berisi:

1. Lokasi file yang diperbarui: `refrensi_apk.md`.
2. Jumlah aplikasi yang terdaftar di `apk_serupa.md`.
3. Jumlah aplikasi yang berhasil diteliti.
4. Jumlah aplikasi yang informasinya belum lengkap.
5. Jumlah rekomendasi fitur baru.
6. Jumlah rekomendasi optimalisasi fitur.
7. Jumlah rekomendasi UI/UX dan layout.
8. Ringkasan hasil berdasarkan prioritas.
9. Daftar kendala atau keterbatasan riset.
10. Daftar file yang mengalami perubahan.

**KRITERIA SELESAI:** Riset seluruh aplikasi dalam daftar sumber telah dilakukan semaksimal mungkin, hasilnya sudah disusun dan diperbarui di `refrensi_apk.md`, tautan referensi sudah disertakan, dan tidak ada perubahan pada kode maupun file proyek lainnya.
