---
description: Cari sebanyak mungkin aplikasi mobile sejenis dari GitHub, F-Droid, Google Play Store, App Store, dan berbagai toko aplikasi lainnya, lalu perbarui apk_serupa.md
agent: code
---

# PENCARIAN APK SEJENIS

**Lokasi command:** `.kilo/commands/cari_apk_serupa.md`

## 1. TUJUAN

Cari sebanyak mungkin aplikasi mobile yang memiliki fungsi, tujuan, kategori, atau kebutuhan pengguna yang serupa dengan proyek yang sedang dikerjakan.

Seluruh hasil pencarian wajib dimasukkan ke dalam:

`[ROOT_PROYEK]/apk_serupa.md`

Tugas ini hanya untuk mencari, memverifikasi, dan mendokumentasikan aplikasi sejenis. Jangan mengimplementasikan fitur atau mengubah kode proyek.

## 2. MEMAHAMI PROYEK

Sebelum melakukan pencarian:

1. Baca `AGENTS.md` dan aturan proyek yang relevan.
2. Periksa dokumentasi proyek untuk memahami tujuan dan fungsi aplikasi.
3. Periksa implementasi fitur yang sudah tersedia agar tidak salah menentukan kategori aplikasi.
4. Identifikasi jenis pengguna dan kebutuhan utama yang diselesaikan proyek.
5. Identifikasi platform mobile yang menjadi sasaran proyek.

Gunakan informasi aktual proyek sebagai dasar pencarian.

Jangan hanya mengandalkan nama proyek atau deskripsi singkatnya.

## 3. SUMBER PENCARIAN

Lakukan pencarian secara luas melalui berbagai sumber distribusi aplikasi mobile.

### 3.1. GitHub

Cari aplikasi mobile melalui:

- GitHub Repository Search.
- Repository dengan topik Android dan iOS.
- Repository Flutter, React Native, Kotlin, Java, Swift, dan teknologi mobile lainnya.
- Repository dengan dokumentasi dan bukti bahwa proyek tersebut merupakan aplikasi mobile.
- Bagian Releases apabila aplikasi menyediakan file instalasi.

Link yang dicantumkan harus mengarah ke repository aplikasi atau halaman release yang relevan.

Jangan memasukkan library, package, template, atau framework yang bukan aplikasi mobile siap digunakan sebagai referensi aplikasi.

### 3.2. F-Droid

Cari aplikasi Android melalui:

- Katalog F-Droid.
- Repository dan katalog tambahan F-Droid yang relevan.
- Halaman detail aplikasi.
- Sumber resmi pengembang apabila tersedia.

### 3.3. Google Play Store

Cari seluruh aplikasi Android yang memiliki kesamaan dengan tujuan atau fungsi proyek.

Gunakan variasi kata kunci berdasarkan:

- Nama kategori aplikasi.
- Fungsi utama.
- Kebutuhan pengguna.
- Nama fitur.
- Sinonim dan istilah pencarian terkait.

### 3.4. Apple App Store

Cari aplikasi iOS yang memiliki kesamaan fungsi dan tujuan dengan proyek.

Walaupun bukan berformat APK, aplikasi iOS tetap boleh dimasukkan sebagai referensi aplikasi mobile.

### 3.5. Toko aplikasi lainnya

Periksa juga toko aplikasi alternatif yang relevan, termasuk tetapi tidak terbatas pada:

- Huawei AppGallery.
- Samsung Galaxy Store.
- Amazon Appstore.
- Xiaomi GetApps.
- OPPO App Market.
- vivo App Store.
- APKPure.
- APKCombo.
- Uptodown.
- Aptoide.
- Toko aplikasi resmi lainnya yang ditemukan selama pencarian.

Jangan membatasi pencarian hanya pada daftar toko di atas.

## 4. KETENTUAN APLIKASI YANG BOLEH DITEMUKAN

Hanya masukkan aplikasi yang memang ditujukan untuk perangkat mobile.

Kriteria:

1. Aplikasi tersedia untuk Android atau iOS.
2. Memiliki fungsi, tujuan, kategori, atau kebutuhan pengguna yang relevan dengan proyek.
3. Dapat dijalankan melalui perangkat mobile.
4. Identitas aplikasi dapat diverifikasi.
5. Memiliki halaman aplikasi, repository, atau sumber distribusi yang bisa diakses.

Aplikasi yang membutuhkan internet, server, API, atau layanan backend tetap boleh dimasukkan selama pengguna mengoperasikannya melalui aplikasi mobile.

