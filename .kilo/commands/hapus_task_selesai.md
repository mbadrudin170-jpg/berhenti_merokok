---
description: Hapus task yang sudah selesai atau implementasinya telah terbukti tuntas dari task.md.
agent: code
---

<!-- Lokasi file di repository: .kilo/commands/hapus_task_selesai.md -->

# Prompt: Bersihkan Task yang Sudah Selesai

## 1. Tujuan

Bersihkan daftar pekerjaan pada file `task.md` dengan menghapus dua jenis task:

1. Task yang statusnya sudah dinyatakan **Selesai**.
2. Task yang statusnya belum dinyatakan selesai, tetapi setelah diperiksa ternyata seluruh implementasinya sudah benar-benar dikerjakan dan memenuhi kebutuhan task tersebut.

Tujuan akhir adalah memastikan `task.md` hanya berisi pekerjaan yang memang masih perlu diselesaikan.

**Penting:** Jangan menghapus task hanya karena terlihat pernah dikerjakan. Untuk task yang belum berstatus selesai, wajib periksa implementasi aktual pada kode proyek sebelum mengambil keputusan.

## 2. Aturan Membaca Repository

Sebelum memulai pekerjaan:

1. Pastikan direktori aktif merupakan root repository.
2. Baca seluruh isi `AGENTS.md` di root repository.
3. Ikuti instruksi dan referensi aturan yang terdapat di `AGENTS.md`.
4. Baca aturan global dan aturan khusus proyek yang relevan dengan task yang akan diverifikasi.
5. Periksa apakah terdapat `AGENTS.md` tambahan pada direktori kode yang berkaitan.
6. Baca seluruh isi `task.md` agar memahami struktur dan semua task yang tercatat.
7. Baca dokumentasi atau catatan teknis yang relevan apabila diperlukan untuk memahami maksud task.

Jangan mengambil keputusan berdasarkan ingatan dari sesi sebelumnya, ringkasan AI, atau asumsi mengenai kondisi kode.

Gunakan kondisi repository dan implementasi aktual ketika command dijalankan.

## 3. Pemeriksaan Kondisi Awal

Sebelum mengubah `task.md`:

1. Periksa branch dan commit HEAD.
2. Periksa kondisi Git menggunakan `git status --short`.
3. Periksa perubahan sebelumnya pada `task.md` menggunakan `git diff -- task.md` dan `git diff --cached -- task.md`.
4. Pastikan tidak ada perubahan lokal pengguna pada `task.md` yang berisiko tertimpa.

Apabila terdapat perubahan staged atau unstaged pada `task.md` yang belum di-commit, hentikan pengeditan dan laporkan kondisi tersebut. Jangan menimpa atau menggabungkan perubahan pengguna berdasarkan asumsi.

Jangan mengubah file sebelum seluruh pemeriksaan awal selesai.

## 4. Identifikasi Task yang Sudah Selesai

Baca seluruh task dan identifikasi status masing-masing berdasarkan struktur yang benar-benar digunakan dalam `task.md`.

Penanda penyelesaian dapat berupa:

- `[x]`
- `Status: Selesai`
- `Status: Done`
- `Status: Completed`
- Penanda lain yang secara eksplisit menyatakan bahwa task telah selesai.

Sesuaikan dengan format aktual file. Jangan menganggap kata-kata tersebut sebagai status apabila hanya muncul dalam deskripsi atau pembahasan task.

**Aturan keputusan:**

| Kondisi task                                                    | Tindakan                 |
| --------------------------------------------------------------- | ------------------------ |
| Status secara eksplisit Selesai                                 | Hapus task               |
| Status belum selesai, tetapi implementasi terbukti sudah tuntas | Hapus task               |
| Status Dikerjakan, tetapi implementasi baru sebagian            | Pertahankan              |
| Status Belum dan implementasi belum tersedia                    | Pertahankan              |
| Implementasi belum dapat dipastikan                             | Pertahankan              |
| Status atau struktur task ambigu                                | Pertahankan dan laporkan |

Jangan mengubah status task menjadi Selesai sebagai pengganti penghapusan.

## 5. Verifikasi Task yang Belum Berstatus Selesai

Untuk setiap task yang belum mempunyai status selesai, periksa apakah implementasinya sudah benar-benar tersedia.

Lakukan langkah berikut:

### A. Pahami kebutuhan task

1. Baca deskripsi masalah.
2. Pahami solusi atau hasil yang diharapkan.
3. Identifikasi file yang terdampak.
4. Identifikasi fungsi, class, widget, provider, notifier, database, atau komponen lain yang berkaitan.
5. Tentukan kriteria yang harus terpenuhi agar task dapat dianggap selesai.

