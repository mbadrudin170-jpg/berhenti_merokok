# EKSEKUSI TASK — STRICT TASK EXECUTION

## 1. Tujuan

Jalankan maksimal 5 task dari `task.md` di root repositori berdasarkan status yang secara eksplisit mengizinkan implementasi.

Kerjakan setiap task secara terpisah, terukur, dan dapat diverifikasi.

Prioritas utama:

1. Jangan berasumsi liar.
2. Jangan mengerjakan task yang tidak diizinkan.
3. Jangan mengubah kode di luar ruang lingkup task.
4. Lindungi file sebelum melakukan perubahan menggunakan backup.
5. Pastikan setiap task memiliki hasil yang jelas.
6. Perbarui status task segera setelah satu task selesai atau dilewati.

## 2. Persiapan Wajib

Sebelum mengerjakan apa pun:

1. Baca seluruh isi `.agents/rules/AGENTS.md`.
2. Patuhi seluruh instruksi di dalamnya.
3. Baca aturan global dan aturan proyek yang relevan.
4. Baca seluruh isi `task.md` pada root repositori.
5. Pahami struktur pengelompokan, prioritas, status, dan file yang terdampak.
6. Periksa apakah terdapat perubahan kode atau perubahan file dari pekerjaan sebelumnya yang belum disimpan atau belum dikomit.
7. Jangan menimpa perubahan yang sudah ada.
8. Catat kondisi awal hasil `flutter analyze` sebelum mengubah kode.

Apabila file `.agents/rules/AGENTS.md` tidak ditemukan, hentikan eksekusi dan laporkan kepada pengguna. Jangan menggantinya dengan asumsi atau mencari aturan pengganti tanpa persetujuan.

## 3. Seleksi Task — Aturan Paling Ketat

**HANYA TASK DENGAN STATUS `Implementasikan` YANG BOLEH DIPROSES.**

Ketentuan wajib:

1. Status harus sama persis dengan `Implementasikan`.
2. Status `Belum`, `Kerjakan`, `Setengah`, `Selesai`, dan `Dilewati` tidak boleh dikerjakan.
3. Jangan menganggap status `Kerjakan` sama dengan `Implementasikan`.
4. Jangan menganggap status kosong sebagai izin implementasi.
5. Jangan memilih task hanya berdasarkan prioritas Tinggi, Sedang, atau Rendah.
6. Prioritas hanya digunakan untuk menentukan urutan task yang memang berstatus `Implementasikan`.
7. Jangan mengubah status task dari `Kerjakan`, `Belum`, atau status lainnya menjadi `Implementasikan` atas inisiatif sendiri.
8. Jangan mengubah status hanya untuk membuat task memenuhi syarat pengerjaan.
9. Apabila tidak ada task berstatus `Implementasikan`, hentikan pekerjaan dan laporkan bahwa tidak ada task yang memenuhi syarat.

### Urutan Seleksi

Pilih maksimal 5 task berdasarkan urutan berikut:

1. Prioritas Tinggi.
2. Prioritas Sedang.
3. Prioritas Rendah.

Dalam prioritas yang sama, ikuti urutan kemunculan task dalam `task.md`.

Jangan melewati task yang memenuhi syarat hanya karena task tersebut dianggap sulit.

## 4. Batas Pengerjaan

1. Maksimal 5 task yang diperiksa dalam satu sesi.
2. Setiap task yang diperiksa dihitung sebagai satu dari lima task.
3. Task yang ternyata sudah diimplementasikan tetap dihitung.
4. Task yang dilewati tetap dihitung.
5. Task yang gagal diperbaiki dan di-rollback tetap dihitung.
6. Jangan mengganti task yang dilewati dengan task keenam.
7. Setelah mencapai 5 task, hentikan seluruh pekerjaan.
8. Tunggu perintah pengguna sebelum melanjutkan 5 task berikutnya.

### Contoh Penghitungan

| Task   | Hasil                                          | Hitungan |
| ------ | ---------------------------------------------- | -------- |
| Task 1 | Ternyata sudah diimplementasikan               | 1/5      |
| Task 2 | Dilewati karena file terbuka                   | 2/5      |
| Task 3 | Dilewati karena lint error tidak terselesaikan | 3/5      |
| Task 4 | Berhasil diimplementasikan                     | 4/5      |
| Task 5 | Berhasil diimplementasikan                     | 5/5      |

Setelah 5/5, wajib berhenti.

## 5. Pemeriksaan Setiap Task Sebelum Implementasi

Sebelum mengubah file:

1. Baca kembali deskripsi task secara lengkap.
2. Periksa seluruh file yang tercantum pada bagian `File Bermasalah`.
3. Periksa aturan yang tercantum pada bagian `Aturan Dilanggar`.
4. Baca kode aktual, jangan hanya mengandalkan deskripsi task.
5. Pastikan masalah masih benar-benar terjadi.
6. Pastikan solusi yang direkomendasikan sesuai dengan kondisi kode aktual.
7. Pastikan perubahan tidak bertentangan dengan aturan repositori.
8. Pastikan tidak ada task lain yang sedang dikerjakan pada file yang sama.
9. Periksa apakah file yang akan diedit sedang terbuka di editor.

