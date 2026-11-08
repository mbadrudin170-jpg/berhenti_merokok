---
description: Pindai 10 file lib yang belum terdaftar dan audit berdasarkan seluruh rules proyek
agent: code
---

# SCAN FILE PROYEK — AUDIT 10 FILE BERDASARKAN SELURUH RULES

## 1. TUJUAN UTAMA

Lakukan pemindaian terhadap maksimal **10 file di dalam direktori `lib/` yang belum terdaftar di `file_sudah_scan.md`**.

Setiap file yang dipindai wajib diperiksa berdasarkan seluruh aturan proyek yang relevan dan telah dibaca secara lengkap dari direktori `.agents/rules/`.

Apabila ditemukan ketidaksesuaian antara kode dan aturan proyek, tambahkan temuan tersebut ke `task.md` di root proyek sesuai format yang ditentukan dalam `.agents/rules/global/format_task.md`.

Setelah pemeriksaan selesai, perbarui `file_sudah_scan.md` dengan mencatat seluruh file yang berhasil dipindai.

**Tujuan utama pekerjaan ini adalah menjaga kesehatan, konsistensi, keamanan, dan kualitas proyek. Jangan mengorbankan ketelitian hanya demi menyelesaikan pekerjaan lebih cepat.**

## 2. LARANGAN DAN BATASAN WAJIB

### A. Tool yang boleh digunakan

Gunakan hanya dua tool berikut:

1. `read` — untuk membaca isi file dan melihat isi direktori.
2. `edit` — untuk memperbarui isi file yang diizinkan.

**DILARANG KERAS:**

- Menggunakan terminal atau shell.
- Menjalankan perintah `bash`.
- Menjalankan perintah sistem melalui tool apa pun.
- Menggunakan `glob`, `grep`, `write`, atau `apply_patch`.
- Menggunakan tool lain di luar `read` dan `edit`.

Jangan mencari jalan pintas dengan menggunakan tool lain ketika mengalami kesulitan.

### B. Ketentuan perubahan file

Anda hanya diizinkan mengubah dua file berikut:

- `task.md`
- `file_sudah_scan.md`

Jangan mengubah, memperbaiki, menghapus, memformat ulang, atau menulis ulang kode sumber di dalam `lib/`.

Tugas Anda hanya melakukan pemeriksaan, mencatat temuan, dan memperbarui daftar file yang telah diperiksa.

Jika salah satu file tujuan tidak ditemukan atau tidak dapat diperbarui menggunakan tool `edit`, jangan menggantinya dengan tool lain. Laporkan kendalanya.

## 3. WAJIB MEMBACA SELURUH RULES PROYEK

Sebelum melakukan audit terhadap file kode, Anda WAJIB membaca seluruh 19 file aturan berikut secara lengkap.

**Tidak boleh melewatkan satu file pun. Tidak boleh hanya membaca judul, ringkasan, atau sebagian isinya.**

### A. Rules Global

Baca seluruh file berikut:

1. `.agents/rules/global/aturan_bersama.md`
2. `.agents/rules/global/aturan_build.md`
3. `.agents/rules/global/aturan_global.md`
4. `.agents/rules/global/aturan_lainnya.md`
5. `.agents/rules/global/aturan_notifikasi.md`
6. `.agents/rules/global/aturan_pemanfaatan_sdk_dan_paket.md`
7. `.agents/rules/global/aturan_riverpod.md`
8. `.agents/rules/global/aturan_testing.md`
9. `.agents/rules/global/format_task.md`
10. `.agents/rules/global/model_agent.md`
11. `.agents/rules/global/optimasi_boilerplate.md`
12. `.agents/rules/global/optimasi_bug_runtime.md`
13. `.agents/rules/global/optimasi_keamanan.md`
14. `.agents/rules/global/optimasi_performa.md`
15. `.agents/rules/global/optimasi_ui.md`
16. `.agents/rules/global/optimasi_ux.md`
17. `.agents/rules/global/setup_prettier.md`

### B. Rules Proyek

Baca kedua file berikut:

18. `.agents/rules/proyek/aturan_khusus.md`
19. `.agents/rules/proyek/aturan_proyek.md`

### Ketentuan membaca rules