**Jangan memasukkan:**

- Website biasa.
- Aplikasi web yang hanya berjalan melalui browser.
- Software desktop Windows, Linux, atau macOS.
- Dashboard khusus komputer.
- Library dan package pemrograman.
- Framework pengembangan aplikasi.
- Repository yang hanya berisi contoh kode dan bukan aplikasi.
- Aplikasi yang tidak relevan dengan tujuan proyek.

Jangan memasukkan aplikasi hanya karena memiliki nama atau kategori yang mirip. Pastikan ada kesamaan fungsi atau kebutuhan pengguna.

## 5. STRATEGI PENCARIAN

Lakukan pencarian sebanyak mungkin dengan strategi berikut:

1. Gunakan berbagai variasi kata kunci untuk menemukan aplikasi yang memiliki fungsi serupa.
2. Cari menggunakan istilah bahasa Indonesia dan bahasa Inggris.
3. Telusuri setiap sumber distribusi yang relevan.
4. Cari aplikasi populer maupun aplikasi yang kurang dikenal.
5. Periksa aplikasi alternatif dengan fungsi serupa.
6. Telusuri aplikasi dari pengembang yang memiliki produk relevan lainnya.
7. Gunakan hasil pencarian sebelumnya untuk menemukan variasi aplikasi lain.
8. Lakukan pencarian lanjutan apabila masih ditemukan sumber atau kata kunci yang belum diperiksa.

Jangan berhenti setelah menemukan beberapa aplikasi pertama.

Teruskan pencarian selama masih ada peluang menemukan aplikasi relevan yang belum tercatat dan selama sumber pencarian masih dapat diakses.

Tidak perlu menetapkan batas jumlah aplikasi secara sembarangan.

Utamakan kelengkapan hasil pencarian daripada sekadar memperoleh daftar singkat.

## 6. VERIFIKASI HASIL

Sebelum memasukkan aplikasi ke dalam `apk_serupa.md`, lakukan pemeriksaan:

1. Pastikan aplikasi benar-benar merupakan aplikasi mobile.
2. Pastikan nama aplikasi sesuai dengan sumber aslinya.
3. Pastikan ringkasan sesuai dengan fungsi aplikasi.
4. Pastikan nama toko atau sumber distribusi benar.
5. Pastikan tautan mengarah ke aplikasi yang dimaksud.
6. Pastikan aplikasi relevan dengan proyek.
7. Periksa apakah aplikasi sudah tercatat sebelumnya.

Jangan mengarang informasi.

Apabila informasi aplikasi terbatas, tuliskan ringkasan berdasarkan informasi yang benar-benar tersedia.

Utamakan tautan resmi. Apabila menggunakan toko pihak ketiga, pastikan identitas aplikasi dan pengembang dapat diverifikasi.

Jangan mengunduh atau menjalankan APK yang tidak diperlukan untuk proses pencarian.

## 7. PENCEGAHAN DUPLIKASI

Sebelum menambahkan hasil:

1. Baca seluruh isi `apk_serupa.md` apabila file sudah tersedia.
2. Bandingkan nama aplikasi.
3. Periksa identitas pengembang, package name, bundle ID, repository, atau identitas lain apabila tersedia.
4. Jangan memasukkan aplikasi yang sama lebih dari satu kali hanya karena ditemukan di toko berbeda.
5. Apabila aplikasi yang sama tersedia di beberapa toko, gabungkan dalam satu entri dan cantumkan seluruh nama toko beserta tautannya.
6. Jangan menganggap dua aplikasi berbeda sebagai duplikat hanya karena namanya mirip.

Pertahankan seluruh aplikasi lama yang masih valid.

Jangan menghapus aplikasi lama hanya karena tidak populer atau ditemukan aplikasi alternatif lainnya.

## 8. FORMAT PENULISAN APK_SERUPA.MD

Perbarui file:

`[ROOT_PROYEK]/apk_serupa.md`

Apabila belum tersedia, buat file tersebut.

Gunakan bahasa Indonesia yang baik dan benar.

Susun hasil secara terstruktur berdasarkan kategori aplikasi yang relevan. Apabila kategori sulit ditentukan, gunakan satu kelompok yang paling sesuai.

Setiap aplikasi hanya boleh memiliki informasi berikut:

1. **Nama APK:** Nama resmi aplikasi.
2. **Ringkasan:** Penjelasan singkat mengenai tujuan dan fungsi utama aplikasi.
3. **Store:** Nama toko aplikasi atau sumber distribusinya.
4. **Link:** Tautan langsung menuju halaman aplikasi, repository, atau halaman release yang relevan.

