---
description: Analisis seluruh APK yang terdaftar di apk_serupa.md untuk menemukan referensi fitur, optimasi fitur, serta pola UI, UX, dan layout aplikasi kompetitor, kemudian perbarui refrensi_apk.md.
agent: code
---

# Analisis Referensi APK Sejenis

## Tujuan

Lakukan analisis terhadap seluruh aplikasi mobile yang sudah terdaftar di file `apk_serupa.md` pada direktori root proyek.

Tujuan analisis adalah menemukan:

1. Fitur baru dari aplikasi sejenis yang berpotensi ditambahkan ke proyek.
2. Peluang optimasi terhadap fitur yang sudah dimiliki proyek.
3. Referensi UI, UX, dan layout dari aplikasi kompetitor yang memiliki fitur serupa.
4. Rekomendasi pengembangan berdasarkan hasil analisis.

Seluruh hasil analisis wajib dicatat di file `refrensi_apk.md` pada direktori root proyek.

**Penting:** Tugas AI hanya melakukan riset, analisis, dan memberikan rekomendasi. Pengguna yang akan menentukan rekomendasi mana yang akan dipilih dan diterapkan.

## 1. Persiapan dan Pemahaman Proyek

Sebelum melakukan analisis:

1. Baca `AGENTS.md` dan aturan lain yang berlaku di proyek.
2. Baca dokumentasi proyek yang relevan.
3. Periksa struktur proyek.
4. Pelajari fitur dan fungsi aplikasi yang benar-benar sudah tersedia.
5. Identifikasi kategori, tujuan, target pengguna, dan alur penggunaan aplikasi.
6. Identifikasi fitur yang sudah berjalan dan fitur yang masih dalam pengembangan.

Gunakan kode sumber, dokumentasi, dan tampilan aplikasi sebagai dasar untuk memahami kondisi aktual proyek.

Jangan membuat asumsi mengenai fitur yang belum terbukti keberadaannya.

## 2. Sumber Referensi APK

Sumber utama pencarian adalah:

`apk_serupa.md`

Lokasi: direktori root proyek.

Ketentuan:

1. Baca seluruh isi `apk_serupa.md`.
2. Periksa semua aplikasi yang terdaftar di dalamnya.
3. Jangan melewatkan aplikasi yang terdaftar.
4. Jangan mencari atau menambahkan aplikasi kompetitor baru yang tidak terdaftar di file tersebut.
5. Gunakan tautan yang tersedia di `apk_serupa.md` untuk membuka halaman aplikasi, repositori, dokumentasi, screenshot, atau informasi lain yang berkaitan langsung dengan aplikasi tersebut.
6. Apabila satu aplikasi memiliki beberapa tautan dari store berbeda, manfaatkan tautan tersebut untuk memperkaya referensi.
7. Jangan menganggap suatu fitur tersedia hanya berdasarkan nama aplikasi atau kategori aplikasinya.

**Batasan sumber:** Analisis kompetitor hanya boleh menggunakan aplikasi yang sudah terdaftar di `apk_serupa.md`. Sumber tambahan hanya boleh digunakan untuk memeriksa informasi aplikasi yang sama, bukan untuk menemukan APK kompetitor baru.

Apabila suatu aplikasi tidak dapat diakses, catat keterbatasannya dan lanjutkan analisis terhadap aplikasi lainnya.

## 3. Analisis Fitur Aplikasi

Bagian ini bertujuan menemukan fitur yang dapat meningkatkan fungsi dan manfaat aplikasi proyek.

Lakukan dua jenis analisis berikut.

### A. Rekomendasi Fitur Baru

Cari fitur dari aplikasi sejenis yang belum tersedia di proyek dan berpotensi untuk ditambahkan.

Ketentuan:

1. Identifikasi fitur yang benar-benar tersedia pada aplikasi referensi.
2. Pahami tujuan dan manfaat fitur tersebut.
3. Identifikasi permasalahan pengguna yang diselesaikan oleh fitur tersebut.
4. Analisis kesesuaian fitur dengan tujuan dan kategori proyek.
5. Pertimbangkan manfaatnya bagi pengguna proyek.
6. Berikan rekomendasi fitur yang relevan dan layak dipertimbangkan.