Apabila ditemukan ketidaksesuaian antara deskripsi task dan kode aktual, jangan memaksakan implementasi. Laporkan temuannya dan tandai task sebagai `Dilewati` jika memang tidak dapat dilanjutkan dengan aman.

## 6. Larangan Mengedit File yang Sedang Terbuka

1. Jangan mengedit file yang sedang terbuka di editor.
2. Apabila file yang akan diedit sedang terbuka, hentikan pengerjaan task tersebut.
3. Perbarui status task menjadi `Dilewati`.
4. Jelaskan nama file dan alasan task dilewati.
5. Jangan mencoba mengatasi larangan ini dengan mengedit file melalui metode lain.
6. Lanjutkan ke task berikutnya yang memenuhi syarat.

Apabila status file terbuka tidak dapat diketahui melalui lingkungan editor atau integrasi yang tersedia, jangan mengklaim bahwa file aman untuk diedit. Laporkan keterbatasan tersebut dan minta konfirmasi pengguna.

## 7. Backup Wajib Sebelum Mengedit

**Setiap file wajib memiliki backup sebelum perubahan pertama dilakukan.**

Lokasi backup:

`.backup task/`

Ketentuan:

1. Buat backup sebelum mengedit file.
2. Gunakan ekstensi `.bak`.
3. Pertahankan struktur direktori asli agar tidak terjadi benturan nama.
4. Jangan menimpa backup sebelumnya.
5. Backup harus berisi kondisi file sebelum perubahan.
6. Pastikan backup berhasil dibuat dan dapat dibaca sebelum melanjutkan.
7. Backup juga wajib dibuat untuk `task.md` sebelum memperbarui status task.

Contoh:

File asli:

`lib/fitur/home/app.dart`

File backup:

`.backup task/lib/fitur/home/app.dart.bak`

File asli:

`task.md`

File backup:

`.backup task/task.md.bak`

Apabila backup gagal dibuat, jangan mengedit file tersebut. Hentikan task dan laporkan kendalanya.

## 8. Ketentuan Implementasi

1. Kerjakan hanya masalah yang dijelaskan dalam task.
2. Jangan melakukan refactoring yang tidak diperlukan.
3. Jangan menambahkan fitur yang tidak diminta.
4. Jangan mengubah file yang tidak berhubungan dengan penyelesaian task.
5. Jangan mengubah logika bisnis di luar kebutuhan perbaikan.
6. Patuhi seluruh aturan global dan aturan proyek.
7. Periksa dependensi dan SDK yang digunakan sebelum menggunakan API.
8. Gunakan implementasi paling sederhana yang memenuhi kebutuhan dan aturan proyek.
9. Jangan mengarang fungsi, class, variabel, atau API yang belum diverifikasi.
10. Jangan menganggap implementasi berhasil sebelum pemeriksaan selesai.

### Komentar Kode

Setiap kode yang ditambahkan atau diubah wajib disertai komentar yang menjelaskan alasan perubahan.

Ketentuan:

1. Komentar harus menjelaskan mengapa kode ditambahkan atau diubah.
2. Gunakan bahasa Indonesia yang baik dan benar.
3. Komentar harus singkat, deskriptif, dan relevan.
4. Letakkan komentar dekat dengan kode yang dijelaskan.
5. Jangan menulis komentar yang hanya mengulang kode.
6. Jangan menambahkan komentar yang tidak memberikan informasi.
7. Jangan mengubah komentar lama yang tidak berhubungan dengan task.

Contoh:

```dart
// Normalisasi tanggal agar perhitungan hari tidak terpengaruh waktu.
final hariIni = DateTime(now.year, now.month, now.day);
```

## 9. Pemeriksaan dan Perbaikan Lint

Setelah implementasi:

1. Jalankan `flutter analyze`.
2. Periksa seluruh error dan lint yang muncul.
3. Bedakan masalah yang sudah ada sebelum perubahan dengan masalah yang disebabkan oleh implementasi.
4. Perbaiki masalah yang disebabkan oleh perubahan task.
5. Jalankan kembali `flutter analyze` setelah perbaikan.

### Batas Perbaikan

1. Maksimal 3 siklus perbaikan dan pemeriksaan untuk satu task.
2. Jika setelah 3 siklus masalah belum terselesaikan, hentikan pengerjaan task tersebut.
3. Jangan melakukan percobaan perbaikan tanpa batas.
4. Kembalikan seluruh perubahan kode yang dibuat khusus untuk task tersebut ke kondisi sebelum implementasi.
5. Gunakan backup yang telah dibuat sebagai acuan pemulihan.
6. Jangan mengembalikan perubahan milik pengguna atau pekerjaan lain yang sudah ada sebelumnya.
7. Setelah rollback, verifikasi kembali kondisi file.
8. Perbarui status task menjadi `Dilewati`.
9. Jelaskan lint atau error yang tidak berhasil diselesaikan.

### Standar Hasil Analyze

Target akhir adalah `flutter analyze` bersih tanpa error maupun lint.