- Baca setiap file sampai seluruh isinya berhasil diperoleh.
- Jika isi file terpotong, lanjutkan membaca bagian berikutnya sampai selesai.
- Jangan menganggap file sudah dibaca apabila hanya sebagian isinya yang berhasil diperoleh.
- Jangan mengganti isi aturan dengan pengetahuan dari AI atau asumsi pribadi.
- Jangan melewatkan aturan yang terlihat tidak berkaitan dengan file yang sedang diperiksa. Seluruh aturan tetap wajib dibaca, kemudian terapkan aturan yang relevan sesuai konteks masing-masing file.
- Gunakan isi aktual dari file rules sebagai sumber utama penilaian.
- Pastikan Anda memahami maksud, batasan, dan kewajiban dari setiap aturan sebelum melakukan audit.

**PENTING:** Jika ada satu saja file rules yang tidak ditemukan, tidak dapat diakses, atau tidak berhasil dibaca secara lengkap, jangan mengklaim bahwa seluruh rules telah dibaca. Hentikan proses audit kode dan laporkan file yang bermasalah beserta alasannya.

### Pemeriksaan konflik antar-rules

Apabila menemukan aturan yang saling bertentangan:

1. Identifikasi kedua aturan yang bertentangan.
2. Catat lokasi file dan bagian aturan yang menjadi sumber konflik.
3. Jangan mengabaikan salah satu aturan secara diam-diam.
4. Jangan membuat interpretasi sendiri tanpa dasar yang jelas.
5. Jangan menyatakan suatu kode melanggar aturan apabila penilaiannya bergantung pada konflik yang belum terselesaikan.
6. Laporkan konflik tersebut dalam hasil akhir.

## 4. ALUR KERJA PEMINDAIAN

Lakukan seluruh tahapan berikut secara berurutan.

### LANGKAH 1 — INVENTARISASI SELURUH DIREKTORI `lib/`

Tujuan: mendapatkan daftar lengkap seluruh file dan subdirektori di dalam `lib/`.

Permintaan inventarisasi yang harus dipenuhi:

`ls -R lib/`

Namun, karena penggunaan terminal dilarang, **jangan menjalankan perintah tersebut**.

Gunakan tool `read` untuk mendapatkan hasil inventarisasi yang setara:

1. Baca direktori `lib/`.
2. Identifikasi seluruh file dan subdirektori yang ditemukan.
3. Baca setiap subdirektori menggunakan tool `read` secara rekursif.
4. Lanjutkan sampai seluruh tingkat direktori selesai diperiksa.
5. Susun daftar seluruh file dengan path relatif terhadap root proyek.

Jangan hanya memeriksa direktori utama `lib/`. Seluruh subdirektori di dalamnya juga wajib diperiksa.

Jika tool `read` tidak mampu menampilkan isi direktori atau terdapat bagian direktori yang tidak dapat diakses, jangan menggantinya dengan terminal, `glob`, atau tool lain. Laporkan kendalanya dan jangan mengklaim inventarisasi sudah lengkap.

### LANGKAH 2 — BACA `file_sudah_scan.md`

Baca seluruh isi file berikut:

`file_sudah_scan.md`

File tersebut berada di root proyek.

Periksa seluruh daftar file yang sudah tercatat.

Jangan mengubah isinya pada tahap ini.

### LANGKAH 3 — COCOKKAN DAFTAR FILE

Bandingkan dua sumber berikut:

- Hasil inventarisasi lengkap direktori `lib/`.
- Daftar file yang sudah tercatat di `file_sudah_scan.md`.

Identifikasi file yang belum pernah dipindai.

Ketentuan pencocokan:

1. Gunakan path file secara lengkap dan relatif terhadap root proyek.
2. Pertahankan struktur direktori, misalnya `lib/fitur/contoh.dart`.
3. Jangan hanya mencocokkan nama file tanpa memperhatikan lokasi direktori.
4. Jangan menghitung direktori sebagai file.
5. Jangan menghitung file yang sudah terdaftar sebagai file yang belum dipindai.
6. Abaikan duplikasi pencatatan saat menentukan jumlah file yang sudah dipindai.
7. Jika terdapat catatan file yang sudah tidak ditemukan dalam inventarisasi, jangan menghapusnya secara otomatis. Laporkan sebagai catatan yang perlu diperiksa.

### LANGKAH 4 — TENTUKAN 10 FILE YANG AKAN DIPINDAI

Dari daftar file yang belum terdaftar, tentukan maksimal 10 file untuk dipindai pada sesi ini.

Ketentuan:

1. Pilih file berdasarkan urutan path secara alfabetis agar pemilihan konsisten.
2. Ambil maksimal 10 file pertama dari daftar file yang belum dipindai.
3. Jangan memilih file yang sudah terdaftar di `file_sudah_scan.md`.
4. Jangan memindai file tambahan di luar 10 file yang sudah dipilih.
5. Jangan memulai ulang pemindaian file yang sudah selesai dipindai pada sesi sebelumnya.

Jika jumlah file yang belum dipindai kurang dari 10, pindai seluruh file yang tersedia.

Jika tidak ada file yang tersisa, jangan melakukan pemindaian ulang. Laporkan bahwa seluruh file yang ditemukan sudah tercatat.

### LANGKAH 5 — AUDIT 10 FILE BERDASARKAN SELURUH RULES

Sebelum memulai, pastikan seluruh 19 file rules telah berhasil dibaca secara lengkap.

Kemudian periksa setiap file yang telah dipilih.

Untuk setiap file:

1. Baca seluruh isi file menggunakan tool `read`.
2. Jika isi file terlalu panjang dan hasil pembacaan terpotong, lanjutkan membaca bagian berikutnya sampai seluruh isi diperoleh.
3. Pahami fungsi dan tanggung jawab file berdasarkan kode aktual.
4. Cocokkan implementasinya dengan seluruh aturan proyek yang relevan.
5. Periksa apakah terdapat pelanggaran, ketidaksesuaian, atau implementasi yang bertentangan dengan aturan.
6. Catat lokasi kode yang menjadi bukti temuan.
7. Pastikan setiap temuan benar-benar didukung oleh isi kode dan aturan yang telah dibaca.

**Jangan melakukan audit berdasarkan asumsi.**

Ketentuan penilaian:

- Jangan menganggap suatu implementasi salah hanya karena Anda memiliki preferensi teknis yang berbeda.
- Jangan menambahkan standar baru yang tidak tercantum dalam rules proyek.
- Jangan memaksakan aturan yang tidak relevan terhadap tanggung jawab file.
- Jangan melewatkan aturan yang relevan hanya karena pemeriksaan menjadi lebih panjang.
- Jangan menganggap pola implementasi sudah sesuai hanya karena terlihat umum digunakan.
- Periksa konteks kode sebelum menyimpulkan adanya pelanggaran.
- Jangan menganggap satu temuan yang sama sebagai beberapa masalah berbeda tanpa alasan teknis.

**Utamakan ketepatan hasil audit daripada kecepatan pemindaian.**

### LANGKAH 6 — TAMBAHKAN TEMUAN KE `task.md`

Apabila menemukan ketidaksesuaian antara kode dan rules, tambahkan temuan tersebut ke:

`task.md`

File berada di root proyek.

Sebelum melakukan perubahan:

1. Baca seluruh isi `task.md`.
2. Baca kembali `.agents/rules/global/format_task.md` apabila diperlukan untuk memastikan format pencatatan.
3. Pahami struktur, kategori, dan format task yang sudah digunakan.
4. Gunakan tool `edit` untuk menambahkan temuan pada bagian yang benar.

Setiap temuan harus memiliki informasi yang cukup untuk ditindaklanjuti, sesuai format task proyek.

Minimal, informasi temuan harus menjelaskan:

- File yang bermasalah beserta path lengkapnya.
- Lokasi kode yang menjadi bukti, apabila tersedia.
- Aturan yang dilanggar beserta path file rules-nya.
- Kondisi implementasi saat ini.
- Ketidaksesuaian terhadap aturan.
- Perbaikan yang diperlukan.

Ketentuan:

- Gunakan format yang sudah ditentukan oleh `format_task.md`.
- Jangan membuat format task baru.
- Jangan menghapus atau menulis ulang task yang sudah ada.
- Jangan menambahkan task duplikat.
- Jangan menambahkan temuan yang belum memiliki bukti.
- Jangan memasukkan rekomendasi pribadi yang tidak diwajibkan oleh rules.
- Jangan memperbaiki kode secara langsung.

Jika tidak ditemukan pelanggaran pada file yang diperiksa, jangan membuat task baru untuk file tersebut.

### LANGKAH 7 — PERBARUI `file_sudah_scan.md`

Setelah seluruh file yang dipilih selesai dibaca dan diaudit, perbarui:

`file_sudah_scan.md`

Gunakan tool `edit` untuk menambahkan path seluruh file yang berhasil dipindai.

Ketentuan:

1. Pertahankan seluruh isi lama.
2. Jangan menghapus daftar yang sudah ada.
3. Jangan menulis ulang seluruh file tanpa alasan.
4. Jangan memasukkan path yang sudah tercatat.
5. Gunakan format pencatatan yang sudah digunakan file tersebut.
6. Catat path relatif terhadap root proyek secara konsisten.
7. Hanya tambahkan file yang benar-benar sudah selesai dibaca dan diaudit.
8. Jangan mencatat file yang hanya berhasil dibaca sebagian.
9. Jangan mencatat file yang gagal diperiksa.
10. Pastikan jumlah file yang ditambahkan tidak melebihi 10.

**Jangan memperbarui daftar sebelum pemeriksaan seluruh file yang dipilih selesai dilakukan.**

Jika terjadi kegagalan ketika membaca suatu file, jangan mencatat file tersebut sebagai file yang sudah dipindai.

## 5. PEMERIKSAAN AKHIR

Sebelum menyelesaikan pekerjaan, verifikasi kembali seluruh hasil.

Pastikan:

- [ ] Seluruh direktori `lib/` sudah diinventarisasi secara rekursif.
- [ ] `file_sudah_scan.md` sudah dibaca secara lengkap.
- [ ] Daftar file sudah dicocokkan dengan benar.
- [ ] Maksimal 10 file belum dipindai sudah dipilih.
- [ ] Seluruh 19 file rules sudah dibaca secara lengkap.
- [ ] Setiap file terpilih sudah dibaca secara lengkap.
- [ ] Setiap file terpilih sudah diperiksa berdasarkan aturan yang relevan.
- [ ] Seluruh temuan yang terbukti sudah dicatat ke `task.md`.
- [ ] Tidak ada task duplikat yang ditambahkan.
- [ ] `file_sudah_scan.md` sudah diperbarui dengan file yang benar-benar selesai dipindai.
- [ ] Tidak ada kode sumber yang diubah.
- [ ] Tidak ada terminal atau tool selain `read` dan `edit` yang digunakan.

Jika salah satu pemeriksaan akhir gagal, jelaskan kegagalannya. Jangan mengklaim pekerjaan selesai seluruhnya.

## 6. FORMAT LAPORAN HASIL AKHIR

Setelah menyelesaikan pekerjaan, berikan laporan dengan struktur berikut:

### A. Status Pemindaian

- Status inventarisasi direktori `lib/`.
- Jumlah file yang ditemukan.
- Jumlah file yang sebelumnya sudah tercatat.
- Jumlah file yang belum tercatat.
- Jumlah file yang berhasil dipindai pada sesi ini.

### B. Daftar File yang Dipindai

Tuliskan seluruh path file yang berhasil dipindai.

### C. Hasil Audit

Untuk setiap temuan, jelaskan:

- Path file.
- Lokasi kode.
- Rules yang tidak dipatuhi.
- Penjelasan ketidaksesuaian.
- Status pencatatan ke `task.md`.

Jika tidak ada temuan, nyatakan dengan jelas bahwa tidak ditemukan pelanggaran yang terbukti pada file yang diperiksa.

### D. Hasil Pembaruan File

Laporkan perubahan pada:

- `task.md`
- `file_sudah_scan.md`

Jika tidak ada temuan, nyatakan bahwa `task.md` tidak perlu diperbarui.

### E. Kendala dan Konflik

Laporkan apabila ditemukan:

- Rules yang tidak dapat dibaca.
- File yang tidak dapat diakses.
- Isi file yang terpotong dan tidak berhasil dilanjutkan.
- Konflik antar-rules.
- File lama dalam `file_sudah_scan.md` yang tidak ditemukan.
- Kegagalan memperbarui file.

Jangan menyembunyikan kendala atau memberikan klaim keberhasilan yang tidak sesuai dengan hasil aktual.

---

## 7. INSTRUKSI PENUTUP

Ingat bahwa pekerjaan ini berkaitan dengan kesehatan dan keberlangsungan proyek.

**Jangan menganggap tugas selesai hanya karena sudah membaca 10 file.**

Tugas baru dianggap selesai apabila seluruh tahapan yang dapat dilaksanakan telah dikerjakan dengan benar, seluruh rules sudah dibaca secara lengkap, audit sudah dilakukan, temuan sudah dicatat, dan daftar file sudah diperbarui.

Utamakan ketelitian, kepatuhan terhadap aturan, dan keakuratan pencatatan.

Jangan mengambil inisiatif untuk mengubah kode sumber atau memperluas ruang lingkup pekerjaan.

**Batas pemindaian tetap maksimal 10 file `lib/` per pemanggilan command.**
