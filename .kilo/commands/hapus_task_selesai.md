---
description: Hapus task yang sudah selesai atau telah diimplementasikan dari task.md
agent: code
---

# Prompt

Bersihkan daftar task pada file `task.md` dengan menghapus task yang memenuhi salah satu kondisi berikut:

1. Task yang statusnya sudah dinyatakan selesai di `task.md`.
2. Task yang belum ditandai selesai, tetapi implementasinya sudah benar-benar selesai dan sesuai dengan tujuan serta kebutuhan yang dijelaskan dalam task tersebut.

Untuk task yang belum ditandai selesai, jangan langsung menghapusnya. Periksa kode sumber proyek untuk memastikan implementasinya benar-benar sudah tersedia dan berfungsi sesuai maksud task.

Tujuan utama perintah ini adalah memastikan `task.md` hanya berisi task yang masih perlu dikerjakan.

# Ruang Lingkup

1. File utama yang boleh diubah:
   - `task.md`

2. File yang boleh dibaca untuk memverifikasi implementasi:
   - Kode sumber proyek.
   - File pengujian yang berkaitan.
   - Dokumentasi teknis yang relevan.

3. Seluruh perubahan hanya boleh dilakukan pada `task.md`.

4. Jangan mengubah file kode, pengujian, dokumentasi, konfigurasi, maupun file lainnya.

# Prosedur

## 1. Periksa task.md

- Baca seluruh isi `task.md` terlebih dahulu.
- Pahami struktur, kategori, pengelompokan, hierarki, dan format penulisan task.
- Identifikasi seluruh task yang statusnya sudah selesai.
- Identifikasi task yang belum ditandai selesai dan perlu diperiksa implementasinya.
- Jangan hanya membaca sebagian isi file.

## 2. Identifikasi task yang sudah selesai

Hapus task yang secara eksplisit memiliki status selesai.

Kenali penanda penyelesaian berdasarkan format yang digunakan dalam `task.md`, misalnya:

- `[x]`
- `Selesai`
- `Done`
- `Completed`

Sesuaikan pemeriksaan dengan struktur dan format status yang benar-benar digunakan dalam file.

Jangan menganggap task berstatus dikerjakan, proses, tertunda, atau belum dikerjakan sebagai task selesai.

## 3. Verifikasi task yang belum ditandai selesai

Untuk setiap task yang belum berstatus selesai:

1. Pahami tujuan dan maksud task secara menyeluruh.
2. Identifikasi kriteria atau hasil yang harus dicapai berdasarkan deskripsi task.
3. Telusuri kode sumber yang berkaitan dengan kebutuhan task tersebut.
4. Periksa apakah implementasinya benar-benar sudah tersedia.
5. Pastikan implementasi memenuhi seluruh kebutuhan yang dijelaskan dalam task.
6. Periksa keterhubungan implementasi dengan bagian lain yang diperlukan agar fitur atau perbaikan benar-benar dapat digunakan.

Jangan hanya menyimpulkan task sudah selesai karena menemukan nama fungsi, class, variabel, widget, atau file yang mirip dengan deskripsi task.

Jika tersedia, gunakan kode pengujian yang relevan sebagai informasi pendukung untuk memverifikasi implementasi.

## 4. Tentukan apakah task boleh dihapus

Hapus task yang belum ditandai selesai hanya apabila seluruh kebutuhan task sudah terbukti diimplementasikan.

Pertahankan task apabila ditemukan kondisi berikut:

- Implementasi baru selesai sebagian.
- Masih ada kebutuhan yang belum diimplementasikan.
- Kode hanya berupa kerangka, placeholder, atau implementasi sementara.
- Implementasi belum terhubung dengan bagian yang seharusnya menggunakannya.
- Hasil implementasi belum memenuhi maksud task.
- Bukti implementasi tidak cukup untuk memastikan task sudah selesai.
- AI masih memiliki keraguan apakah task benar-benar sudah terpenuhi.

Apabila terdapat keraguan, jangan menghapus task tersebut.

## 5. Perbarui task.md

Setelah seluruh task diperiksa:

- Hapus task yang sudah memenuhi kriteria penghapusan.
- Jangan sekadar mengubah status task menjadi selesai. Task yang memenuhi kriteria harus benar-benar dihapus dari daftar.
- Pertahankan seluruh task yang masih perlu dikerjakan.
- Pertahankan deskripsi task yang belum selesai tanpa mengubah maksudnya.
- Pertahankan urutan, hierarki, dan format penulisan task yang masih tersisa.
- Jangan menghapus catatan atau informasi lain yang bukan merupakan task selesai.
- Jangan mengubah kategori atau menyusun ulang task yang masih tersisa.

Jika sebuah task induk memiliki beberapa task turunan:

- Hapus task turunan yang sudah selesai secara independen.
- Hapus task induk hanya apabila seluruh kebutuhan dan seluruh task turunannya sudah selesai.
- Pertahankan task induk apabila masih ada bagian yang belum selesai.

## 6. Pemeriksaan akhir

Setelah memperbarui `task.md`:

1. Baca kembali seluruh isi file.
2. Pastikan semua task yang seharusnya dihapus sudah tidak ada.
3. Pastikan tidak ada task yang belum selesai ikut terhapus.
4. Pastikan struktur dan format file tetap konsisten.
5. Pastikan tidak ada file lain yang berubah akibat menjalankan perintah ini.
6. Periksa perubahan akhir menggunakan Git apabila proyek menggunakan Git.

# Larangan

1. Dilarang mengubah kode sumber proyek.
2. Dilarang mengubah file selain `task.md`.
3. Dilarang mengimplementasikan task yang belum selesai.
4. Dilarang memperbaiki bug atau melakukan refactoring.
5. Dilarang menghapus task hanya berdasarkan perkiraan atau kemiripan nama.
6. Dilarang menghapus task yang implementasinya baru selesai sebagian.
7. Dilarang menghapus task yang bukti penyelesaiannya belum cukup.
8. Dilarang mengubah deskripsi task yang masih tersisa tanpa alasan.
9. Dilarang mengubah urutan atau kategori task yang masih tersisa.
10. Dilarang menghapus catatan, rencana, atau informasi lain yang bukan task selesai.
11. Dilarang mengubah status task menjadi selesai sebagai pengganti penghapusan.
12. Dilarang menghapus atau membatalkan perubahan milik pengguna yang sudah ada sebelumnya.
13. Dilarang melakukan commit atau push Git.

# Ketentuan

1. Gunakan kondisi proyek dan kode sumber yang tersedia saat perintah dijalankan. Jangan mengandalkan ingatan dari sesi sebelumnya untuk menyatakan suatu task sudah diimplementasikan.
2. Periksa perubahan yang sudah ada pada `task.md` sebelum mengedit agar perubahan milik pengguna tidak tertimpa atau hilang.
3. Gunakan bukti dari kode sumber untuk menentukan apakah task yang belum ditandai selesai benar-benar sudah diimplementasikan.
4. Apabila implementasi task belum dapat dipastikan, pertahankan task tersebut.
5. Jangan menambahkan task baru.
6. Jangan mengubah cakupan atau maksud task yang masih tersisa.
7. Jangan menjalankan pemeriksaan atau pengujian yang tidak berkaitan dengan verifikasi task.
8. Jangan membuat file tambahan seperti backup, laporan, atau dokumentasi baru.

# Laporan Hasil

Setelah selesai, sampaikan laporan kepada pengguna dengan format berikut:

## Ringkasan

- Jumlah task yang diperiksa.
- Jumlah task yang dihapus karena sudah berstatus selesai.
- Jumlah task yang dihapus karena implementasinya sudah selesai tetapi statusnya belum diperbarui.
- Jumlah task yang dipertahankan.

## Daftar Task yang Dihapus

Untuk setiap task yang dihapus, tampilkan:

- Nama atau deskripsi task.
- Alasan penghapusan.
- Status sebelumnya.
- Untuk task yang belum ditandai selesai, sertakan bukti implementasi berupa path file dan nama fungsi, class, atau bagian kode yang relevan.

## Daftar Task yang Dipertahankan

Tampilkan task yang belum dihapus karena:

- Implementasinya belum selesai.
- Implementasinya baru sebagian.
- Bukti implementasi belum cukup.
- Penyelesaiannya masih diragukan.

Berikan alasan secara singkat untuk setiap kondisi tersebut.

## Status Perubahan

Sampaikan:

- Apakah `task.md` berhasil diperbarui.
- Apakah perubahan hanya terjadi pada `task.md`.
- Apakah masih ada task yang perlu dikerjakan.
- Apabila tidak ada task yang dihapus, jelaskan alasannya.
