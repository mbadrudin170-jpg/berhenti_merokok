---
description: Evaluasi cakupan aturan global dan proyek, identifikasi aturan yang salah penempatan dan konflik, lalu perbarui saran_pindah_rules.md.
---

# MODE: EVALUASI ATURAN GLOBAL DAN PROYEK

## A. Tujuan Command

Command ini bertujuan mengevaluasi seluruh aturan yang terdapat di:

1. `.agents/rules/global/`
2. `.agents/rules/proyek/`

Lakukan evaluasi untuk menemukan:

1. Aturan yang seharusnya berada di folder global, tetapi saat ini berada di folder proyek.
2. Aturan yang seharusnya berada di folder proyek, tetapi saat ini berada di folder global.
3. Aturan yang memiliki cakupan campuran sehingga sebagian isinya perlu dipisahkan.
4. Aturan yang saling bertentangan, baik di dalam satu file maupun antarfile.
5. Aturan yang memiliki makna duplikat atau tumpang tindih sehingga berpotensi menyebabkan kebingungan AI.

Setelah evaluasi selesai, perbarui file `saran_pindah_rules.md` di root proyek berdasarkan temuan terbaru.

**PENTING:** Command ini hanya bertugas mengevaluasi dan memberikan rekomendasi. Dilarang memindahkan, menghapus, atau mengubah isi file aturan yang berada di `.agents/rules/global/` maupun `.agents/rules/proyek/`.

## B. Ketentuan Penggunaan Tool

### 1. Membaca File

- Gunakan tool `read` untuk membaca isi seluruh file aturan.
- Jangan menggunakan `cat`, `sed`, `awk`, `grep`, `find`, atau perintah terminal lainnya untuk membaca maupun mengolah isi file.
- Dilarang menggunakan `bash` atau terminal untuk menggantikan fungsi pembacaan file.
- Apabila tool `glob` diperlukan untuk mengetahui daftar file dan path, gunakan hanya untuk menemukan lokasi file, bukan untuk membaca isinya.
- Setelah mendapatkan daftar file, baca isi setiap file menggunakan tool `read`.
- Jangan hanya membaca sebagian file. Baca seluruh isi file agar tidak ada aturan yang terlewat.
- Jika file terlalu panjang untuk dibaca sekaligus, lanjutkan pembacaan sampai seluruh isinya berhasil diperiksa.

### 2. Memperbarui Laporan

- Gunakan tool `edit` atau `write` untuk memperbarui `saran_pindah_rules.md`.
- Jangan menggunakan `cat` atau `sed` melalui terminal untuk membuat maupun memperbarui laporan.
- Sebelum memperbarui laporan, wajib membaca seluruh isi `saran_pindah_rules.md` yang lama menggunakan tool `read`.
- Jangan mengubah atau menghapus file aturan sumber.

## C. Tahapan Evaluasi

### Tahap 1 — Inventarisasi File Aturan

1. Periksa seluruh file aturan di `.agents/rules/global/`.
2. Periksa seluruh file aturan di `.agents/rules/proyek/`.
3. Sertakan file yang berada di dalam subfolder.
4. Catat path setiap file yang ditemukan.
5. Pastikan semua file aturan sudah dibaca menggunakan tool `read`.
6. Jangan membuat kesimpulan sebelum seluruh file yang relevan selesai diperiksa.

Jika terdapat file yang tidak dapat dibaca, catat path dan kendalanya. Jangan menganggap file tersebut sudah dievaluasi.

### Tahap 2 — Evaluasi Cakupan Aturan

Evaluasi setiap aturan berdasarkan tujuan, cakupan, dan tempat penerapannya.

Gunakan kriteria berikut.

**A. Aturan Global**

Aturan layak berada di `.agents/rules/global/` apabila:

- Berlaku untuk seluruh proyek atau sebagian besar proyek yang dikelola.
- Memuat standar, prinsip, kebiasaan kerja, atau ketentuan yang memang ingin diterapkan secara konsisten lintas proyek.
- Tidak bergantung pada struktur folder, nama modul, fitur, maupun kebutuhan khusus satu proyek.
- Tetap relevan ketika berpindah dari satu proyek ke proyek lainnya.

Aturan yang menggunakan teknologi atau framework tertentu tetap dapat dikategorikan sebagai global apabila teknologi tersebut memang menjadi standar bersama pada seluruh proyek yang relevan.

**B. Aturan Proyek**

Aturan layak berada di `.agents/rules/proyek/` apabila:

- Hanya berlaku pada satu proyek tertentu.
- Bergantung pada struktur folder, arsitektur, atau implementasi khusus proyek.
- Mengatur fitur, proses bisnis, atau kebutuhan khusus aplikasi.
- Mengatur penggunaan paket, dependency, maupun konfigurasi yang hanya berlaku pada proyek tersebut.
- Memiliki pengecualian atau keputusan teknis yang tidak berlaku pada proyek lainnya.

**C. Aturan dengan Cakupan Campuran**

Apabila satu file atau satu kelompok aturan memiliki ketentuan global sekaligus ketentuan khusus proyek:

1. Jangan langsung merekomendasikan pemindahan seluruh file.
2. Identifikasi aturan atau bagian yang memiliki cakupan global.
3. Identifikasi aturan atau bagian yang hanya berlaku pada proyek.
4. Rekomendasikan pemisahan bagian tersebut apabila memang diperlukan.
5. Berikan rekomendasi file tujuan untuk masing-masing bagian.
6. Pastikan pemisahan tidak mengubah maksud, menghilangkan ketentuan, atau menimbulkan aturan yang saling bertentangan.

### Tahap 3 — Menemukan Aturan yang Salah Penempatan

Cari aturan yang tidak sesuai dengan cakupan folder tempat aturan tersebut berada.

Untuk setiap temuan, wajib menentukan:

1. Apa inti aturan tersebut?
2. Aturan tersebut berasal dari file mana?
3. Bagian atau judul aturan yang dimaksud?
4. Mengapa aturan tersebut tidak sesuai dengan cakupan folder saat ini?
5. Sebaiknya dipindahkan dari global ke proyek atau dari proyek ke global?
6. File mana yang paling sesuai untuk menjadi tujuan pemindahan?
7. Mengapa file tujuan tersebut merupakan tempat yang paling tepat?

**Ketentuan penentuan file tujuan:**

- Utamakan file aturan yang sudah tersedia dan memiliki topik yang sesuai.
- Jangan merekomendasikan file tujuan hanya karena namanya terlihat cocok. Periksa isi file tersebut terlebih dahulu.
- Jika tidak ada file tujuan yang sesuai, rekomendasikan pembuatan file baru dan berikan path serta nama file yang disarankan.
- Jangan merekomendasikan pemindahan apabila manfaatnya tidak jelas.
- Jangan memaksakan pemindahan aturan yang sebenarnya sudah berada di lokasi yang benar.

### Tahap 4 — Menemukan Aturan yang Bertentangan

Periksa kemungkinan konflik pada seluruh aturan, termasuk:

1. Konflik antaraturan dalam satu file.
2. Konflik antarfile di folder global.
3. Konflik antarfile di folder proyek.
4. Konflik antara aturan global dan aturan proyek.
5. Konflik antara aturan utama dan aturan pengecualian.

Identifikasi jenis konflik berikut:

**A. Konflik Langsung**

Dua aturan memberikan instruksi yang saling bertentangan untuk kondisi yang sama.

**B. Konflik Cakupan**

Dua aturan mengatur hal yang sama, tetapi memiliki batas penerapan yang tidak jelas atau saling bertentangan.

**C. Konflik Prioritas**

Terdapat dua instruksi yang dapat menghasilkan tindakan berbeda, tetapi tidak ada ketentuan yang menjelaskan instruksi mana yang harus diutamakan.

**D. Konflik Redaksi**

Aturan menggunakan istilah atau kalimat yang berbeda sehingga berpotensi ditafsirkan secara berbeda oleh AI, meskipun tujuan awalnya mungkin sama.

**E. Aturan Duplikat atau Tumpang Tindih**

Beberapa aturan mengatur hal yang sama, baik dengan redaksi identik maupun berbeda.

Ketentuan:

- Jangan langsung menganggap dua aturan bertentangan hanya karena membahas topik yang sama.
- Periksa kondisi, konteks, tujuan, dan batas penerapan masing-masing aturan.
- Aturan yang berbeda tetapi mengatur situasi yang berbeda tidak otomatis menjadi konflik.
- Bedakan konflik nyata dengan sekadar duplikasi atau tumpang tindih.
- Untuk setiap konflik, tunjukkan kedua aturan yang terlibat beserta lokasi file masing-masing.
- Jelaskan bagian yang bertentangan dan kemungkinan dampaknya terhadap keputusan AI.
- Berikan rekomendasi penyelesaian tanpa mengubah file aturan sumber.
- Jangan menentukan sendiri aturan mana yang harus dihapus atau diutamakan apabila maksud pemilik aturan belum dapat dipastikan.