**Batasan platform:**

Hanya rekomendasikan fitur yang dapat digunakan oleh pengguna melalui aplikasi mobile Android atau iOS.

Jangan merekomendasikan:

- Fitur khusus website.
- Fitur khusus aplikasi desktop.
- Fitur yang hanya dapat digunakan melalui browser komputer.
- Fitur yang tidak relevan dengan penggunaan aplikasi mobile.

Fitur yang memerlukan layanan backend tetap boleh direkomendasikan selama fungsi utamanya dapat digunakan melalui aplikasi mobile. Jelaskan ketergantungan tersebut apabila relevan.

Jangan memasukkan fitur hanya karena tersedia di aplikasi kompetitor. Pastikan fitur tersebut memiliki manfaat nyata bagi proyek.

### B. Optimasi Fitur yang Sudah Ada

Cari kesamaan fitur antara aplikasi referensi dan aplikasi proyek.

Tujuan analisis ini adalah menemukan peluang peningkatan terhadap fitur yang sudah dimiliki proyek.

Untuk setiap fitur yang sama:

1. Identifikasi fitur pada aplikasi proyek.
2. Identifikasi aplikasi referensi yang memiliki fitur serupa.
3. Bandingkan cara kerja dan alur penggunaan fitur.
4. Identifikasi kelebihan pendekatan aplikasi referensi.
5. Cari kekurangan atau keterbatasan pendekatan fitur yang digunakan proyek apabila dapat dibuktikan.
6. Identifikasi peluang peningkatan.
7. Berikan rekomendasi optimasi.

Perhatikan aspek berikut:

- Kemudahan penggunaan.
- Kecepatan penyelesaian aktivitas.
- Jumlah langkah yang dibutuhkan pengguna.
- Kejelasan informasi.
- Efisiensi interaksi.
- Konsistensi perilaku fitur.
- Pencegahan kesalahan pengguna.
- Kenyamanan penggunaan di perangkat mobile.

Jangan menyarankan perubahan hanya karena aplikasi kompetitor memiliki cara kerja yang berbeda.

Rekomendasi harus mempunyai alasan yang jelas dan memberikan potensi peningkatan dibandingkan kondisi proyek saat ini.

## 4. Analisis UI, UX, dan Layout

Bagian ini bertujuan menemukan referensi desain dari aplikasi kompetitor yang memiliki fitur sama atau serupa dengan proyek.

Gunakan aplikasi yang sudah terdaftar di `apk_serupa.md` sebagai satu-satunya daftar kompetitor yang dianalisis.

### A. Identifikasi Kompetitor

Dari seluruh aplikasi yang terdaftar:

1. Identifikasi aplikasi yang mempunyai fitur sama dengan proyek.
2. Kelompokkan aplikasi berdasarkan kesamaan fitur.
3. Prioritaskan aplikasi yang mempunyai alur penggunaan dan tujuan fitur paling mendekati proyek.
4. Manfaatkan screenshot, halaman aplikasi, atau demonstrasi visual yang tersedia.

Jangan membandingkan tampilan dua fitur yang sebenarnya memiliki fungsi berbeda tanpa menjelaskan perbedaannya.

### B. Analisis UI (User Interface)

Identifikasi pola tampilan dari aplikasi referensi, meliputi:

- Susunan komponen.
- Struktur halaman.
- Penempatan tombol dan tindakan utama.
- Penggunaan kartu dan daftar.
- Navigasi antarhalaman.
- Hierarki informasi.
- Penggunaan ikon.
- Penggunaan warna.
- Penyajian informasi.
- Pengelompokan konten.
- Konsistensi komponen visual.

Jelaskan pola UI yang ditemukan dan tujuan penggunaannya.

### C. Analisis UX (User Experience)

Identifikasi pola pengalaman pengguna, meliputi:

- Kemudahan memahami fungsi halaman.
- Kemudahan menemukan fitur.
- Alur penyelesaian aktivitas.
- Jumlah interaksi untuk menyelesaikan tugas.
- Kejelasan tindakan dan konsekuensinya.
- Umpan balik setelah pengguna melakukan tindakan.
- Penanganan kondisi loading, kosong, berhasil, dan gagal.
- Pencegahan kesalahan pengguna.
- Kenyamanan penggunaan di perangkat mobile.

Jelaskan manfaat pendekatan UX tersebut bagi pengguna.

### D. Analisis Layout

Perhatikan bagaimana aplikasi referensi mengatur:

- Pembagian area halaman.
- Posisi konten utama.
- Jarak antar elemen.
- Padding dan margin.
- Ukuran komponen.
- Penggunaan ruang layar.
- Posisi navigasi.
- Pengaturan konten pada berbagai ukuran layar.
- Prioritas informasi berdasarkan kepentingannya.

Jelaskan tujuan susunan layout tersebut dan pengaruhnya terhadap kemudahan penggunaan.

### E. Rekomendasi UI, UX, dan Layout

Setelah analisis, berikan rekomendasi untuk proyek.

Setiap rekomendasi harus menjelaskan:

1. Referensi aplikasi yang digunakan.
2. Pola UI, UX, atau layout yang ditemukan.
3. Tujuan penggunaan pola tersebut.
4. Kondisi atau potensi masalah pada proyek yang berkaitan.
5. Rekomendasi yang dapat diterapkan.
6. Manfaat yang diharapkan.

Jangan sekadar menyuruh meniru tampilan aplikasi kompetitor.

Ambil pola yang bermanfaat, kemudian sesuaikan dengan tujuan, karakteristik, dan kebutuhan pengguna proyek.

**Ketentuan bukti visual:**

- Apabila screenshot tersedia, periksa screenshot tersebut sebelum menyimpulkan pola visual.
- Apabila tersedia beberapa halaman, analisis halaman yang relevan dengan fitur yang dibandingkan.
- Jangan mengarang detail tampilan yang tidak dapat dilihat.
- Apabila screenshot atau demonstrasi visual tidak tersedia, nyatakan bahwa analisis visual belum dapat diverifikasi.
- Bedakan fakta hasil pengamatan dengan interpretasi dan rekomendasi.

## 5. Prioritas Rekomendasi

Semua temuan harus disusun berdasarkan tingkat prioritas.

Gunakan tiga tingkat prioritas:

### Prioritas Tinggi

Rekomendasi dengan manfaat besar, relevansi tinggi terhadap tujuan proyek, atau berpotensi memperbaiki masalah penting dalam penggunaan aplikasi.

### Prioritas Menengah

Rekomendasi yang memiliki manfaat jelas, tetapi dampaknya tidak sepenting prioritas tinggi atau dapat diterapkan setelah kebutuhan utama terpenuhi.

### Prioritas Rendah

Rekomendasi tambahan yang bermanfaat, tetapi tidak terlalu mendesak atau dampaknya relatif kecil.

Pertimbangkan beberapa aspek dalam menentukan prioritas:

- Relevansi terhadap tujuan aplikasi.
- Manfaat bagi pengguna.
- Frekuensi kebutuhan fitur.
- Dampak terhadap kemudahan penggunaan.
- Potensi peningkatan kualitas aplikasi.
- Kelayakan penerapan pada perangkat mobile.
- Perkiraan kompleksitas penerapan.

Prioritas merupakan penilaian awal AI, bukan keputusan final untuk implementasi.

**Jangan menghapus rekomendasi hanya karena prioritasnya rendah.** Pengguna akan melakukan penyortiran sendiri.

## 6. Aturan Referensi dan Validitas Analisis

Setiap temuan wajib memiliki tautan referensi.

Ketentuan:

1. Cantumkan tautan langsung menuju aplikasi yang menjadi sumber referensi.
2. Gunakan tautan yang sudah tersedia di `apk_serupa.md` apabila relevan.
3. Apabila tersedia halaman dokumentasi atau screenshot resmi dari aplikasi yang sama, tautan tersebut boleh disertakan sebagai referensi tambahan.
4. Pastikan tautan mengarah ke sumber yang sesuai.
5. Jangan mengarang informasi atau tautan.
6. Jangan menyatakan suatu fitur tersedia apabila tidak ditemukan bukti pendukung.
7. Jangan menyimpulkan pola UI atau layout tanpa bukti visual yang memadai.
8. Apabila informasi tidak ditemukan, nyatakan bahwa informasi tersebut belum dapat diverifikasi.

Pisahkan dengan jelas:

- Hasil pengamatan.
- Analisis atau interpretasi.
- Rekomendasi untuk proyek.

Jangan menyajikan pendapat AI sebagai fakta mengenai aplikasi referensi.

## 7. Format Penulisan `refrensi_apk.md`

Lokasi file wajib:

`refrensi_apk.md`

Direktori: root proyek.

Gunakan bahasa Indonesia yang baik dan benar.

Susun dokumen dengan struktur berikut.

# Referensi Aplikasi Sejenis

## 1. Ringkasan Analisis

Jelaskan secara singkat:

- Tujuan analisis.
- Jumlah aplikasi yang diperiksa.
- Jumlah aplikasi yang berhasil dianalisis.
- Keterbatasan sumber apabila ada.
- Gambaran umum hasil penelitian.

## 2. Referensi dan Rekomendasi Fitur

Kelompokkan rekomendasi berdasarkan prioritas.

### Prioritas Tinggi

#### Nama Fitur

**Sumber Referensi:** Nama aplikasi dan nama store.

**Link:** Tautan langsung aplikasi.

**Kondisi pada Proyek:** Jelaskan apakah fitur belum tersedia atau sudah tersedia.

**Tujuan Fitur:** Jelaskan permasalahan yang diselesaikan dan manfaatnya bagi pengguna.

**Hasil Pengamatan:** Jelaskan bagaimana aplikasi referensi menerapkan fitur tersebut.

**Rekomendasi:** Jelaskan usulan penerapan atau pengembangan fitur pada proyek.

**Alasan Prioritas:** Jelaskan mengapa fitur ini masuk kategori prioritas tinggi.

### Prioritas Menengah

Gunakan format penulisan yang sama.

### Prioritas Rendah

Gunakan format penulisan yang sama.

## 3. Rekomendasi Optimasi Fitur yang Sudah Ada

Kelompokkan berdasarkan fitur yang ditemukan pada proyek.

### Prioritas Tinggi

#### Nama Fitur Proyek

**Sumber Referensi:** Nama aplikasi dan nama store.

**Link:** Tautan langsung aplikasi.

**Kondisi Saat Ini:** Jelaskan cara kerja fitur pada proyek.

**Hasil Perbandingan:** Jelaskan perbedaan atau kelebihan pendekatan aplikasi referensi.

**Peluang Optimasi:** Jelaskan bagian yang berpotensi ditingkatkan.

**Tujuan Optimasi:** Jelaskan manfaat yang ingin dicapai.

**Rekomendasi:** Jelaskan usulan peningkatan.

### Prioritas Menengah

Gunakan format penulisan yang sama.

### Prioritas Rendah

Gunakan format penulisan yang sama.

## 4. Referensi UI, UX, dan Layout

Kelompokkan berdasarkan fitur atau halaman yang memiliki fungsi serupa.

### Prioritas Tinggi

#### Nama Fitur atau Halaman

**Aplikasi Referensi:** Nama aplikasi dan nama store.

**Link:** Tautan langsung aplikasi atau halaman referensinya.

**Pola UI:** Jelaskan struktur dan susunan komponen yang ditemukan.

**Pola UX:** Jelaskan alur dan pengalaman penggunaan.

**Pola Layout:** Jelaskan pengaturan posisi, jarak, ukuran, dan pembagian area.

**Tujuan Desain:** Jelaskan alasan pola tersebut digunakan dan manfaatnya bagi pengguna.

**Kondisi pada Proyek:** Jelaskan kondisi halaman atau fitur yang sebanding pada proyek.