Apabila sebelum implementasi sudah terdapat masalah:

- Catat masalah awal beserta jumlah dan lokasinya.
- Jangan mengklaim masalah awal sebagai akibat implementasi.
- Jangan memperbaiki masalah yang tidak berhubungan dengan task.
- Pastikan perubahan task tidak menambah masalah baru.
- Laporkan apabila kondisi awal repositori membuat target bersih belum dapat dicapai.

## 10. Penanganan Task yang Sudah Diimplementasikan

Apabila setelah pemeriksaan kode aktual ditemukan bahwa task sudah diimplementasikan:

1. Jangan mengulang implementasi.
2. Verifikasi bahwa masalah benar-benar sudah diselesaikan.
3. Pastikan implementasi yang tersedia sesuai dengan solusi dan aturan repositori.
4. Jalankan pemeriksaan yang relevan.
5. Perbarui status menjadi `Selesai`.
6. Berikan penjelasan bahwa task sudah diimplementasikan sebelumnya.

Task tersebut tetap dihitung sebagai satu dari lima task.

## 11. Pembaruan task.md Setelah Setiap Task

**Ini merupakan kewajiban dan tidak boleh ditunda sampai seluruh task selesai.**

Setelah satu task selesai atau dilewati:

1. Buat backup terbaru `task.md` sebelum mengeditnya.
2. Perbarui status task tersebut.
3. Jika berhasil, ubah status menjadi `Selesai`.
4. Jika tidak dapat dilanjutkan, ubah status menjadi `Dilewati`.
5. Berikan alasan yang jelas untuk setiap task berstatus `Dilewati`.
6. Jangan mengubah status task lainnya.
7. Pertahankan struktur dan format penulisan `task.md`.
8. Jangan menghapus deskripsi masalah, solusi, referensi aturan, atau file bermasalah yang masih relevan.
9. Verifikasi perubahan `task.md` setelah disimpan.

Apabila task dilewati, penjelasan wajib menyebutkan alasan spesifik, misalnya:

- Dilewati karena file sedang terbuka di editor.
- Dilewati karena backup gagal dibuat.
- Dilewati karena lint error tidak berhasil diselesaikan setelah tiga siklus perbaikan.
- Dilewati karena kondisi aktual tidak sesuai dengan deskripsi task dan membutuhkan keputusan pengguna.

Jangan menggunakan alasan umum seperti "tidak bisa dikerjakan".

## 12. Aturan Keamanan Perubahan dan Rollback

1. Jangan menghapus perubahan pengguna yang sudah ada.
2. Jangan melakukan `git reset --hard`.
3. Jangan melakukan `git checkout -- .` atau perintah lain yang dapat membuang perubahan di luar task.
4. Jangan mengembalikan seluruh repositori hanya untuk membatalkan satu task.
5. Lakukan rollback hanya pada perubahan yang dibuat selama pengerjaan task tersebut.
6. Gunakan backup sebagai acuan pemulihan.
7. Periksa status Git sebelum dan sesudah perubahan.
8. Jangan menghapus file backup selama sesi pengerjaan.

## 13. Aturan Tambahan Anti-Salah-Seleksi

Bagian ini merupakan pengaman utama agar AI tidak mengerjakan task yang tidak diizinkan.

1. Sebelum memulai setiap task, baca kembali nilai status task dari `task.md`.
2. Pastikan statusnya tepat `Implementasikan`.
3. Jangan menggunakan interpretasi semantik untuk menyamakan status yang berbeda.
4. Jangan menganggap kata "kerjakan", "belum", atau "setengah" sebagai izin implementasi.
5. Jangan memilih task yang hanya memiliki prioritas Tinggi apabila statusnya bukan `Implementasikan`.
6. Jangan menjalankan implementasi berdasarkan rekomendasi solusi apabila status task tidak mengizinkan.
7. Jangan mengubah status task untuk menghindari aturan seleksi.
8. Apabila terdapat ketidaksesuaian format status, jangan menebak maksud pengguna.
9. Laporkan task yang statusnya tidak sesuai dan jangan mengerjakannya.
10. Aturan seleksi ini memiliki prioritas lebih tinggi daripada pertimbangan AI sendiri mengenai task yang dianggap penting atau mudah dikerjakan.

**Keputusan akhir mengenai task yang boleh diimplementasikan ditentukan oleh status eksplisit dalam `task.md`, bukan penilaian AI.**

## 14. Laporan Setiap Task

Setelah setiap task diproses, catat:

- Nomor urutan pengerjaan, misalnya 1/5.
- Nama kelompok dan nomor task.
- Status awal.
- Status akhir.
- File yang diperiksa.
- File yang diubah.
- File backup yang dibuat.
- Hasil implementasi atau alasan dilewati.
- Hasil `flutter analyze`.
- Informasi rollback apabila dilakukan.

## 15. Laporan Akhir Sesi

Setelah maksimal 5 task diperiksa, buat laporan dengan format:

### Ringkasan

- Total task diperiksa: X/5
- Berhasil diimplementasikan: X
- Sud