Jangan mengurangi atau mengubah maksud task saat melakukan verifikasi.

### B. Periksa implementasi aktual

1. Buka file kode yang berkaitan.
2. Periksa apakah perubahan yang diminta benar-benar sudah diterapkan.
3. Telusuri hubungan implementasi dengan bagian lain yang menggunakannya.
4. Periksa apakah fungsi atau fitur sudah terhubung dengan alur aplikasi yang seharusnya.
5. Periksa kemungkinan adanya placeholder, implementasi sementara, atau kode yang belum selesai.
6. Periksa apakah implementasi masih mempunyai kekurangan terhadap kebutuhan task.
7. Baca pengujian yang relevan apabila tersedia.
8. Gunakan hasil pengujian atau bukti teknis lainnya sebagai pendukung kesimpulan apabila diperlukan.

Jangan hanya mengandalkan pencarian nama fungsi, nama file, class, variabel, atau komentar yang mirip dengan deskripsi task.

Keberadaan kode tidak otomatis membuktikan bahwa task sudah selesai.

### C. Tentukan hasil verifikasi

Task hanya boleh dihapus apabila seluruh kebutuhan yang dijelaskan telah terpenuhi.

Gunakan kriteria berikut:

**Hapus apabila:**

- Seluruh implementasi yang diminta sudah tersedia.
- Implementasi sudah terhubung dengan alur aplikasi yang diperlukan.
- Tidak ada bagian kebutuhan task yang masih tertunda.
- Tidak ditemukan placeholder atau implementasi sementara yang menunjukkan pekerjaan belum selesai.
- Bukti dari kode aktual cukup untuk memastikan penyelesaian.

**Pertahankan apabila:**

- Implementasi baru selesai sebagian.
- Masih ada kebutuhan yang belum dikerjakan.
- Kode baru berupa kerangka atau placeholder.
- Implementasi belum terhubung dengan bagian aplikasi yang seharusnya.
- Implementasi belum memenuhi tujuan task.
- Terdapat keraguan atau bukti belum mencukupi.
- Verifikasi tidak dapat dilakukan.

**Prinsip utama: Lebih baik mempertahankan task yang masih meragukan daripada menghapus pekerjaan yang sebenarnya belum selesai.**

## 6. Penanganan Task Induk dan Task Turunan

Perhatikan hubungan hierarki antar-task.

1. Task turunan yang sudah selesai boleh dihapus secara independen.
2. Task turunan yang belum selesai wajib dipertahankan.
3. Task induk hanya boleh dihapus apabila seluruh kebutuhan dan task turunannya sudah selesai.
4. Jika task induk dinyatakan selesai tetapi masih terdapat task turunan yang belum selesai, jangan langsung menghapus task induk. Pertahankan struktur yang diperlukan dan laporkan ketidaksesuaian status tersebut.
5. Jangan menghapus task yang masih menjadi konteks penting bagi pekerjaan turunan yang belum selesai.

Jangan menghapus kelompok, kategori, atau catatan bersama apabila masih diperlukan oleh task lain.

## 7. Memperbarui task.md

Setelah seluruh task diperiksa, lakukan penghapusan pada file:

`task.md`

Ketentuan:

1. Hapus seluruh task yang secara eksplisit berstatus selesai.
2. Hapus task yang belum berstatus selesai apabila implementasinya terbukti sudah tuntas.
3. Pertahankan semua task yang masih perlu dikerjakan.
4. Pertahankan deskripsi dan maksud task yang tersisa tanpa perubahan.
5. Pertahankan urutan task yang masih tersisa.
6. Pertahankan kategori, prioritas, dan struktur pengelompokan.
7. Pertahankan informasi file terdampak apabila masih relevan dengan task yang tersisa.
8. Jangan menambahkan task baru.
9. Jangan mengubah solusi atau rekomendasi task yang masih tersisa.
10. Jangan mengubah status task yang tersisa.
11. Jangan menghapus informasi lain yang bukan bagian dari task selesai.
12. Jangan menulis ulang seluruh file apabila cukup menghapus blok task tertentu.

Apabila setelah penghapusan terdapat kelompok atau kategori kosong, pertahankan struktur aslinya kecuali penghapusan bagian tersebut benar-benar diperlukan dan tidak menghilangkan informasi pengguna.

## 8. Larangan