### Tahap 5 — Memeriksa Rekomendasi Lama

Baca seluruh isi `saran_pindah_rules.md` yang berada di root proyek sebelum memperbaruinya.

Bandingkan setiap rekomendasi lama dengan seluruh aturan yang saat ini masih tersedia di folder global dan proyek.

Gunakan ketentuan berikut:

**A. Rekomendasi yang Masih Valid**

- Jika aturan yang menjadi dasar rekomendasi masih ada, jangan menghapus rekomendasi tersebut.
- Pertahankan informasi rekomendasi yang masih relevan.
- Periksa kembali apakah arah dan tujuan pemindahannya masih tepat.
- Jika ditemukan perubahan redaksi tetapi maksud aturan masih sama, sesuaikan deskripsi rekomendasinya dengan kondisi terbaru.
- Jika rekomendasi sudah dilaksanakan, pertahankan catatannya dan ubah status menjadi sudah sesuai tujuan.

**B. Rekomendasi yang Sudah Tidak Valid**

- Jika aturan yang menjadi dasar rekomendasi sudah tidak ditemukan lagi pada seluruh file aturan yang diperiksa, hapus rekomendasi tersebut.
- Jangan mempertahankan rekomendasi yang hanya mengacu pada aturan yang sudah tidak ada.
- Jika aturan hanya sebagian yang dihapus, pertahankan rekomendasi untuk bagian yang masih ada dan sesuaikan isinya.

**C. Rekomendasi yang Berubah Kondisi**

- Jika aturan masih ada tetapi rekomendasi pemindahannya tidak lagi tepat, jangan langsung menghapusnya.
- Perbarui rekomendasi dan jelaskan perubahan alasannya.
- Jika aturan sudah berada di lokasi tujuan, pertahankan rekomendasi lama dengan status sudah sesuai tujuan.
- Jangan menghapus catatan lama yang masih memiliki dasar berupa aturan yang benar-benar ada.

**D. Pencegahan Duplikasi**

- Jangan menambahkan rekomendasi baru apabila rekomendasi yang sama sudah tersedia.
- Jika rekomendasi lama sudah mewakili temuan terbaru, perbarui isinya daripada membuat entri baru.
- Setiap rekomendasi harus memiliki identitas yang jelas agar mudah dilacak.

### Tahap 6 — Memperbarui saran_pindah_rules.md

Setelah seluruh evaluasi dan pemeriksaan rekomendasi lama selesai:

1. Gabungkan rekomendasi lama yang masih valid dengan temuan baru.
2. Hapus hanya rekomendasi yang aturan sumbernya sudah tidak ditemukan.
3. Perbarui rekomendasi yang mengalami perubahan kondisi.
4. Tambahkan temuan baru yang memang layak direkomendasikan.
5. Masukkan temuan konflik pada bagian khusus.
6. Hilangkan duplikasi rekomendasi.
7. Gunakan format laporan yang telah ditetapkan pada bagian D.
8. Pastikan seluruh path file ditulis secara lengkap dan benar.

Jangan memindahkan atau mengedit file aturan sumber. Seluruh hasil evaluasi hanya dicatat dalam `saran_pindah_rules.md`.

## D. Format Wajib saran_pindah_rules.md

Gunakan struktur berikut secara konsisten.

# Saran Pemindahan Rules

## 1. Ringkasan Evaluasi

- Tanggal evaluasi:
- Folder global yang diperiksa:
- Folder proyek yang diperiksa:
- Jumlah file global:
- Jumlah file proyek:
- Jumlah rekomendasi pemindahan:
- Jumlah konflik yang ditemukan:
- Jumlah aturan duplikat atau tumpang tindih:

## 2. Rekomendasi Pemindahan Aturan

Setiap rekomendasi wajib menggunakan format berikut:

### Rekomendasi [Nomor] — [Nama atau Inti Aturan]

- **Aturan asal:** [Path lengkap file asal]
- **Bagian aturan:** [Judul bagian atau nomor aturan]
- **Lokasi saat ini:** Global / Proyek
- **Rekomendasi:** Global → Proyek / Proyek → Global
- **File tujuan:** [Path lengkap file tujuan]
- **Inti aturan:** [Ringkasan aturan yang akan dipindahkan]
- **Alasan pemindahan:** [Penjelasan mengapa aturan tersebut lebih tepat berada di lokasi tujuan]
- **Status:** Belum dipindahkan / Sudah sesuai tujuan / Perlu evaluasi ulang.