Gunakan format Markdown berikut:

# DAFTAR APK SEJENIS

## 1. [Nama Kategori Aplikasi]

### 1. [Nama Aplikasi]

- **Nama APK:** Nama resmi aplikasi.
- **Ringkasan:** Penjelasan singkat mengenai fungsi utama aplikasi.
- **Store:** Google Play Store.
- **Link:** [Buka Aplikasi](https://contoh.com)

### 2. [Nama Aplikasi]

- **Nama APK:** Nama resmi aplikasi.
- **Ringkasan:** Penjelasan singkat mengenai fungsi utama aplikasi.
- **Store:** F-Droid.
- **Link:** [Buka Aplikasi](https://contoh.com)

## 2. [Kategori Aplikasi Lainnya]

Gunakan struktur yang sama untuk seluruh aplikasi yang ditemukan.

Ketentuan tambahan:

- Ringkasan harus singkat, jelas, dan langsung menjelaskan fungsi utama aplikasi.
- Jangan menambahkan analisis UI, UX, desain, atau rekomendasi fitur.
- Jangan menambahkan penilaian pribadi.
- Jangan menambahkan rating atau peringkat.
- Jangan menambahkan informasi yang tidak diminta.
- Pastikan setiap aplikasi memiliki tautan yang dapat diklik.
- Jika satu aplikasi tersedia di beberapa toko, cantumkan semua toko dan tautannya dalam satu entri.

**Format ini harus dipertahankan. Jangan memperluas isi setiap entri dengan informasi tambahan.**

## 9. PEMBARUAN FILE

Ketentuan perubahan:

1. Jika `apk_serupa.md` belum tersedia, buat file di root proyek.
2. Jika sudah tersedia, baca dan pertahankan seluruh data lama yang masih valid.
3. Tambahkan aplikasi baru yang berhasil diverifikasi.
4. Perbaiki tautan lama hanya apabila ditemukan tautan yang lebih tepat atau tautan sebelumnya sudah tidak valid.
5. Hapus duplikasi tanpa menghilangkan informasi sumber yang masih relevan.
6. Susun ulang kategori apabila diperlukan.
7. Jangan mengubah file lain.

## 10. BATASAN PEKERJAAN

Tugas ini hanya memperbolehkan perubahan pada:

`[ROOT_PROYEK]/apk_serupa.md`

Dilarang mengubah:

- Kode aplikasi.
- File konfigurasi.
- Dokumentasi lainnya.
- File desain.
- File perencanaan fitur.
- File aturan AI.
- File pengujian.
- File lainnya di dalam proyek.

Jangan mengimplementasikan fitur dari aplikasi yang ditemukan.

## 11. VERIFIKASI AKHIR

Sebelum menyelesaikan pekerjaan:

1. Pastikan semua sumber pencarian yang relevan telah ditelusuri.
2. Pastikan pencarian mencakup GitHub, F-Droid, Google Play Store, App Store, dan toko aplikasi alternatif.
3. Pastikan hanya aplikasi mobile yang dimasukkan.
4. Pastikan aplikasi relevan dengan tujuan proyek.
5. Pastikan tidak ada aplikasi duplikat.
6. Pastikan ringkasan sesuai dengan fungsi aslinya.
7. Pastikan nama store sesuai dengan sumber.
8. Pastikan seluruh tautan mengarah ke tujuan yang benar.
9. Pastikan aplikasi lama yang valid tetap dipertahankan.
10. Pastikan hanya `apk_serupa.md` yang mengalami perubahan.

## 12. LAPORAN PENYELESAIAN

Setelah selesai, laporkan:

1. Lokasi file yang diperbarui.
2. Jumlah aplikasi lama.
3. Jumlah aplikasi baru yang berhasil ditambahkan.
4. Jumlah total aplikasi setelah pembaruan.
5. Jumlah sumber atau toko aplikasi yang berhasil ditelusuri.
6. Ringkasan sumber distribusi yang berhasil digunakan.
7. Kendala pencarian apabila ada.
8. Daftar file yang mengalami perubahan.

**KRITERIA SELESAI:** Pencarian aplikasi mobile telah dilakukan seluas mungkin melalui berbagai sumber, hasil yang relevan dan terverifikasi sudah ditambahkan ke `apk_serupa.md`, data lama yang masih valid dipertahankan, dan tidak ada file proyek lain yang diubah.