**Rekomendasi:** Jelaskan pola yang layak dipertimbangkan untuk proyek beserta alasannya.

### Prioritas Menengah

Gunakan format penulisan yang sama.

### Prioritas Rendah

Gunakan format penulisan yang sama.

## 5. Referensi Tambahan dan Keterbatasan

Cantumkan:

- Aplikasi yang tidak dapat diakses.
- Fitur yang belum dapat diverifikasi.
- Screenshot yang tidak tersedia.
- Informasi yang masih belum lengkap.

Jangan mengisi bagian ini dengan asumsi.

## 8. Aturan Kualitas Dokumen

Pastikan dokumen:

1. Terstruktur dan mudah dibaca.
2. Tidak mengulang rekomendasi yang sama.
3. Mengelompokkan temuan berdasarkan fitur serta UI, UX, dan layout.
4. Mengurutkan setiap kelompok berdasarkan prioritas tinggi, menengah, dan rendah.
5. Menyertakan tautan referensi untuk setiap temuan.
6. Menjelaskan tujuan dan manfaat setiap fitur maupun pola desain.
7. Memisahkan fitur baru dengan optimasi fitur yang sudah tersedia.
8. Menggunakan istilah teknis secara konsisten.
9. Tidak berisi rekomendasi yang hanya berupa opini tanpa alasan.
10. Tidak memasukkan rekomendasi yang tidak dapat digunakan melalui aplikasi mobile.

## 9. Aturan Pengelolaan File

Sebelum memperbarui dokumen:

1. Periksa apakah `refrensi_apk.md` sudah tersedia di root proyek.
2. Jika sudah tersedia, baca seluruh isinya.
3. Pertahankan temuan lama yang masih valid dan relevan.
4. Perbarui atau koreksi informasi yang tidak akurat apabila ditemukan bukti yang lebih baik.
5. Hindari duplikasi temuan.
6. Rapikan pengelompokan berdasarkan fitur dan UI, UX, serta layout.
7. Pastikan seluruh hasil baru dimasukkan sesuai struktur dokumen yang ditentukan.

Apabila file belum tersedia, buat file baru dengan struktur tersebut.

Jangan membuat file hasil dengan nama lain.

## 10. Batasan Perubahan Proyek

Tugas ini hanya mencakup:

- Membaca aturan dan dokumentasi proyek.
- Membaca serta memeriksa seluruh daftar aplikasi di `apk_serupa.md`.
- Melakukan riset terhadap aplikasi yang terdaftar.
- Menganalisis fitur, UI, UX, dan layout.
- Menyusun rekomendasi berdasarkan prioritas.
- Membuat atau memperbarui `refrensi_apk.md`.

Dilarang:

- Mengubah kode sumber.
- Menambahkan atau menghapus fitur.
- Mengubah UI, UX, atau layout proyek.
- Memasang dependency atau package.
- Mengubah konfigurasi proyek.
- Mengubah isi `apk_serupa.md`.
- Membuat perubahan lain di luar ruang lingkup tugas.

## 11. Laporan Akhir

Setelah selesai, berikan laporan yang mencakup:

1. Lokasi file hasil: `refrensi_apk.md`.
2. Jumlah aplikasi yang terdaftar di `apk_serupa.md`.
3. Jumlah aplikasi yang berhasil diperiksa.
4. Jumlah rekomendasi fitur baru.
5. Jumlah rekomendasi optimasi fitur.
6. Jumlah rekomendasi UI, UX, dan layout.
7. Kendala atau informasi yang belum dapat diverifikasi.

Jangan mengklaim analisis selesai apabila masih ada aplikasi terdaftar yang belum diperiksa. Laporkan dengan jelas aplikasi yang belum berhasil dianalisis.

**PENTING: Jangan menerapkan satu pun rekomendasi ke kode proyek. Seluruh rekomendasi hanya ditulis ke `refrensi_apk.md`. Pengguna akan membaca, menyortir, dan menentukan sendiri rekomendasi yang ingin diterapkan.**