1. Dilarang mengubah kode Dart atau kode sumber bahasa pemrograman lainnya.
2. Dilarang mengubah file selain `task.md`.
3. Dilarang mengimplementasikan task yang belum selesai.
4. Dilarang memperbaiki bug atau melakukan refactoring.
5. Dilarang mengubah konfigurasi, dependency, database, atau file pengujian.
6. Dilarang menghapus task hanya berdasarkan kemiripan nama atau deskripsi.
7. Dilarang menghapus task yang implementasinya baru selesai sebagian.
8. Dilarang menghapus task apabila bukti penyelesaiannya belum cukup.
9. Dilarang mengubah maksud atau deskripsi task yang masih tersisa.
10. Dilarang mengubah urutan, prioritas, atau kategori task yang masih tersisa.
11. Dilarang menghapus catatan atau informasi lain yang bukan merupakan task selesai.
12. Dilarang mengubah status task menjadi selesai sebagai pengganti penghapusan.
13. Dilarang menghapus, menimpa, atau membatalkan perubahan lokal pengguna.
14. Dilarang membuat file backup, laporan, atau file tambahan.
15. Dilarang melakukan commit, push, reset, rebase, checkout, switch, merge, atau operasi Git lain yang mengubah repository.
16. Dilarang menjalankan perintah terminal atau skrip untuk mengedit isi file secara langsung.
17. Dilarang menyatakan task telah selesai tanpa bukti implementasi aktual.

## 9. Ketentuan Pelaksanaan

1. Fokus hanya pada pembersihan task yang sudah selesai.
2. Gunakan kode aktual sebagai dasar verifikasi task yang belum berstatus selesai.
3. Jika task membutuhkan pemeriksaan beberapa file, telusuri seluruh alur yang relevan.
4. Jika bukti belum cukup, pertahankan task.
5. Jangan membuat asumsi untuk menyelesaikan ambiguitas.
6. Jangan menambah ruang lingkup pekerjaan.
7. Gunakan tool edit untuk menghapus bagian tertentu dari `task.md`.
8. Pertahankan seluruh isi file yang tidak termasuk dalam penghapusan.
9. Apabila tidak ada task yang memenuhi kriteria penghapusan, jangan mengubah `task.md`.
10. Hentikan pekerjaan jika ditemukan kondisi yang membuat perubahan tidak aman.

## 10. Pemeriksaan Akhir

Setelah penghapusan:

1. Baca kembali seluruh isi `task.md`.
2. Pastikan semua task yang berstatus selesai sudah dihapus.
3. Pastikan task yang implementasinya sudah tuntas juga sudah dihapus.
4. Pastikan task yang belum selesai tidak ikut terhapus.
5. Pastikan tidak ada perubahan pada deskripsi, kategori, prioritas, dan urutan task yang tersisa.
6. Pastikan struktur kelompok tetap konsisten.
7. Periksa `git diff -- task.md`.
8. Periksa `git status --short`.
9. Pastikan tidak ada file selain `task.md` yang berubah akibat command ini.
10. Pastikan perubahan sebelumnya milik pengguna tetap terjaga.

Jika pemeriksaan akhir menemukan task yang seharusnya dipertahankan tetapi telah terhapus, batalkan hanya penghapusan yang dilakukan oleh command ini dengan mempertahankan seluruh perubahan pengguna. Jika pemulihan tidak aman, hentikan dan laporkan masalahnya.

## 11. Laporan Hasil

Setelah pekerjaan selesai, berikan laporan dengan format berikut.

### A. Ringkasan

- Jumlah seluruh task yang diperiksa.
- Jumlah task yang dihapus karena berstatus selesai.
- Jumlah task yang dihapus karena implementasinya sudah selesai tetapi status belum diperbarui.
- Jumlah task yang dipertahankan.

### B. Daftar Task yang Dihapus

Untuk setiap task, tampilkan:

- Nama atau deskripsi task.
- Status sebelumnya.
- Alasan penghapusan.
- Untuk task yang belum berstatus selesai, bukti implementasi berupa path file dan nama fungsi, class, atau komponen terkait.

### C. Daftar Task yang Dipertahankan

Untuk setiap task yang masih ada, tampilkan:

- Nama atau deskripsi task.
- Status.
- Alasan dipertahankan.
- Bagian implementasi yang masih belum selesai atau belum dapat diverifikasi.

### D. Status Perubahan

Sampaikan:

- Apakah `task.md` berhasil diperbarui.
- Apakah perubahan hanya terjadi pada `task.md`.
- Apakah masih ada task yang perlu dikerjakan.
- Apakah terdapat kondisi yang menghambat pembersihan.
- Apabila tidak ada task yang dihapus, jelaskan alasannya.

**Kriteria keberhasilan:** `task.md` hanya kehilangan task yang benar-benar sudah selesai. Seluruh task yang masih membutuhkan pekerjaan atau belum mempunyai bukti penyelesaian harus tetap dipertahankan.