## 3. Rekomendasi Pemisahan Aturan

Gunakan bagian ini apabila ditemukan aturan yang memiliki cakupan campuran.

### Pemisahan [Nomor] — [Nama Aturan]

- **File asal:** [Path lengkap]
- **Bagian yang dipertahankan:** [Bagian aturan dan lokasi yang disarankan]
- **Bagian yang direkomendasikan dipisahkan:** [Bagian aturan]
- **File tujuan:** [Path lengkap]
- **Alasan:** [Penjelasan pemisahan]
- **Status:** Rekomendasi pemisahan.

## 4. Aturan yang Bertentangan

Gunakan format berikut untuk setiap konflik.

### Konflik [Nomor] — [Judul Konflik]

- **File aturan A:** [Path lengkap]
- **Bagian aturan A:** [Judul atau nomor aturan]
- **Isi atau inti aturan A:** [Ringkasan]

- **File aturan B:** [Path lengkap]
- **Bagian aturan B:** [Judul atau nomor aturan]
- **Isi atau inti aturan B:** [Ringkasan]

- **Jenis konflik:** Langsung / Cakupan / Prioritas / Redaksi.
- **Tingkat dampak:** Tinggi / Sedang / Rendah.
- **Alasan konflik:** [Penjelasan bagian yang saling bertentangan]
- **Dampak terhadap AI:** [Kemungkinan kesalahan interpretasi atau tindakan AI]
- **Rekomendasi penyelesaian:** [Saran untuk mengatasi konflik tanpa mengubah aturan sumber]

## 5. Aturan Duplikat atau Tumpang Tindih

### Duplikasi [Nomor] — [Judul]

- **File aturan A:** [Path lengkap]
- **File aturan B:** [Path lengkap]
- **Kesamaan:** [Jelaskan bagian yang memiliki makna sama]
- **Perbedaan:** [Jelaskan apabila terdapat perbedaan redaksi atau konteks]
- **Rekomendasi:** [Pertahankan, gabungkan, atau perjelas]
- **Alasan:** [Penjelasan]

## 6. Catatan Evaluasi

Tuliskan hal-hal penting yang perlu diperhatikan, termasuk:

- File yang tidak dapat dibaca.
- Aturan yang cakupannya belum dapat dipastikan.
- Rekomendasi yang membutuhkan keputusan pemilik aturan.
- Kondisi khusus yang memengaruhi hasil evaluasi.

Apabila suatu bagian tidak memiliki temuan, tuliskan secara eksplisit bahwa tidak ditemukan temuan pada bagian tersebut.

## E. Ketentuan Akhir

Sebelum menyelesaikan command:

1. Pastikan seluruh file aturan di kedua folder sudah diperiksa.
2. Pastikan evaluasi mencakup seluruh aturan, bukan hanya judul file.
3. Pastikan setiap rekomendasi mencantumkan path file asal dan path file tujuan.
4. Pastikan rekomendasi lama yang masih memiliki dasar aturan tidak terhapus.
5. Pastikan rekomendasi yang sudah tidak memiliki aturan sumber telah dihapus.
6. Pastikan tidak ada rekomendasi duplikat.
7. Pastikan konflik mencantumkan kedua lokasi aturan yang terlibat.
8. Pastikan tidak ada file aturan sumber yang diubah, dipindahkan, atau dihapus.
9. Pastikan `saran_pindah_rules.md` sudah menggunakan format yang ditetapkan.
10. Gunakan tool `read` untuk membaca kembali `saran_pindah_rules.md` setelah pembaruan dan verifikasi hasil akhirnya.

Apabila seluruh tahapan berhasil diselesaikan, sampaikan laporan singkat kepada pengguna yang mencakup:

- Jumlah file aturan yang berhasil dievaluasi.
- Jumlah rekomendasi pemindahan baru.
- Jumlah rekomendasi lama yang dipertahankan.
- Jumlah rekomendasi yang dihapus karena aturan sumber sudah tidak ada.
- Jumlah aturan yang memiliki konflik.
- Jumlah aturan yang duplikat atau tumpang tindih.
- Path file laporan yang berhasil diperbarui.

Jangan mengklaim evaluasi selesai apabila masih ada file aturan yang belum diperiksa atau laporan belum berhasil diperbarui.
